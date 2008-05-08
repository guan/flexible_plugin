class RcgCommandGenerator < Rails::Generator::NamedBase
  default_options :base => "app/flex",
                  :ignore_create => false


  attr_reader :base_package_name,  # Command Package Name
              :command_class,
              :command_name

  def initialize(runtime_args, runtime_options={ })
    super
    @base_package_name = args[0]
    @base_package_path = @base_package_name.gsub('.', '/')

    @event_name = class_name.camelcase
    @command_class = "#{@event_name}Command"
    @command_name = "#{@base_package_name}.command.#{@command_class}"

  end

  def manifest
    record do |m|

      # Add EventNames
      command_str = "public static const #{@event_name.underscore.upcase}:String = \"#{@event_name.underscore.upcase}\";"
      event_name_path = "#{options[:base]}/#{@base_package_path}/control/EventNames.as"
      event_name_str = open("#{RAILS_ROOT}/#{event_name_path}").read

      unless event_name_str =~ /(#{Regexp.escape(command_str)})/mi
        command_reg = "public final class EventNames {"
        m.gsub_file  event_name_path,
        /(#{Regexp.escape(command_reg)})/mi do |match|
          "#{match}\n\n        #{command_str}"
        end
      end

      # Add ApplicationController
      add_command_str = "addCommand(EventNames.#{@event_name.underscore.upcase}, #{@command_class});"
      control_path = "#{options[:base]}/#{@base_package_path}/control/ApplicationController.as"
      control_str = open("#{RAILS_ROOT}/#{control_path}").read

      unless control_str =~ /(#{Regexp.escape(add_command_str)})/mi
        control_reg = "private function initializeCommands():void {"
        m.gsub_file control_path,
        /(#{Regexp.escape(control_reg)})/mi do |match|
          "#{match}\n            #{add_command_str}"
        end
      end

      unless options[:ignore_create]
        m.template 'Command.as',
                   File.join(options[:base],
                             @base_package_path,
                             'command',
                             "#{command_class}.as")
      end

    end
  end

  protected
  def banner
    "Usage: #{$0} rcg_command CommandName [command_package]"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-b", "--base=path", String, "Base path to generate Flex essentials.", "Default: #{default_options[:base]}"){ |v| options[:base] = v}
    opt.on("--skip-create", "Don't generate default command class", "Default: false"){ |v| options[:ignore_create] = v}
  end
end
