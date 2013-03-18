package attributes {
	import flash.display.BitmapData;

	public class WallGraphic extends AutoTileGraphic {
		
		private var
			frame:int,
			corners:int;
		
		public function WallGraphic(x:Number, y:Number) {
			super(x, y, Assets.walls);
		}
	}
}