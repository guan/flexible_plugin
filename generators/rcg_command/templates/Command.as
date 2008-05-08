package <%= base_package_name %>.command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
    public class <%= command_class %> implements ICommand, IResponder {
        public function <%= command_class %>() {     
        }

        public function execute(event:CairngormEvent):void {
        }

        public function result(event:Object):void {
        }
    
        public function fault(event:Object):void {
        }
    }
}