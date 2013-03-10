package attributes {
	
	public class BlockShape extends Block {
		
		private var
			blocks:/*Block*/Array;
		
		public function BlockShape(blocks:Array) {
			this.blocks = blocks;
			var graphics:Array = new Array();
			for (var i in blocks) graphics.push(blocks[i].graphic);
			graphic = new BlockShapeGraphic(graphics);
			for each (var b:Block in blocks) {
				if (b.x < x) x = b.x;
				if (b.y < y) y = b.y;
				if (b.locked) locked = true;
			}
		}
		
		override public function move(x:int, y:int) {
			this.x += x;
			this.y += y;
			for each (var b:Block in blocks) {
				b.x += x, b.y += y;
				Tweener.addTween(b.graphic, { x:x, y:y, time:Math.sqrt(x * x + y * y) * 0.001, transition:"linear" } );
			}
		}
		
		override public function containBlock(x:int, y:int):Block {
			for each (var b:Block in blocks) {
				if (b.x == x && b.y == y) return b;
			}
			return null;
		}
	}
}