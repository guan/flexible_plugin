require 'rcg/rcg_generator_base'

class RcgClassMappingGenerator < Rails::Generator::NamedBase
  default_options :base => "app/flex"

  def initialize(runtime_args, runtime_options={ })
    super
    columns = class_name.constantize.columns
    @columns = []

    columns.each do |column|
      if ignore_field? column.name
        next
      end
      @columns.push column.name.center(column.name.length+2, "\"")
    end
    @vo_name = args[0]
  end

  def manifest
    record do |m|
      puts "################################"
      puts "ClassMappings generated"
      puts "Copy below texts to "
      puts " your config/rubyamf_confing.rb"
      puts "################################"

      puts "ClassMappings.register("
      puts "  :actionscript => '#{@vo_name}',"
      puts "  :ruby => '#{class_name}',"
      puts "  :type => 'active_record',"
      puts "  :attributes => ["
      puts "    #{@columns.join(",\n    ")}"
      puts "  ]"
      puts ")"
    end
  end

  protected
  def banner
    "Usage: #{$0} rcg_class_mapping [Model] [Vo(full package)]"
  end

  def ignore_field?(field)
    case field
      when 'created_at'
        return true
      when 'updated_at'
        return true
    end
    return false
  end
end
