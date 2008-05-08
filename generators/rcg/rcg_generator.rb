class RcgGenerator < Rails::Generator::NamedBase
  default_options :base => "app/flex",
                  :use_xml => false


  attr_reader :base_package_name # Base Package Name

  def initialize(runtime_args, runtime_options={ })
    super

    @base_package_name = class_name.downcase
    @base_package_path = @base_package_name.gsub('.', '/')
  end

  def manifest
    record do |m|
      m.directory File.join(options[:base]) #Flex base path
      m.directory File.join(options[:base], 'lib') #library path
      m.file 'Cairngorm.swc', File.join(options[:base], 'lib', 'Cairngorm.swc') #Copying Cairngorm library

      m.directory File.join(options[:base], @base_package_path, 'business') #business
      m.directory File.join(options[:base], @base_package_path, 'command' ) #command
      m.directory File.join(options[:base], @base_package_path, 'components' ) #components
      m.directory File.join(options[:base], @base_package_path, 'control' ) #control
      m.directory File.join(options[:base], @base_package_path, 'event') #event
      m.directory File.join(options[:base], @base_package_path, 'model') #model
      m.directory File.join(options[:base], @base_package_path, 'util') #util
      m.directory File.join(options[:base], @base_package_path, 'validators') #validator
      m.directory File.join(options[:base], @base_package_path, 'vo') #vo

      unless options[:use_xml] # Use AMF
        m.template 'ApplicationController.as',
                   File.join(options[:base],
                             @base_package_path, 'control', "ApplicationController.as")

        m.template 'ApplicationModelLocator.as',
                   File.join(options[:base],
                             @base_package_path, 'model', 'ApplicationModelLocator.as')
        m.template 'CairngormUtils.as',
                   File.join(options[:base],
                             @base_package_path, 'util', 'CairngormUtils.as')
        m.template 'DebugMessage.as',
                   File.join(options[:base],
                             @base_package_path, 'util', 'DebugMessage.as')
        m.template 'EventNames.as',
                   File.join(options[:base],
                             @base_package_path, 'control', "EventNames.as")
        m.template 'Services.mxml',
                   File.join(options[:base],
                             @base_package_path, 'business', "Services.mxml")
      end

    end
  end

  protected
  def banner
    "Usage: #{$0} rcg [base_package]"
  end

  def add_options!(opt)
    opt.separator ''
    opt.separator 'Options:'
    opt.on("-b", "--base=path", String, "Base path to generate Flex essentials.", "Default: #{default_options[:base]}"){ |v| options[:base] = v}

    opt.on("--use_xml", "Using xml to comunicate to server", "Default: false"){ |v| options[:use_xml] = v}
  end
end
