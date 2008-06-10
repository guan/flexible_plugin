package <%= base_package_name %>.model {
    import com.adobe.cairngorm.model.IModelLocator;

    import flash.display.DisplayObject;
    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;

    [Bindable]
    public class ApplicationModelLocator implements IModelLocator {

        public static const VIEWING_SPLASH_SCREEN:int = 0;
        public static const VIEWING_MAIN_APP:int = 1;

        public var workflowState:int = VIEWING_SPLASH_SCREEN;

        //
        //Singleton stuff
        //
        private static var modelLocator:ApplicationModelLocator;

        //DONOT DELETE COMMENT BELOW
        //public properties stuff

        public static function getInstance():ApplicationModelLocator{
            if (modelLocator == null) {
                modelLocator = new ApplicationModelLocator();
            }
            return modelLocator;
        }

        //DONOT DELETE COMMENT BELOW
        //model resources


        //The constructor should be private, but this is not
        //possible in ActionScript 3.0. So, throwing an Error if
        //a second PomodoModelLocator is created is the best we
        //can do to implement the Singleton pattern.
        public function ApplicationModelLocator() {
            if (modelLocator != null) {
                throw new Error("Only one ApplicationModelLocator instance may be instantiated.");
            }
        }
    }
}