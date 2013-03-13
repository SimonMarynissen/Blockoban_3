package attributes {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import states.Editor;

	public class Attribute extends Bitmap {
		
		protected var
			_X:int,
			_Y:int;
		
		public function Attribute(X:int, Y:int, bit:BitmapData) {
			super(bit);
			x = Editor.xOffset + X * Editor.cellWidth;
			y = Editor.yOffset + Y * Editor.cellWidth;
			_X = X;
			_Y = Y;
		}
		
		public function get X():int { return _X; }
		public function set X(X:int):void { _X = X; }
		public function get Y():int { return _Y; }
		public function set Y(Y:int):void { _Y = Y; }
	}
}