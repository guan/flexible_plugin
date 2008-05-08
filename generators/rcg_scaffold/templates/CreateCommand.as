package <%= base_package_name %>.command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    
    import <%= base_package_name %>.business.<%= model_class %>Delegate;
    import <%= base_package_name %>.control.EventNames;
    import <%= base_package_name %>.util.CairngormUtils;
  
  	import mx.controls.Alert;  
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
    public class Create<%= model_class %>Command implements ICommand, IResponder {
        public function Create<%= model_class %>Command() {
        }

        public function execute(event:CairngormEvent):void {
            var delegate:<%= model_class %>Delegate = new <%= model_class %>Delegate(this);
            delegate.create(event.data);
        }

        public function result(event:Object):void {
            CairngormUtils.dispatchEvent(EventNames.LIST_<%= model_class.pluralize.upcase %>);
        }
    
        public function fault(event:Object):void {
            Alert.show("<%= model_class %> could not be created!");
        }
    }
}