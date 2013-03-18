package attributes {
	import states.Level;

	public class Wall extends AutoTile {
		
		public function Wall(x:int, y:int) {
			super(x, y);
			_graphic = new WallGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth);
		}
	}
}