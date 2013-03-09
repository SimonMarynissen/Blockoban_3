package states {
	import attributes.Block;
	import attributes.Wall;
	import flash.events.Event;
	import states.State;

	public class Level extends State {
		
		public static var
			cellWidth:Number,
			xOffset:Number, yOffset:Number;
			
		private var
			blocks:/*Block*/Array,
			walls:/*Wall*/Array,
			w:int, h:int;
		
		public function Level(data:Array) {
			super();
			init(data);
		}
		
		private function init(data:Array):void {
			// data array to make blocks, etc
			for each (var b:Block in blocks) b.graphic.addToScreen(this);
			for each (var w:Wall in walls) w.graphic.addToScreen(this);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			
		}
	}
}