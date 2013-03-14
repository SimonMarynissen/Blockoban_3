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
			_shaped:Boolean, // if the block is part of a shape.
			_holded:Boolean;
			
		private var
			_colour:int;
		
		public function Block(x:int, y:int, colour:int, locked:Boolean = false) {
			super(x, y);
			_colour = colour;
			_locked = locked;
			_shaped = shaped;
			_graphic = new BlockGraphic(Level.xOffset + x * Level.cellWidth, Level.yOffset + y * Level.cellWidth, _colour);
		}
		
		public function move(x:int, y:int):void {
			_moving = true;
			_x += x;
			_y += y;
			var xAmount:int = Level.xOffset + _x * Level.cellWidth;
			var yAmount:int = Level.yOffset + _y * Level.cellWidth;
			Tweener.addTween(_graphic, { x:xAmount, y:yAmount, time:Math.sqrt(xAmount*xAmount + yAmount*yAmount)*0.001, transition:"easeOutQuint", onComplete:function ():void { _moving = false; }});
		}
		
		public function rebase():void {
			_graphic.x = Level.xOffset + _x * Level.cellWidth;
			_graphic.y = Level.yOffset + _y * Level.cellWidth;
		}
		
		public function clone():Block {
			var block:Block = new Block(_x, _y, _colour);
			block.locked = _locked;
			block.moving = _moving;
			block._graphic = _graphic;
			block.icy = _icy;
			block.destroyed = _destroyed;
			block.shaped = _shaped;
			block.holded = _holded;
			return block;
		}
		
		public function containBlock(x:int, y:int):Block {
			if (_x == x && _y == y) {
				return this;
			}
			return null;
		}
		
		public function get locked():Boolean { return _locked; }
		public function set locked(locked:Boolean):void { _locked = locked; }
		public function get moving():Boolean { return _moving; }
		public function set moving(moving:Boolean):void { _moving = moving; }
		public function get icy():Boolean { return _icy; }
		public function set icy(icy:Boolean):void { _icy = icy; }
		public function get colour():int { return _colour; }
		public function get destroyed():Boolean { return _destroyed; }
		public function set destroyed(destroyed:Boolean):void { _destroyed = destroyed; }
		public function get shaped():Boolean { return _shaped; }
		public function set shaped(shaped:Boolean):void { _shaped = shaped; }
		public function get holded():Boolean { return _holded; }
		public function set holded(holded:Boolean):void { _holded = holded; }
	}
}