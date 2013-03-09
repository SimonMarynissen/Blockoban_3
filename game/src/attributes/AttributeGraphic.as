package attributes {
	import flash.display.Bitmap;
	import flash.display.Sprite;

	public class AttributeGraphic extends Bitmap {
		
		public function AttributeGraphic(x:Number, y:Number) {
			this.x = x;
			this.y = y;
		}
		
		public function addToScreen(screen:Sprite) {
			screen.addChild(this);
		}
	}
}