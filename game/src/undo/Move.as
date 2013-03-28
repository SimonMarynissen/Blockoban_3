package undo {
	import flash.utils.ByteArray;
	import attributes.Block

	public class Move {
		
		private var
			_blocks:Array;
		
		public function Move(blocks:Array) {
			_blocks = new Array();
			for (var i:int = 0; i < blocks.length; i++) {
				_blocks.push(blocks[i].clone());
			}
			
		}
		
		public function toString():String {
			var str:String = "-----";
			for (var i:int = 0; i < _blocks.length; i++) {
				str += "(" + _blocks[i].x + ", " + _blocks[i].y + ")";
			}
			return str;
		}
		
		public function get blocks():Array { return _blocks; }
		//public function set blocks(blocks:Array):void { _blocks = blocks; }
	}
}