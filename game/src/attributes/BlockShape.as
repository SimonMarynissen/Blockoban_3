package attributes {
	
	public class BlockShape extends Block {
		
		private var
			blocks:/*Block*/Array,
			graphics:Array;
		
		public function BlockShape(blocks:Array) {
			this.blocks = blocks;
			_shaped = true;
			for (var i in blocks) graphics.push(blocks[i].graphic);
			graphic = new BlockShapeGraphic(graphics);
			for each (var b:Block in blocks) {
				if (b.x < x) x = b.x;
				if (b.y < y) y = b.y;
				if (b.locked) locked = true;
			}
		}
		
		override public function move(x:int, y:int) {
			_moving = true;
			this.x += x;
			this.y += y;
			for each (var b:Block in blocks) {
				b.x += x, b.y += y;
				Tweener.addTween(b.graphic, { x:x, y:y, time:Math.sqrt(x * x + y * y) * 0.001, transition:"linear", onComplete:function ():void { _moving = false; } } );
			}
		}
		
		public function rebase():void { // under construction
			_graphic.x = Level.xOffset + _x * Level.cellWidth;
			_graphic.y = Level.yOffset + _y * Level.cellWidth;
		}
		
		public function clone():Block { // under construction
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
		
		override public function containBlock(x:int, y:int):Block {
			for each (var b:Block in blocks) {
				if (b.x == x && b.y == y) return b;
			}
			return null;
		}
	}
}