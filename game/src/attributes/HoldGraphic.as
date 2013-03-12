package attributes {

	public class HoldGraphic extends AttributeGraphic {
		
		public function HoldGraphic(x:Number, y:Number, colour:int) {
			super(x-20, y-20, Assets.holds[colour - 1]);
		}
	}
}