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
		
		private static var 
			state:State = new Level(new Array()),
			stateContainer:Sprite = new Sprite();
		
		public function Main():void {
			Assets.init();
			BLManager = new MyGameManager(this);
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				stage.frameRate = 30;
				addChild(stateContainer);
				stateContainer.addChild(state);
			});
		}
		
		public function changeState(newState:State):void {
			if (state != null) {
				state.removed();
				stateContainer.removeChild(state);
				state = null;
			}
			state = newState;
			stateContainer.addChild(state);
		}
		
		public static function deserialize(data:ByteArray):Array {
			data.position = 0;
			return data.readObject();
		}
	}
}