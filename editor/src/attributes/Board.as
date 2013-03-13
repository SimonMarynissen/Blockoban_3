package attributes {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import states.Editor;

	public class Board extends Sprite {
			
		private var
			bit:Bitmap;
		
		public function Board(X:int, Y:int) {
			super();
			x = Editor.xOffset + X * Editor.cellWidth;
			y = Editor.yOffset + Y * Editor.cellWidth;
			bit = new Bitmap(Assets.boards[0]);
			addChild(bit);
			addEventListener(MouseEvent.ROLL_OVER, over);
			addEventListener(MouseEvent.ROLL_OUT, out);
		}
		
		public function over(e:MouseEvent):void {
			bit.bitmapData = Assets.boards[1];
		}
		
		public function out(e:MouseEvent):void {
			bit.bitmapData = Assets.boards[0];
		}
	}
}