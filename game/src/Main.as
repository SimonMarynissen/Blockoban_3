package {
	import flash.events.Event;
	import flash.display.Sprite;
	import bl.MyGameManager;
	import states.MenuState;
	import states.State;
	
	/**
	 * @author Andrew Lee
	 * @author Simon Marynissen
	 */
	public class Main extends Sprite {
		
		public static var BLManager:MyGameManager;
		
		private static var 
			state:State = new MenuState(),
			stateContainer:Sprite = new Sprite();
		
		public function Main():void {
			BLManager = new MyGameManager(this);
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				stage.frameRate = 30;
				addChild(stateContainer);
				stateContainer.addChild(state);
			});
		}
		
		public static function changeState(newState:State):void {
			if (state != null) {
				state.removed();
				stateContainer.removeChild(state);
				state = null;
			}
			state = newState;
			stateContainer.addChild(state);
		}
	}
}