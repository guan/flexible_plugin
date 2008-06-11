class RcgColumn
  attr_accessor :name,
                :type

  def to_as_type
    case type
      when :string
        return "String"
      when :integer
        return "int"
      when :boolean
        return "Boolean"
      when :float
        return "Number"
      else
        return "String"
    end
  end

  def self.columns(class_name, options={ })
    columns_array = "#{class_name}".constantize.columns

    columns_list = []
    columns_array.each do |column|
      if ignore_field? column.name
        next
      end

      if options[:ignore]
        if options[:ignore].include?(column.name)
          next
        end
      end

      c = RcgColumn.new
      c.name = column.name
      c.type = column.type
      columns_list.push c
    end
    columns_list
  end

  def self.ignore_field?(field)
    case field
      when 'created_at'
        return true
      when 'updated_at'
        return true
    end
    return false
  end
end
