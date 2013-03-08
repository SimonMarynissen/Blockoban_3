package level {
	import flash.events.Event;
	import states.State;

	public class Level extends State {
		
		public static var
			cellWidth:Number,
			xOffset:Number, yOffset:Number;
			
		private var
			blocks:/*Block*/Array,
			w:int, h:int;
		
		public function Level() {
			super();
		}
		
		override public function added(e:Event):void {
			super.added(e);
			trace("level loaded");
		}
	}
}