package attributes {
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import states.Editor;

	public class Board extends Sprite {
			
		private var
			_X:int, _Y:int,
			bit:Bitmap,
			_editor:Editor;
		
		public function Board(X:int, Y:int, editor:Editor) {
			super();
			buttonMode = true;
			mouseChildren = false;
			x = Editor.xOffset + X * Editor.cellWidth;
			y = Editor.yOffset + Y * Editor.cellWidth;
			_X = X;
			_Y = Y;
			_editor = editor;
			bit = new Bitmap(Assets.boards[0]);
			addChild(bit);
			addEventListener(MouseEvent.ROLL_OVER, over);
			addEventListener(MouseEvent.ROLL_OUT, out);
			addEventListener(MouseEvent.CLICK, click);
		}
		
		public function over(e:MouseEvent):void {
			bit.bitmapData = Assets.boards[1];
		}
		
		public function out(e:MouseEvent):void {
			bit.bitmapData = Assets.boards[0];
		}
		
		public function click(e:MouseEvent):void {
			_editor.action(_X, _Y);
		}
	}
}