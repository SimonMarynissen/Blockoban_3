package states {
	import flash.display.Sprite;
	import flash.events.Event;

	public class State extends Sprite {
		
		public function State() {
			addEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		public function added(e:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, added);
		}
		
		public function removed():void {
			
		}
	}
}