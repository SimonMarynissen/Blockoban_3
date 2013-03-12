package undo {
	import caurina.transitions.Tweener;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.sampler.NewObjectSample;
	
	public class Button extends Sprite {
		
		private var
			_listener:Function,
			_bitStates:/*Bitmap*/Array;
		
		public function Button(x:Number, y:Number, bit:BitmapData, listener:Function) {
			super();
			this.x = x;
			this.y = y;
			_listener = listener;
			_bitStates = new Array();
			for (var i:int = 0; i < 3; i ++) {
				_bitStates[i] = new Bitmap(new BitmapData(bit.width, bit.height / 3, true));
				_bitStates[i].bitmapData.copyPixels(bit, new Rectangle(0, i * bit.height / 3, bit.width, bit.height / 3), new Point(0, 0), null, null, true);
				if (i) _bitStates[i].alpha = 0;
				addChild(_bitStates[i]);
			}
			
			buttonMode  = true;
			mouseChildren = false;
			addEventListener(MouseEvent.ROLL_OVER, over, false, 0, true);
			addEventListener(MouseEvent.ROLL_OUT, out, false, 0, true);
			addEventListener(MouseEvent.CLICK, click, false, 0, true);
		}
		
		private function over(e:MouseEvent):void {
		   Tweener.addTween(e.target, { alpha:0.8, time:1 } );
		}
		
		private function out(e:MouseEvent):void {
		  Tweener.addTween(e.target, {alpha:1, time:1});
		}
		
		private function click(e:MouseEvent):void {
			_listener.call(this);
		}
	}
}