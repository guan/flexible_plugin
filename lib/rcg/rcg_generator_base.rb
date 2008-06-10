require 'rcg/rcg_column'

class RcgGeneratorBase < Rails::Generator::NamedBase

  attr_reader :model_name, # Model class name with package
              :model_class, # Model class name with package
              :model_package, # Model package name
              :vo_name,  #  Vo class name with pakage
              :vo_class, #  Vo class name without package
              :vo_package, # Vo package name
              :columns # columns from ActiveRecord

  def initialize(runtime_args, runtime_options={ })
    super

    @vo_name = args[0]
    @vo_class = split_class @vo_name
    @vo_package = to_package_name @vo_name, @vo_class

    if args[1]
      @model_name = args[1]
      @model_class = split_class @model_name
      @model_package = to_package_name @model_name, @model_class
    end

    @columns = RcgColumn.columns class_name
  end

  def split_class name
    name.split('.').last
  end

  def to_package_name(name, klass_name)
    name.sub(".#{klass_name}", '').strip
  end

  def slashize name
    name.gsub('.', '/')
  end

end
