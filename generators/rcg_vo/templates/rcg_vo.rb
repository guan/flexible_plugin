package <%= vo_package %>
{
  [RemoteClass(alias='<%= class_name %>')]
  [Bindable]
  public class <%= vo_class %>
  {
    <% for column in columns -%>
    public var <%= column.name %>:<%= column.to_as_type %>;
    <% end -%>
}
}
