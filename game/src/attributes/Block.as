package attributes {
	import states.Level;
	import caurina.transitions.Tweener;

	public class Block extends Attribute {
		
		protected var
			_locked:Boolean,
			_moving:Boolean,
			_icy:Boolean,
			_destroyed:Boolean,
			_shaped:Boolean; // if the block is part of a shape.
			
		private var
			_colour:int;
		
		public function Block(x:int, y:int, colour:int) {
			super(x, y);
			_colour = colour;
			_graphic = new BlockGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth);
		}
		
		public function move(x:int, y:int):void {
			_x += x;
			_y += y;
			Tweener.addTween(_graphic, { x:x, y:y, time:Math.sqrt(x * x + y * y) * 0.001, transition:"linear", onComplete:function ():void { this.moving = false; } } );
		}
		
		public function containBlock(x:int, y:int):Block {
			if (_x == x && _y == y) return this;
			return null;
		}
		
		public function get moving():Boolean { return _moving; }
		public function set moving(moving:Boolean):void { _moving = moving; }
		public function get icy():Boolean { return _icy; }
		public function get colour():int { return _colour; }
		public function get x():int { return _x; }
		public function get y():int { return _y; }
		public function get destroyed():Boolean { return _destroyed; }
		public function set destroyed(destroyed:Boolean):void { _destroyed = destroyed; }
		public function get shaped():Boolean { return _shaped; }
		public function set shaped(shaped:Boolean):void { _shaped = shaped; }
	}
}