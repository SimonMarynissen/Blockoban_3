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
	}
}