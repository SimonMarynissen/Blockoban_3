package attributes {
	import states.Level;
	import caurina.transitions.Tweener;

	public class Block extends Attribute {
		
		public static const
			blue:int = 1,
			green:int = 2,
			orange:int = 3,
			purple:int = 4,
			red:int = 5,
			white:int = 6,
			yellow:int = 7;
		
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
			_graphic = new BlockGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth, _colour);
		}
		
		public function move(x:int, y:int):void {
			_moving = true;
			_x += x;
			_y += y;
			var xAmount:int = _x * Level.cellWidth;
			var yAmount:int = _y * Level.cellWidth;
			Tweener.addTween(_graphic, { x:xAmount, y:yAmount, time:Math.sqrt(xAmount*xAmount + yAmount*yAmount)*0.01, transition:"easeOutElastic", onComplete:function ():void { _moving = false; }} );
		}
		
		public function containBlock(x:int, y:int):Block {
			if (_x == x && _y == y) {
				return this;
			}
			return null;
		}
		
		public function get moving():Boolean { return _moving; }
		public function set moving(moving:Boolean):void { _moving = moving; }
		public function get icy():Boolean { return _icy; }
		public function get colour():int { return _colour; }
		public function get x():int { return _x; }
		public function set x(x:int):void { _x = x; }
		public function get y():int { return _y; }
		public function set y(y:int):void { _y = y; }
		public function get destroyed():Boolean { return _destroyed; }
		public function set destroyed(destroyed:Boolean):void { _destroyed = destroyed; }
		public function get shaped():Boolean { return _shaped; }
		public function set shaped(shaped:Boolean):void { _shaped = shaped; }
	}
}