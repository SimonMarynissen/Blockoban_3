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
			data:Array,
			w:int, h:int,
			blocks:/*Block*/Array,
			walls:/*Wall*/Array,
			xDirection:int, yDirection:int,
			xGravity:int, yGravity:int;
		
		public function Level(data:Array) {
			super();
			this.data = data;
		}
		
		override public function added(e:Event):void {
			super.added(e);
			init();
		}
		
		private function init():void {
			// data array to make blocks, etc
			for each (var b:Block in blocks) b.addToScreen(this);
			for each (var w:Wall in walls) w.addToScreen(this);
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void {
			if (isMoving()) {
				moveBlocks();
				fallBlocks();
				matchBlocks();
			}
		}
		
		private function moveBlocks():void {
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
		}
		
		private function fallBlocks():void {
			sortBlocks(xGravity, yGravity);
			for (var i:int = 0; i < blocks.length; i++) { // under construction
				var falling:Boolean = true;
				var xDistance:int, yDistance:int;
				var xcor:int = blocks[i].x;
				var ycor:int = blocks[i].y;
				while (falling) {
					xcor += xGravity, ycor += yGravity;
					if (walls[xcor + w * ycor] != null) {
						falling = false;
						break;
					}
					if (findBlock(xcor, ycor) != null) {
						falling = false;
						break;
					}
					xDistance += xGravity, yDistance += yGravity;
				}
				if (xDistance || yDistance) blocks[i].move(xDistance, yDistance);
			}
		}
		
		private function matchBlocks():void {
			for (var i:int = 0; i < blocks.length; i++) {
				var b:Block = blocks[i]
				var b1:Block = findBlock(b.x, b.y - 1);
				var b2:Block = findBlock(b.x + 1, b.y);
				var b3:Block = findBlock(b.x, b.y + 1);
				var b4:Block = findBlock(b.x - 1, b.y);
				if (b1.colour == b.colour) b1.destroyed = true, b.destroyed = true;
				if (b2.colour == b.colour) b2.destroyed = true, b.destroyed = true;
				if (b3.colour == b.colour) b3.destroyed = true, b.destroyed = true;
				if (b4.colour == b.colour) b4.destroyed = true, b.destroyed = true;
			}
			for (i = blocks.length - 1; i >= 0; i--) {
				if (blocks[i].destroyed) {
					if (blocks[i].shaped) {
						// check if shape has broken
					}
					blocks.splice(i, 1);
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
				var b2:Block = b.containBlock(x, y);
				if (b2 != null) return b2;
			}
			return null;
		}
	}
}