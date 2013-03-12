package states {
	import attributes.Block;
	import attributes.Hold;
	import attributes.Wall;
	import flash.utils.ByteArray;

	public class Editor extends State {
		
		private var
			maxColumns:int = 16,
			maxRows:int = 14, 
			blocks:Array,
			walls:Array,
			holds:Array;
		
		public function Editor(data:Array) { // w, h, walls, blocks, holds
			walls = new Array();
			blocks = new Array();
			holds = new Array();
			var shiftX:int = (maxColumns - data[0]) / 2;
			var shiftY:int = (maxRows - data[1]) / 2;
			for (var i:int = 0; i < data[2].length; i++) {
				if (data[2][i]) {
					var x:int = shiftX + (i % data[0]);
					var y:int = shiftY + (i / data[0]);
					walls[x + maxColumns * y] = new Wall(x, y);
				}
			}
			for (i = 0; i < data[3].length; i++) {
				blocks.push(new Block(data[3][i][0], data[3][i][1], data[3][i][2])); // x, y, colour
			}
			for (i = 0; i < data[4].length; i++) {
				holds.push(new Hold(data[4][i][0], data[4][i][1], data[4][i][2])); // x, y, colour
			}
		}
		
		public function serialize():ByteArray {
			
			return new ByteArray();
		}
	}
}