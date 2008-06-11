package <%=base_package_name %>.vo
{
  [RemoteClass(alias='<%= base_package_name %>.vo.UserVO')]
  [Bindable]
  public class UserVO
  {
        public var id:int;
        public var login:String;
        public var email:String;
        public var password:String;
    }
}
