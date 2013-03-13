package attributes {
	
	public class Block extends Attribute {
		
		private var
			_colour:int;
		
		public function Block(X:int, Y:int, colour:int) {
			super(X, Y, Assets.blocks[colour - 1]);
			_colour = colour;
		}
		
		public function get colour():int { return _colour; }
		public function set colour(colour:int):void { _colour = colour; }
	}
}