package <%= base_package_name %>.command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import <%= base_package_name %>.business.SessionDelegate;
    import <%= base_package_name %>.model.ApplicationModelLocator;

    import mx.rpc.IResponder;

    public class DestroySessionCommand implements ICommand, IResponder {
        public function DestroySessionCommand() {
        }

        public function execute(event:CairngormEvent):void {

        }

        public function result(event:Object):void {

        }

        public function fault(event:Object):void {
        }
    }
}