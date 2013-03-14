package attributes {
	import caurina.transitions.Tweener;
	import states.Level;
	
	public class BlockShape extends Block {
		
		private var
			blocks:/*Block*/Array,
			graphics:Array;
		
		public function BlockShape(blocks:Array) {
			trace(blocks);
			super(0, 0, 0);
			this.blocks = blocks;
			_shaped = true;
			for (var block:* in blocks) {
				graphics.push(block.graphic);
			}
			_graphic = new BlockShapeGraphic(graphics);
			/*for each (var b:Block in blocks) {
				b.shaped = true;
				if (b.x < x) x = b.x;
				if (b.y < y) y = b.y;
				if (b.locked) locked = true;
			}*/
		}
		
		override public function move(x:int, y:int):void {
			_moving = true;
			_x += x;
			_y += y;
			var xAmount:int = Level.xOffset + _x * Level.cellWidth;
			var yAmount:int = Level.yOffset + _y * Level.cellWidth;
			for each (var b:Block in blocks) {
				b.x += x, b.y += y;
				Tweener.addTween(b.graphic, { x:xAmount, y:yAmount, time:Math.sqrt(xAmount*xAmount + yAmount*yAmount)*0.001, transition:"easeOutQuint", onComplete:function ():void { _moving = false; }});
			}
		}
		
		override public function rebase():void { // under construction
			for (var b:* in blocks) {
				trace(b);
				//b.graphic.x = Level.xOffset + _x * Level.cellWidth;
				//b.graphic.y = Level.yOffset + _y * Level.cellWidth;
			}	
		}
		
		override public function clone():Block { // under construction
			var block:Block = new BlockShape(blocks);
			block.locked = _locked;
			block.moving = _moving;
			block.graphic = _graphic;
			block.icy = _icy;
			block.destroyed = _destroyed;
			block.shaped = _shaped;
			block.holded = _holded;
			return block;
		}
		
		override public function containBlock(x:int, y:int):Block {
			for each (var b:Block in blocks) {
				if (b.x == x && b.y == y) return b;
			}
			return null;
		}
	}
}