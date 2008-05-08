package com.pomodo.command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import <%= base_package_name %>.business.<%= model_class %>Delegate;
    import <%= base_package_name %>.control.EventNames;
    import <%= base_package_name %>.util.CairngormUtils;
    import <%= base_package_name %>.model.ApplicationModelLocator;
    import <%= model_name %>;
	import <%= vo_name %>;
	          
    import mx.controls.Alert;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;
    
    public class Destroy<%= model_class %>Command implements ICommand, IResponder {
        public function Destroy<%= model_class %>Command() {
        }

        public function execute(event:CairngormEvent):void {
            var delegate:<%= model_class %>Delegate = new <%= model_class %>Delegate(this);
            delegate.destroy(event.data);
        }

        public function result(event:Object):void {
            var resultEvent:ResultEvent = ResultEvent(event);
            var model:ApplicationModelLocator = ApplicationModelLocator.getInstance();
            if (event.result == "error") {
                Alert.show(
                    "The <%= model_class.downcase %> was not successfully deleted.", "Error");
            } else {
                model.remove<%= model_class %>(
                    <%= model_class %>.fromVO(<%= vo_class %>(event.result)));
            }
        }
    
        public function fault(event:Object):void {
            Alert.show("The <%= model_class.downcase %> was not successfully deleted.", "Error");
        }
    }
}