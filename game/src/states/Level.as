package states {
	import attributes.Assets;
	import attributes.Block;
	import attributes.Board;
	import attributes.Hold;
	import attributes.Wall;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import states.State;
	import undo.*;

	public class Level extends State {
		
		public static var
			cellWidth:Number = 32,
			xOffset:Number = 0, yOffset:Number = 0;
			
		private var
			data:Array,
			w:int = 0, h:int = 0, // amount of rows and colums
			blocks:/*Block*/Array,
			walls:/*Wall*/Array,
			holds:/*Hold*/Array,
			moves:/*Move*/Array,
			boards:/*Board*/Array,
			xDirection:int = 0, yDirection:int = 0,
			xGravity:int = 0, yGravity:int = 1,
			falling:Boolean, matching:Boolean,
			undoButton:Button;
		
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
			holds = new Array();
			moves = new Array();
			boards = new Array();
			/*w = data[0];
			h = data[1];*/
			w = 3;
			h = 5;
			centre();
			for (var i:int = 0; i < w+2; i++) {
				for (var j:int = 0; j < h+2; j++) {
					if (i == 0 || i == w+1 || j == 0 || j == h+1) {
						walls[i + (w + 2) * j] = new Wall(i, j);
					}
					boards[i + (w + 2) * j] = new Board(i, j);
				}
			}
			blocks.push(new Block(1, 1, Block.blue));
			blocks.push(new Block(2, 2, Block.blue));
			holds.push(new Hold(1, 2, 3));
			for (i = 0; i < (w + 2) * (h + 2); i++) boards[i].addToScreen(this);
			for (i = 0; i < (w+2)*(h+2); i++) if (walls[i] != null) walls[i].addToScreen(this);
			for each (var hold:Hold in holds) {
				hold.addToScreen(this);
				block = findBlock(hold.x, hold.y);
				if (block != null) block.holded = true;
			}
			for each (var block:Block in blocks) block.addToScreen(this);
			
			undoButton = new Button(10, 410, Assets.undoButton, undo);
			addChild(undoButton);
			fallBlocks();
			
			addEventListener(Event.ENTER_FRAME, update);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			//addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private var onDownX:int = -1, onDownY:int = -1;
		private function mouseDown(e:MouseEvent):void {
			if (!isMoving() && !falling && !matching) {
				var block:Block = findBlock((mouseX - xOffset) / cellWidth, (mouseY - yOffset) / cellWidth);
				if (block != null) {
					onDownX = block.x;
					onDownY = block.y;
				}
			}
		}
		
		private function mouseMove(e:MouseEvent):void {
			trace("move");
		}
		
		private function mouseUp(e:MouseEvent):void {
			if (onDownX != -1 || onDownY != -1) {
				if (!isMoving() && !falling && !matching) {
					var onUpX:int = (mouseX - xOffset) / cellWidth;
					var onUpY:int = (mouseY - yOffset) / cellWidth;
					if (onDownX != onUpX || onDownY != onUpY) {
						var dx:int = mouseX - (xOffset + onDownX * cellWidth + cellWidth / 2);
						var dy:int = mouseY - (yOffset + onDownY * cellWidth + cellWidth / 2);
						xDirection = 0;
						yDirection = 0;
						var angle:Number = Math.atan2(dy, dx);
						if (angle >= Math.PI / 4 && angle < 3 * Math.PI / 4) yDirection = 1;
						else if (angle < Math.PI / 4 && angle >= -Math.PI / 4) xDirection = 1;
						else if (angle >= 3 * Math.PI / 4 || angle < -3 * Math.PI / 4) xDirection = -1;
						else if (angle >= -3 * Math.PI / 4 && angle < -Math.PI / 4) yDirection = -1;
						findBlock(onDownX, onDownY).moving = true;
						moveBlocks();
					}
				}
				onDownX = -1, onDownY = -1;
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
						var hold:Hold = findHold(blocks[i].x, blocks[i].y);
						if (hold != null) blocks[i].holded = true;
						matching = true;
						falling = true;
					}
				}
			}
		}
		
		private function fallBlocks():void {
			sortBlocks(xGravity, yGravity);
			for (var i:int = 0; i < blocks.length; i++) {
				if (blocks[i].holded) continue;
				var _falling:Boolean = true;
				var xDistance:int = 0, yDistance:int = 0;
				var xcor:int = blocks[i].x;
				var ycor:int = blocks[i].y;
				while (_falling) {
					xcor += xGravity, ycor += yGravity;
					if (xcor <= 0 || ycor <= 0 || xcor > w || ycor > h || walls[xcor + (w+2) * ycor] != null) {
						_falling = false;
						break;
					}
					var block:Block = findBlock(xcor, ycor);
					if (block != null && block != blocks[i]) {
						_falling = false;
						break;
					}
					var hold:Hold = findHold(xcor, ycor);
					if (hold != null) {
						blocks[i].holded = true;
						xDistance += xGravity, yDistance += yGravity;
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
			if (!matching) endMove();
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
		
		private function endMove():void {
			for (var i:int = 0; i < blocks.length; i++) blocks[i].holded = false;
			moves.push(new Move(blocks));
		}
		
		private function undo():void {
			if (moves.length > 1 && !isMoving() && !falling && !matching) {
				moves.pop()
				var previousMove:Move = moves[moves.length - 1];
				blocks = previousMove.blocks;
				for each (var block:Block in blocks) block.rebase();
			}
		}
		
		private function sortBlocks(xDir:int, yDir:int):void {
			if (xDir == -1) blocks.sortOn(["x", "y"], Array.NUMERIC);
			else if (xDir == 1) blocks.sortOn(["x", "y"], Array.NUMERIC | Array.DESCENDING);
			else if (yDir == -1) blocks.sortOn(["y", "x"], Array.NUMERIC);
			else if (yDir == 1) blocks.sortOn(["y", "x"], Array.NUMERIC | Array.DESCENDING);
		}
		
		private function isMoving():Boolean {
			for each (var block:Block in blocks) {
				if (block.moving) return true;
			}
			return false;
		}
		
		private function findBlock(x:int, y:int):Block {
			for each (var block:Block in blocks) {
				var block2:Block = block.containBlock(x, y);
				if (block2 != null) return block2;
			}
			return null;
		}
		
		private function findHold(x:int, y:int):Hold {
			for each (var hold:Hold in holds) {
				if (hold.x == x && hold.y == y) return hold;
			}
			return null;
		}
		
		private function centre():void {
			xOffset = (stage.stageWidth - (w + 2) * cellWidth) / 2;
			yOffset = (stage.stageHeight - 50 - (h + 2) * cellWidth) / 2;
			trace("centre", xOffset, yOffset);
		}
	}
}