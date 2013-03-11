package states {
	import attributes.Block;
	import attributes.Wall;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import states.State;

	public class Level extends State {
		
		public static var
			cellWidth:Number = 32,
			xOffset:Number = 0, yOffset:Number = 0;
			
		private var
			data:Array,
			w:int = 0, h:int = 0, // amount of rows and colums
			blocks:/*Block*/Array,
			walls:/*Wall*/Array,
			xDirection:int = 0, yDirection:int = 0,
			xGravity:int = 0, yGravity:int = 1,
			falling:Boolean, matching:Boolean;
		
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
			blocks = new Array();
			walls = new Array();
			w = 3;
			h = 3;
			
			for (var i:int = 0; i < w+2; i++) {
				for (var j:int = 0; j < h+2; j++) {
					if (i == 0 || i == w+1 || j == 0 || j == h+1) {
						walls[i + (w+2) * j] = new Wall(i, j);
					}
				}
			}
			blocks.push(new Block(1, 1, Block.blue));
			blocks.push(new Block(2, 2, Block.orange));
			for each (var b:Block in blocks) b.addToScreen(this);
			for (i = 0; i < (w+2)*(h+2); i++) {
				if (walls[i] != null) walls[i].addToScreen(this);
			}
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			//addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private var onDownBlock:Block;
		private function mouseDown(e:MouseEvent):void {
			trace("down");
			if (!isMoving() && !falling && !matching) {
				onDownBlock = findBlock((mouseX - xOffset) / cellWidth, (mouseY - yOffset) / cellWidth);
			}
		}
		
		private function mouseMove(e:MouseEvent):void {
			trace("move");
			if (onDownBlock != null) {
				
			}
		}
		
		private function mouseUp(e:MouseEvent):void {
			trace("up");
			if (onDownBlock != null) {
				if (!isMoving() && !falling && !matching) {
					var onUpX:int = (mouseX - xOffset) / cellWidth;
					var onUpY:int = (mouseY - yOffset) / cellWidth;
					if (onDownBlock.x != onUpX || onDownBlock.x != onUpY) {
						var dx:int = mouseX - (xOffset + onDownBlock.x * cellWidth + cellWidth / 2);
						var dy:int = mouseY - (yOffset + onDownBlock.y * cellWidth + cellWidth / 2);
						xDirection = 0;
						yDirection = 0;
						var angle:Number = Math.atan2(dy, dx);
						if (angle >= Math.PI / 4 && angle < 3 * Math.PI / 4) yDirection = 1;
						else if (angle < Math.PI / 4 && angle >= -Math.PI / 4) xDirection = 1;
						else if (angle >= 3 * Math.PI / 4 || angle < -3 * Math.PI / 4) xDirection = -1;
						else if (angle >= -3 * Math.PI / 4 && angle < -Math.PI / 4) yDirection = -1;
						onDownBlock.moving = true;
						moveBlocks();
					}
				}
			}
		}
		
		private function update(e:Event):void {
			if (!isMoving() && falling) {
				fallBlocks();
			}
			if (!isMoving() && !falling && matching) {
				matchBlocks();
			}
		}
		
		private function moveBlocks():void {
			sortBlocks(xDirection, yDirection);
			for (var i:int = 0; i < blocks.length; i++) {
				if (blocks[i].moving) {
					var xcor:int = blocks[i].x + xDirection;
					var ycor:int = blocks[i].y + yDirection;
					if (xcor <= 0 || ycor <= 0 || xcor > w || ycor > h || walls[xcor + (w+2) * ycor] != null) {
						blocks[i].moving = false;
					} else {
						var block2:Block = findBlock(xcor, ycor);
						if (block2 != null && block2 != blocks[i]) {
							if (block2.icy) block2.moving = true;
							blocks[i].moving = false;
						}
					}
					if (blocks[i].moving) {
						blocks[i].move(xDirection, yDirection);
						matching = true;
					}
				}
			}
			falling = true;
		}
		
		private function fallBlocks():void {
			sortBlocks(xGravity, yGravity);
			for (var i:int = 0; i < blocks.length; i++) {
				var _falling:Boolean = true;
				var xDistance:int, yDistance:int;
				var xcor:int = blocks[i].x;
				var ycor:int = blocks[i].y;
				while (_falling) {
					xcor += xGravity, ycor += yGravity;
					if (xcor <= 0 || ycor <= 0 || xcor > w || ycor > h || walls[xcor + (w+2) * ycor] != null) {
						_falling = false;
						break;
					}
					var block2:Block = findBlock(xcor, ycor)
					if (block2 != null && block2 != blocks[i]) {
						_falling = false;
						break;
					}
					xDistance += xGravity, yDistance += yGravity;
				}
				if (xDistance || yDistance) {
					blocks[i].move(xDistance, yDistance);
					matching = true;
				}
			}
			falling = false;
		}
		
		private function matchBlocks():void {
			for (var i:int = 0; i < blocks.length; i++) {
				var b:Block = blocks[i]
				var b1:Block = findBlock(b.x, b.y - 1);
				var b2:Block = findBlock(b.x + 1, b.y);
				var b3:Block = findBlock(b.x, b.y + 1);
				var b4:Block = findBlock(b.x - 1, b.y);
				if (b1 != null) if (b1.colour == b.colour) b1.destroyed = true, b.destroyed = true;
				if (b2 != null) if (b2.colour == b.colour) b2.destroyed = true, b.destroyed = true;
				if (b3 != null) if (b3.colour == b.colour) b3.destroyed = true, b.destroyed = true;
				if (b4 != null) if (b4.colour == b.colour) b4.destroyed = true, b.destroyed = true;
			}
			for (i = blocks.length - 1; i >= 0; i--) {
				if (blocks[i].destroyed) {
					if (blocks[i].shaped) {
						// check if shape has broken
					}
					blocks.splice(i, 1);
				}
			}
			matching = false;
			falling = true;
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