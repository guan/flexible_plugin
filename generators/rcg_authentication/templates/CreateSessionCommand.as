package <%= base_package_name %>.command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import <%= base_package_name %>.business.SessionDelegate;
    import <%= base_package_name %>.model.ApplicationModelLocator;
    import <%= base_package_name %>.model.UserBase;
    import <%= base_package_name %>.vo.UserVO;

    import mx.rpc.IResponder;

    public class CreateSessionCommand implements ICommand, IResponder {
        public function CreateSessionCommand() {
        }

        public function execute(event:CairngormEvent):void {
            var delegate:SessionDelegate = new SessionDelegate(this);
            delegate.create(event.data);
        }

        public function result(event:Object):void {
            var model:ApplicationModelLocator = ApplicationModelLocator.getInstance();
            model.user = UserBase.fromVO(UserVO(event.result));
        }

        public function fault(event:Object):void {
        }
    }
}