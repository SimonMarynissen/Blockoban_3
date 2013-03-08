package {
	import flash.events.Event;
	import flash.display.Sprite;
	import bl.MyGameManager;
	
	/**
	 * @author Andrew Lee
	 * @author Simon Marynissen
	 */
	public class Main extends Sprite {
		
		public static var BLManager:MyGameManager;
		
		public function Main():void {
			BLManager = new MyGameManager(this);
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				// start of the game
			});
		}
	}
}