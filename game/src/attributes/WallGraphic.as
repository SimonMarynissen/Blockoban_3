package attributes {
	import flash.display.BitmapData;

	public class WallGraphic extends AttributeGraphic {
		
		private var
			frames:int,
			corners:int;
		
		public function WallGraphic(x:Number, y:Number) {
			super(x, y, Assets.walls[0]);
		}
	}
}