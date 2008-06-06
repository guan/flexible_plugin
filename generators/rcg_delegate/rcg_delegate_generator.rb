class RcgDelegateGenerator < Rails::Generator::NamedBase

  default_options :base => "app/flex",
                  :ignore_timestamps => true

  attr_reader :base_package_name,
              :model_class,
              :model_name

  def initialize(runtime_args, runtime_options={ })
    super

    @base_package_name = args[0]
    @base_package_path = @base_package_name.gsub('.', '/')

    @model_class = "#{class_name.camelcase}"
    @model_name = "#{@base_package_name}.model.#{@model_class}"
  end

  def manifest
    record do |m|
      m.template 'Delegate.as',
                   File.join(options[:base],
                             @base_package_path,
                             'business',
                             "#{@model_class}Delegate.as")
    end
  end

  protected
  def banner
    "Usage: #{$0} rcg_delegate ModelName [BasePackage]"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-b", "--base=path", String, "Base path to generate Flex Model.", "Default: #{default_options[:base]}"){ |v| options[:base] = v}

    opt.on("--ignore_timestamps", "Ignore to generate created_at and updated_at columns", "Default: true"){ |v| options[:ignore_timestamps] = v}
  end
end
