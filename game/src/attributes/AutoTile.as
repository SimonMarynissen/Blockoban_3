package attributes {

	public class AutoTile extends Attribute {
		
		public function AutoTile(x:int, y:int) {
			super(x, y);
		}
		
		public function autoTile(frame:int, corners:int):void {
			(_graphic as AutoTileGraphic).autoTile(frame, corners);
		}
	}
}