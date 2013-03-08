package attributes {
	import level.Level;

	public class Block {
		
		public var
			graphic:BlockGraphic;
		
		private var
			x:int, y:int,
			colour:int,
			locked:Boolean,
			moving:Boolean;
		
		public function Block(x:int, y:int, colour:int) {
			this.x = x, this.y = y, this.colour = colour;
			graphic = new BlockGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth);
			
		}
	}
}