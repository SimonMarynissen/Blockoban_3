package attributes {
	import caurina.transitions.Tweener;
	import states.Level;
	
	public class BlockShape extends Block {
		
		public var
			blocks:/*Block*/Array,
			graphics:Array;
		
		public function BlockShape(blocks:Array) {
			if (false) super();
			this.x = 100;
			this.y = 100;
			this.blocks = blocks;
			graphics = new Array();
			_shaped = true;
			for each (var block:Block in blocks) {
				graphics.push(block.graphic);
				block.shaped = true;
				block.shape = this;
				if (block.x < x) x = block.x;
				if (block.y < y) y = block.y;
				if (block.locked) locked = true;
			}
			_graphic = new BlockShapeGraphic(graphics);
		}
		
		override public function move(x:int, y:int):void {
			_moving = true;
			_x += x;
			_y += y;
			for each (var b:Block in blocks) {
				b.x += x, b.y += y;
				var xAmount:int = Level.xOffset + b.x * Level.cellWidth;
				var yAmount:int = Level.yOffset + b.y * Level.cellWidth;
				Tweener.addTween(b.graphic, { x:xAmount, y:yAmount, time:Math.sqrt(xAmount*xAmount + yAmount*yAmount)*0.001, transition:"easeOutQuint", onComplete:function ():void { _moving = false; }});
			}
		}
		
		override public function rebase():void { // under construction
			for each (var b:Block in blocks) {
				b.graphic.x = Level.xOffset + b.x * Level.cellWidth;
				b.graphic.y = Level.yOffset + b.y * Level.cellWidth;
			}	
		}

		override public function containBlock(x:int, y:int):Block {
			for each (var b:Block in blocks) {
				if (b.x == x && b.y == y) return b;
			}
			return null;
		}
		
		override public function clone():Block {
			var shapeBlocks:Array = new Array();
			for each (var b:Block in blocks) shapeBlocks.push(b.clone());
			var block:BlockShape = new BlockShape(shapeBlocks);
			block.locked = _locked;
			block.moving = _moving;
			block.graphic = _graphic;
			block.icy = _icy;
			block.destroyed = _destroyed;
			block.shaped = _shaped;
			block.holded = _holded;
			return block;
		}
	}
}