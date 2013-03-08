package {
	import flash.events.Event;
	import flash.display.Sprite;
	import bl.MyEditorManager;
	
	/**
	 * @author Andrew Lee
	 * @author Simon Marynissen
	 */
	public class Main extends Sprite {
		
		public static var BLManager:MyEditorManager;
		
		public function Main():void {
			BLManager = new MyEditorManager(this);
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				// start of the editor
			});
		}
	}
}