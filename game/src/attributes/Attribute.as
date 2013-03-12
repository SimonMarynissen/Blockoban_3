package attributes {
	import flash.display.Sprite;

	public class Attribute {
		
		protected var
			_x:int, _y:int,
			_graphic:AttributeGraphic;
		
		public function Attribute(x:int, y:int) {
			_x = x;
			_y = y;
		}
		
		public function addToScreen(screen:Sprite):void {
			if (_graphic) _graphic.addToScreen(screen);
		}
		
		public function get x():int { return _x; }
		public function set x(x:int):void { _x = x; }
		public function get y():int { return _y; }
		public function set y(y:int):void { _y = y; }
	}
}