package attributes {
	import states.Level;

	public class Hold extends Attribute {
		
		private var
			_colour;
		
		public function Hold(x:int, y:int, colour:int) {
			super(x, y);
			_colour = colour;
			_graphic = new HoldGraphic(new Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth, _colour);
		}
	}
}