package attributes {
	import level.Level;
	import caurina.transitions.Tweener;

	public class Block extends Attribute {
		
		public var
			graphic:BlockGraphic;
		
		protected var
			locked:Boolean,
			moving:Boolean,
			icy:Boolean,
			destroyed:Boolean,
			shaped:Boolean; // if the block is inside a shape.
			
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
		
		public function containBlock(x:int, y:int):Block {
			if (this.x == x && this.y == y) return this;
			return null;
		}
		
		public function get moving() { return moving; }
		public function set moving(moving:Boolean) { this.moving = moving; }
		public function get icy() { return icy; }
		public function get colour() { return colour; }
		public function get x() { return x; }
		public function get y() { return y; }
		public function get destroyed() { return destroyed; }
		public function set destroyed(destroyed:Boolean) { this.destroyed = destroyed; }
		public function get shaped() { return shaped; }
		public function set shaped(shaped:Boolean) { this.shaped = shaped; }
	}
}