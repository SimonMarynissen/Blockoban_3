package attributes {

	public class Wall extends Attribute {
		
		public var
			graphic:WallGraphic;
		
		public function Wall(x:int, y:int) {
			super(x, y);
			graphic = new WallGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth);
		}
	}
}