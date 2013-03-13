package attributes {
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class Button extends Sprite {
		
		private var
			_listener:Function,
			_bit:Bitmap,
			_overlay:Bitmap;
		
		public function Button(x:Number, y:Number, bit:BitmapData, listener:Function) {
			super();
			this.x = x;
			this.y = y;
			_listener = listener;
			_bit = new Bitmap(bit);
			addChild(_bit);
			_overlay = new Bitmap(new BitmapData(24, 24, true, 0x00ffffff));
			addChild(_overlay);
			buttonMode  = true;
			mouseChildren = false;
			addEventListener(MouseEvent.ROLL_OVER, over, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, out, false, 0, true);
			addEventListener(MouseEvent.CLICK, click, false, 0, true);
		}
		
		private function over(e:MouseEvent):void {
			Tweener.addTween(_overlay, { alpha:0.5, time:1 } );
		}
		
		private function out(e:MouseEvent):void {
			Tweener.addTween(_overlay, { alpha:0, time:1 } );
		}
		
		private function click(e:MouseEvent):void {
			_listener.call(this);
		}
	}
}