class RcgScaffoldGenerator < Rails::Generator::NamedBase
  default_options :base => "app/flex",
                  :use_xml => false


  attr_reader :base_package_name,  # Base Package Name
              :vo_class,
              :vo_name,
              :model_class,
              :model_name

  def initialize(runtime_args, runtime_options={ })
    super
    @base_package_name = args[0]
    @base_package_path = @base_package_name.gsub('.', '/')

    @vo_class = "#{class_name.camelcase}VO"
    @vo_name = "#{@base_package_name}.vo.#{@vo_class}"

    @model_class = "#{class_name.camelcase}"
    @model_name = "#{@base_package_name}.model.#{@model_class}"

  end

  def manifest
    record do |m|

      m.dependency 'rcg', [@base_package_name]

      unless options[:use_xml] # Use AMF
#        p "#{@base_package_name}.#{class_name.camelcase}VO"
        m.dependency 'rcg_vo', [class_name, "#{@vo_name}"] + args
        m.dependency 'rcg_model', [class_name, "#{@vo_name}", "#{@model_name}"] + args
        # scaffold stuff

        # Delegate
        m.template 'Delegate.as',
                   File.join(options[:base],
                             @base_package_path,
                             'business',
                             "#{@model_class}Delegate.as")

        # CreateCommand
        m.template 'CreateCommand.as',
                   File.join(options[:base],
                             @base_package_path,
                             'command',
                             "Create#{@model_class}Command.as")

        m.dependency 'rcg_command', ["Create#{@model_class}", "#{base_package_name}", "--skip-create"]

        # ListCommand
        m.template 'ListCommand.as',
                   File.join(options[:base],
                             @base_package_path,
                             'command',
                             "List#{@model_class.pluralize}Command.as")

        m.dependency 'rcg_command', ["List#{@model_class}", "#{base_package_name}", "--skip-create"]

        # UpdateCommand
        m.template 'UpdateCommand.as',
                   File.join(options[:base],
                             @base_package_path,
                             'command',
                             "Update#{@model_class}Command.as")

        m.dependency 'rcg_command', ["Update#{@model_class}", "#{base_package_name}", "--skip-create"]

        # DestroyCommand
        m.template 'DestroyCommand.as',
                   File.join(options[:base],
                             @base_package_path,
                             'command',
                             "Destroy#{@model_class}Command.as")

        m.dependency 'rcg_command', ["Destroy#{@model_class}", "#{base_package_name}", "--skip-create"]

        m.dependency 'rcg_class_mapping', [@model_class, "#{vo_name}"]
      end

    end
  end

  protected
  def banner
    "Usage: #{$0} rcg_scaffold ModelName [base_package]"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-b", "--base=path", String, "Base path to generate Flex essentials.", "Default: #{default_options[:base]}"){ |v| options[:base] = v}

    opt.on("--use_xml", "Using xml to comunicate to server", "Default: false"){ |v| options[:use_xml] = v}
  end
end
