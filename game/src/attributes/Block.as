package attributes {
	import level.Level;
	import caurina.transitions.Tweener;

	public class Block extends Attribute {
		
		public var
			graphic:BlockGraphic;
		
		protected var
			locked:Boolean,
			moving:Boolean;
			
		private var
			colour:int;
		
		public function Block(x:int, y:int, colour:int) {
			super(x, y);
			this.colour = colour;
			graphic = new BlockGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth);
		}
		
		public function move(x:int, y:int) {
			this.x += x;
			this.y += y;
			Tweener.addTween(graphic, { x:x, y:y, time:Math.sqrt(x * x + y * y) * 0.001, transition:"linear" } );
		}
	}
}