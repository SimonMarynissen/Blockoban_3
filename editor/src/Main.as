package {
	import attributes.Assets;
	import flash.events.Event;
	import flash.display.Sprite;
	import bl.MyEditorManager;
	import flash.utils.ByteArray;
	import states.Editor;
	import states.State;
	
	/**
	 * @author Andrew Lee
	 * @author Simon Marynissen
	 */
	public class Main extends Sprite {
		
		public static var BLManager:MyEditorManager;
		
		private var
			_state:State = new State(),
			_failed:Boolean = false;
		
		public function Main():void {
			Assets.init();
			BLManager = new MyEditorManager(this);
			addEventListener(Event.ADDED_TO_STAGE, function(e:Event):void {
				stage.frameRate = 30;
				addChild(_state);
			});
		}
		
		public function changeState(newState:State):void {
			if (_state != null) {
				_state.removed();
				removeChild(_state);
				_state = null;
			}
			_state = newState;
			addChild(_state);
		}
		
		public function serialize():ByteArray {
			_failed = false;
			var byte:ByteArray = new ByteArray();
			if (state is Editor) {
				var editor:Editor = state as Editor;
				byte = editor.serialize();
			} else {
				_failed = true;
				byte.writeObject("The state isn't an editor.");
			}
			return byte;
		}
		
		public function deserialize(data:ByteArray):Array {
			var a:Array;
			data.position = 0;
			if (data.length) a = data.readObject();
			else a = [1, 1, [[0]], [], []];
			return a;
		}
		
		public function get state():State { return _state; }
		public function set state(state:State):void { _state = state; }
		public function get failed():Boolean { return _failed; }
		public function set failed(failed:Boolean):void { _failed = failed; }
	}
}