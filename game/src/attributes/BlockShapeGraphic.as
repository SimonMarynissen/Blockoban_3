package attributes {
	import flash.display.Sprite;
	
	public class BlockShapeGraphic extends BlockGraphic {
		
		private var
			blockGraphics:Array;
		
		public function BlockShapeGraphic(blockGraphics:Array) {
			super(0, 0, 0);
			this.blockGraphics = blockGraphics;
		}
		
		override public function addToScreen(screen:Sprite):void {
			for each (var g:BlockGraphic in blockGraphics) g.addToScreen(screen);
		}
	}
}