package states {
	import attributes.Block;
	import attributes.Wall;
	import flash.events.Event;
	import states.State;

	public class Level extends State {
		
		public static var
			cellWidth:Number,
			xOffset:Number, yOffset:Number;
			
		private var
			w:int, h:int,
			blocks:/*Block*/Array,
			walls:/*Wall*/Array,
			xDirection:int, yDirection,
			xGravity:int, yGravity:int;
		
		public function Level(data:Array) {
			super();
			init(data);
		}
		
		private function init(data:Array):void {
			// data array to make blocks, etc
			for each (var b:Block in blocks) b.graphic.addToScreen(this);
			for each (var w:Wall in walls) w.graphic.addToScreen(this);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			if (isMoving()) {
				sortBlocks(xDirection, yDirection);
				for (var i:int = 0; i < blocks.length; i++) {
					if (blocks[i].moving) {
						var xcor:int = blocks[i].x += xDirection;
						var ycor:int = blocks[i].y += yDirection;
						if (walls[xcor + w * ycor] != null) blocks[i].moving = false;
						else {
							var block2:Block = findBlock(xcor, ycor);
							if (block2 != null) {
								if (block2.icy) block2.moving = true;
								blocks[i].moving = false;
							}
						}
						if (blocks[i].moving) blocks[i].move(xDirection, yDirection);
					}
				}
				sortBlocks(xGravity, yGravity);
				for (i = 0; i < blocks.length; i++) { // under construction
					var falling:Boolean = true;
					var xDistance:int, yDistance:int;
					while (falling) {
						if (walls[(blocks[i].x + xDistance + 1) + w * (blocks[i].y + yDistance + 1)] != null) {
							falling = false;
							break;
						}
						if (findBlock(blocks[i].x + xDistance + 1, blocks[i].y + yDistance + 1) != null) {
							falling = false;
							break;
						}
						xDistance += xGravity, yDistance += yGravity;
					}
				}
			}
		}
		
		private function sortBlocks(xDir:int, yDir:int):void {
			if (xDir == -1) blocks.sortOn(["x", "y"], Array.NUMERIC);
			else if (xDir == 1) blocks.sortOn(["x", "y"], Array.NUMERIC | Array.DESCENDING);
			else if (yDir == -1) blocks.sortOn(["y", "x"], Array.NUMERIC);
			else if (yDir == 1) blocks.sortOn(["y", "x"], Array.NUMERIC | Array.DESCENDING);
		}
		
		private function isMoving():Boolean {
			for each (var b:Block in blocks) {
				if (b.moving) return true;
			}
			return false;
		}
		
		private function findBlock(x:int, y:int):Block {
			for each (var b:Block in blocks) {
				if (b.x == x && b.y == y) return b;
			}
			return null;
		}
	}
}