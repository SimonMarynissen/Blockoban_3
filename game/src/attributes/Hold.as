package attributes {
	import states.Level;

	public class Hold extends Attribute {
		
		private var
			_colour:int;
		
		public function Hold(x:int, y:int, colour:int) {
			super(x, y);
			_colour = colour;
			_graphic = new HoldGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth, _colour);
		}
	}
}