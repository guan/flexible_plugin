package <%= base_package_name %>.model
{
  import <%= base_package_name %>.vo.UserVO;

  [Bindable]
  public class UserBase
  {

    /**
     * private instance of a User Value Object
     */
    private var vo:UserVO = new UserVO();

    /**
     * Bindable accessor methods to enforce business logic
     */
    public function set id(value:int):void { vo.id = value;}
    public function get id():int { return vo.id;}
    public function set login(value:String):void { vo.login = value;}
    public function get login():String { return vo.login;}
    public function set email(value:String):void { vo.email = value;}
    public function get email():String { return vo.email;}
    public function get password():String { return vo.password}
    public function set password(value:String):void {vo.password = value;}


    /**
     * Return a new UserVO instance from the private instance vo
     */

    public function toVO():UserVO
    {
      var newVo:UserVO = new UserVO();
      newVo.id = id;
      newVo.login = login;
      newVo.email = email;
      newVo.password = password;

      return newVo;
    }

     /**
      * Return a User instance with values from a UserVO instance
      */
    public static function fromVO(vo:UserVO):User
    {
      var mo:User = new User();
      mo.id = vo.id;
      mo.login = vo.login;
      mo.email = vo.email;
      mo.password = vo.password;

      return mo;
    }

  }
}
