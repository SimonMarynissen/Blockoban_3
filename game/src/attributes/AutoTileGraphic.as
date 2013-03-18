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
			super(x, y, new BitmapData(48, 48, true, 0x00ffffff));
			this.spriteSheet = spriteSheet;
		}
		
		public function autoTile(frame:int, corners:int):void {
			this.frame = frame;
			this.corners = corners;
			var bit:BitmapData = new BitmapData(48, 48, true, 0x00ffffff);
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