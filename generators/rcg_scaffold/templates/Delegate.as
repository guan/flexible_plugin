package <%= base_package_name %>.business {
    import com.adobe.cairngorm.business.ServiceLocator;
    import <%= model_name %>;

    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    public class <%= model_class %>Delegate {
        private var _responder:IResponder;
        private var _remoteObject:RemoteObject
        private static const REMOTE_OBJECT_NAME:String = "<%= model_class.downcase %>RO";

        public function <%= model_class %>Delegate(responder:IResponder) {
            _responder = responder;
            _remoteObject =
                ServiceLocator.getInstance().getRemoteObject(REMOTE_OBJECT_NAME);
        }

        public function list():void {
            var call:Object = _remoteObject.index.send();
            call.addResponder(_responder);
        }

        public function create(obj:<%= model_class %>):void {
                var call:Object = _remoteObject.create.send(obj.toVO());
                call.addResponder(_responder);
        }

        public function update(obj:<%= model_class %>):void {
                var call:Object = _remoteObject.update.send(obj.toVO());
                call.addResponder(_responder);
        }

        public function destroy(obj:<%= model_class %>):void {
                var call:Object = _remoteObject.destroy.send(obj.id);
                call.addResponder(_responder);
        }
    }
}