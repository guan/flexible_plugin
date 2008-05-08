require 'rcg/rcg_generator_base'

class RcgModelGenerator < RcgGeneratorBase

  default_options :base => "app/flex",
                  :ignore_timestamps => true

  def initialize(runtime_args, runtime_options={ })
    super
  end

  def manifest
    record do |m|

      m.directory File.join(options[:base]) #Flex base path
      m.directory File.join(options[:base], slashize(@model_package))

      m.template 'rcg_model_base.rb',
                 File.join(options[:base],
                           slashize(@model_package),
                           "#{@model_class}Base.as")
      m.template 'rcg_model.rb',
                 File.join(options[:base],
                           slashize(@model_package),
                           "#{@model_class}.as")
    end
  end

  protected
  def banner
    "Usage: #{$0} rcg_model ModelName [Vo fullpath] [Model fullpath]"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-b", "--base=path", String, "Base path to generate Flex Model.", "Default: #{default_options[:base]}"){ |v| options[:base] = v}

    opt.on("--ignore_timestamps", "Ignore to generate created_at and updated_at columns", "Default: true"){ |v| options[:ignore_timestamps] = v}
  end
end
