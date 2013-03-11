package attributes {
	import flash.display.BitmapData;
	
	public class BlockGraphic extends AttributeGraphic {
		
		public function BlockGraphic(x:Number, y:Number, colour:int) {
			super(x, y, Assets.blocks[colour - 1]);
		}
	}
}