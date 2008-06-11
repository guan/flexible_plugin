package <%= base_package_name %>.business {
    import com.adobe.cairngorm.business.ServiceLocator;
    import <%= base_package_name %>.model.User;

    import mx.rpc.IResponder;
    import mx.rpc.remoting.RemoteObject;

    public class SessionDelegate {
        private var _responder:IResponder;
        private var _remoteObject:RemoteObject
        private static const REMOTE_OBJECT_NAME:String = "sessionRO";

        public function SessionDelegate(responder:IResponder) {
            _responder = responder;
            _remoteObject =
                ServiceLocator.getInstance().getRemoteObject(REMOTE_OBJECT_NAME);
        }

        public function create(obj:User):void {
            var call:Object = _remoteObject.create.send(obj.login, obj.password);
            call.addResponder(_responder);
        }

        public function destroy(obj:User):void {
            var call:Object = _remoteObject.destroy.send(obj.id);
            call.addResponder(_responder);
        }
    }
}