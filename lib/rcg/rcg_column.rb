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
end
