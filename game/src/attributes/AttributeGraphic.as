package attributes {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;

	public class AttributeGraphic extends Bitmap {
		
		public function AttributeGraphic(x:Number, y:Number, bit:BitmapData) {
			super(bit);
			this.x = x;
			this.y = y;
		}
		
		public function addToScreen(screen:Sprite):void {
			screen.addChild(this);
		}
	}
}