package attributes {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class AutoTileGraphic extends AttributeGraphic {
		
		private var
			spriteSheet:Array,
			frame:int,
			corners:int;
		
		public function AutoTileGraphic(x:Number, y:Number, spriteSheet:Array) {
			super(x, y, null);
			this.spriteSheet = spriteSheet;
		}
		
		public function autoTile(frame:int, corners:int):void {
			this.frame = frame;
			this.corners = corners;
			var bit:BitmapData = new BitmapData(48, 48, true, 0);
			bit.copyPixels(spriteSheet[16 + 1], new Rectangle(0, 0, 48, 48), new Point(0, 0), null, null, true);
			bit.copyPixels(spriteSheet[frame], new Rectangle(0, 0, 48, 48), new Point(0, 0), null, null, true);
			for (var i:int = 0; i < 4; i++) {
				if (corners & (1 << i)) {
					bit.copyPixels(spriteSheet[16 + i], new Rectangle(0, 0, 48, 48), new Point(0, 0), null, null, true);
				}
			}
			this.bitmapData = bit;
		}
	}
}