package <%= model_package %>
{
  import <%= vo_name %>;
  import mx.utils.ObjectUtil;

  [Bindable]
  public class <%= model_class %>Base
  {

    /**
     * private instance of a <%= model_class %> Value Object
     */
    private var vo:<%= vo_class %> = new <%= vo_class %>();

    /**
     * Bindable accessor methods to enforce business logic
     */
<% for column in columns -%>
    public function set <%= column.name %>(value:<%=column.to_as_type%>):void { vo.<%= column.name %> = value;}
    public function get <%= column.name %>():<%=column.to_as_type%> { return vo.<%= column.name %>;}
<% end -%>

    /**
     * Return a new <%= vo_class %> instance from the private instance vo
     */

    public function toVO():<%=vo_class%>
    {
      var newVo:<%=vo_class%> = new <%=vo_class%>();
<% for column in columns -%>
      newVo.<%= column.name %> = <%= column.name %>;
<% end -%>
      return newVo;
    }

     /**
      * Return a <%= model_class %> instance with values from a <%= vo_class %> instance
      */
    public static function fromVO(vo:<%=vo_class%>):<%=model_class%>
    {
      var mo:<%= model_class %> = new <%= model_class %>();
<% for column in columns -%>
      mo.<%=column.name %> = vo.<%= column.name %>;
<% end -%>
      return mo;
    }

  }
}
