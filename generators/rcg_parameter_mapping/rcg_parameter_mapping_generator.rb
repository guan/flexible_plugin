require 'rcg/rcg_generator_base'

class RcgParameterMappingGenerator < Rails::Generator::NamedBase
  default_options :base => "app/flex"

  attr_reader :class_name

  def initialize(runtime_args, runtime_options={ })
    super
    @class_name = class_name
  end

  def manifest

    model_name = @class_name.camelize
    model_name_s = model_name.downcase

    record do |m|
      puts "################################"
      puts "ParameterMappings generated"
      puts "Copy text blow to "
      puts " your config/rubyamf_confing.rb"
      puts "################################"

      mapping = <<-EOS
ParameterMappings.register(:controller => :#{model_name}sController,
                           :action => :create,
                           :params => {:#{model_name_s} => "[0].attributes"})
ParameterMappings.register(:controller => :#{model_name}sController,
                           :action => :update,
                           :params => {:id => "[0]", :#{model_name_s} => "[1].attributes"})
ParameterMappings.register(:controller => :#{model_name}sController,
                           :action => :destroy,
                           :params => {:id => "[0]"})
EOS

      puts mapping
    end
  end

  protected
  def banner
    "Usage: #{$0} rcg_parameter_mapping [Model]"
  end

end
