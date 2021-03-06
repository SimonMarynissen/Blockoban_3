package states {
	import attributes.Assets;
	import attributes.Block;
	import attributes.Board;
	import attributes.Button;
	import attributes.Hold;
	import attributes.Wall;
	import flash.utils.ByteArray;

	public class Editor extends State {
		
		public static const
			cellWidth:int = 24,
			xOffset:int = 108,
			yOffset:int = 8;
		
		private var
			maxColumns:int = 16,
			maxRows:int = 14, 
			blocks:Array,
			walls:Array,
			holds:Array,
			boards:Array,
			buttons:Array,
			extra:Array,
			type:String = "wall";
		
		public function Editor(data:Array) { // w, h, walls, blocks, holds
			walls = new Array();
			blocks = new Array();
			holds = new Array();
			boards = new Array();
			buttons = new Array();
			extra = new Array();
			extra[0] = 5;
			for (var x:int = 0; x < maxColumns; x++) {
				for (var y:int = 0; y < maxRows; y++) {
					addChild(boards[x + y * maxColumns] = new Board(x, y, this));
				}
			}
			var shiftX:int = (maxColumns - data[0]) / 2;
			var shiftY:int = (maxRows - data[1]) / 2;
			for (var i:int = 0; i < data[2].length; i++) {
				if (data[2][i]) {
					var X:int = shiftX + (i % data[0]);
					var Y:int = shiftY + (i / data[0]);
					walls[X + maxColumns * Y] = new Wall(X, Y);
				}
			}
			for (i = 0; i < data[3].length; i++) {
				blocks.push(new Block(data[3][i][0], data[3][i][1], data[3][i][2])); // x, y, colour
				addChild(blocks[i]);
			}
			for (i = 0; i < data[4].length; i++) {
				holds.push(new Hold(data[4][i][0], data[4][i][1], data[4][i][2])); // x, y, colour
				addChild(holds[i]);
			}
			
			for (i = 0; i < 3; i++) {
				buttons.push(new Button(8 + i * (34), 8, Assets.blocks[i], clickFunction("block", [i + 1])));
				if (i == 2) buttons.push(new Button(8 + i * (34), 42, Assets.blocks[6], clickFunction("block", [i + 5])));
				else buttons.push(new Button(8 + i * (34), 42, Assets.blocks[i + 3], clickFunction("block", [i + 4])));
			}
			buttons.push(new Button(42, 76, Assets.blocks[5], clickFunction("block", [6])));
			buttons.push(new Button(42, 110, Assets.wall, clickFunction("wall", [])));
			for (i = 0; i < buttons.length; i++) {
				addChild(buttons[i]);
			}
		}
		
		private function clickFunction(t:String, e:Array):Function {
			var func:Function = function():void {
				type = t;
				extra.length = 0;
				extra = e;
			}
			return func;
		}
		
		public function action(X:int, Y:int):void {
			var wall:Wall = walls[X + Y * maxColumns];
			var block:Block = findBlock(X, Y);
			var hold:Hold = findHold(X, Y);
			switch (type) {
				case "wall":
					if (!wall && !block && !hold) {
						addChild(walls[X + Y * maxColumns] = new Wall(X, Y));
					}
					break;
				case "block":
					if (!wall && !block) {
						block = new Block(X, Y, extra[0]);
						blocks.push(block);
						addChild(block);
					}
					break;
				case "hold":
					if (!wall && !block && !hold) {
						hold = new Hold(X, Y, extra[0]);
						holds.push(hold);
						addChild(hold);
					}
					break;
			}
		}
		
		public function findBlock(X:int, Y:int):Block {
			for each (var block:Block in blocks) {
				if (block.X == X && block.Y == Y) return block;
			}
			return null;
		}
		
		public function findHold(X:int, Y:int):Hold {
			for each (var hold:Hold in holds) {
				if (hold.X == X && hold.Y == Y) return hold;
			}
			return null;
		}
		
		public function serialize():ByteArray {
			var data:Array = new Array();
			var minX:int = maxColumns, maxX:int = 0;
			var minY:int = maxRows, maxY:int = 0
			for (var i:int = 0; i < maxRows * maxColumns; i++) {
				if (walls[i]) {
					if (walls[i].X < minX) minX = walls[i].X;
					if (walls[i].X > maxX) maxX = walls[i].X;
					if (walls[i].Y < minY) minY = walls[i].Y;
					if (walls[i].Y > maxY) maxY = walls[i].Y;
				}
			}
			for each (var block:Block in blocks) {
				if (blocks[i].X < minX) minX = blocks[i].X;
				if (blocks[i].X > maxX) maxX = blocks[i].X;
				if (blocks[i].Y < minY) minY = blocks[i].Y;
				if (blocks[i].Y > maxY) maxY = blocks[i].Y;
			}
			for each (var hold:Hold in holds) {
				if (holds[i].X < minX) minX = holds[i].X;
				if (holds[i].X > maxX) maxX = holds[i].X;
				if (holds[i].Y < minY) minY = holds[i].Y;
				if (holds[i].Y > maxY) maxY = holds[i].Y;
			}
			data[0] = maxX - minX + 1; // width
			data[1] = maxY - minY + 1; // height
			
			var wallsData:Array = new Array(); // walls
			for (i = 0; i < maxRows * maxColumns; i++) {
				if (walls[i]) {
					var wallX:int = walls[i].X - minX + 1;
					var wallY:int = walls[i].Y - minY + 1;
					wallsData[wallX + data[0] * wallY] = [1]
				}	
			}
			for (i = 0; i < maxRows * maxColumns; i++) {
				if (wallsData[i] == null) wallsData[i] = 0;
			}
			data[2] = wallsData;
			
			data[3] = new Array(); // blocks
			for each (block in blocks) {
				data[3].push([block.X - minX + 1, block.Y - minY + 1, block.colour]);
			}
			
			data[4] = new Array(); // holds
			for each (hold in holds) {
				data[4].push([hold.X - minX + 1, hold.Y - minY + 1, hold.colour]);
			}
			
			var byte:ByteArray = new ByteArray();
			byte.writeObject(data);
			return byte;
		}
	}
}