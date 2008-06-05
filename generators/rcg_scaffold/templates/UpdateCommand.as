package <%= base_package_name %>.command {
    import com.adobe.cairngorm.commands.ICommand;
    import com.adobe.cairngorm.control.CairngormEvent;

    import <%= base_package_name %>.business.<%= model_class %>Delegate;
    import <%= base_package_name %>.control.EventNames;
    import <%= base_package_name %>.util.CairngormUtils;
    import <%= base_package_name %>.model.ApplicationModelLocator;
    import <%= model_name %>;
    import <%= model_name %>Base;
    import <%= vo_name %>;

    import mx.controls.Alert;
    import mx.rpc.IResponder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    public class Update<%= model_class %>Command implements ICommand, IResponder {
        public function Update<%= model_class %>Command() {
        }

        public function execute(event:CairngormEvent):void {
            var delegate:<%= model_class %>Delegate = new <%= model_class %>Delegate(this);
            delegate.update(event.data);
        }

        public function result(event:Object):void {
            var resultEvent:ResultEvent = ResultEvent(event);
            var model:ApplicationModelLocator = ApplicationModelLocator.getInstance();
            model.update<%= model_class %>(<%= model_class %>Base.fromVO(<%=vo_class%>(event.result)));
            CairngormUtils.dispatchEvent(EventNames.LIST_<%= model_class.upcase %>);
        }

        public function fault(event:Object):void {
                        Alert.show("<%= model_class %> could not be updated!");
        }
    }
}