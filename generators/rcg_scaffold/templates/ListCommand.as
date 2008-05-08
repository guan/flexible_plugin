package com.pomodo.command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;
    import <%= base_package_name %>.business.<%= model_class %>Delegate;
    import <%= base_package_name %>.control.EventNames;
    import <%= base_package_name %>.util.CairngormUtils;
    import <%= base_package_name %>.model.ApplicationModelLocator;
    
    import mx.controls.Alert;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
    public class <%= model_class.pluralize %>Command implements ICommand, IResponder {
        public function List<%= model_class.pluralize %>Command() {     
        }

        public function execute(event:CairngormEvent):void {
            var delegate:<%= model_class %>Delegate = new <%= model_class %>Delegate(this);
            delegate.list();
        }

        public function result(event:Object):void {
            var model:ApplicationModelLocator = ApplicationModelLocator.getInstance();
            model.set<%= model_class.pluralize %>(event.result);
        }
    
        public function fault(event:Object):void {
            Alert.show("<%= model_class.pluralize %> could not be retrieved!");
        }
    }
}