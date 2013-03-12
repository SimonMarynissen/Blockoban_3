package attributes {

	public class HoldGraphic extends AttributeGraphic {
		
		public function HoldGraphic(x:Number, y:Number, colour:int) {
			super(x, y, Assets.holds[colour - 1]);
		}
	}
}