package attributes {
	import flash.display.BitmapData;
	
	public class BlockGraphic extends AttributeGraphic {
		
		private var
			colour:int,
			icy:Boolean,
			locked:Boolean;
		
		public function BlockGraphic(x:Number, y:Number, colour:int, icy:Boolean = false, locked:Boolean = false) {
			super(x, y, icy ? Assets.blocks_circle[colour - 1] : Assets.blocks_square[colour - 1]);
		}
	}
}