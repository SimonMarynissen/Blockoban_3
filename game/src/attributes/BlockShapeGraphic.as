package attributes {
	import flash.display.Sprite;
	
	public class BlockShapeGraphic extends BlockGraphic {
		
		private var
			blockGraphics;
		
		public function BlockShapeGraphic(blockGraphics:Array) {
			this.blockGraphics = blockGraphics;
		}
		
		override public function addToScreen(screen:Sprite) {
			for each (var g:BlockGraphic in blockGraphics) g.addToScreen(screen);
		}
	}
}