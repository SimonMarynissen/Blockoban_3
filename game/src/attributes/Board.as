package attributes {
	import states.Level;

	public class Board extends Attribute {
		
		public function Board(x:int, y:int) {
			super(x, y);
			_graphic = new BoardGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth);
		}
	}
}