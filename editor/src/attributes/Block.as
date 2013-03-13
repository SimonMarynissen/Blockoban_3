package attributes {
	
	public class Block extends Attribute {
		
		private var
			_colour:int;
		
		public function Block(X:int, Y:int, colour:int) {
			super(X, Y, null);
		}
		
		public function get colour():int { return _colour; }
		public function set colour(colour:int):void { _colour = colour; }
	}
}