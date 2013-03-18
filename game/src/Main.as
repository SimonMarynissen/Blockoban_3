package {
	import flash.events.Event;
	import flash.display.Sprite;
	import bl.MyGameManager;
	import flash.utils.ByteArray;
	import states.*;
	import attributes.Assets;
	
	/**
	 * @author Andrew Lee
	 * @author Simon Marynissen
	 */
	public class Main extends Sprite {
		
		public static var BLManager:MyGameManager;
		
		private var 
			state:State = new Level([5, 6, [], [[1, 1, 3], ["s", [2, 4, 2], [3, 4, 2], [3, 5, 2], [2, 3, 2]], ["s", [1, 2, 4], [2, 2, 4], [2, 3, 4]]], []]);
		
		public function Main():void {
			Assets.init();
			BLManager = new MyGameManager(this);
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				stage.frameRate = 30;
				addChild(state);
			});
		}
		
		public function changeState(newState:State):void {
			if (state != null) {
				state.removed();
				removeChild(state);
				state = null;
			}
			state = newState;
			addChild(state);
		}
		
		public static function deserialize(data:ByteArray):Array {
			data.position = 0;
			return data.readObject();
		}
	}
}