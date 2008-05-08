package <%= base_package_name %>.control {
    import com.adobe.cairngorm.control.FrontController;

    public class ApplicationController extends FrontController {
        public function ApplicationController() {
            initializeCommands();
        }
        
        private function initializeCommands():void {
			
        }
    }
}