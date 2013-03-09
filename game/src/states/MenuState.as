package states {
	import flash.events.Event;
	
	public class MenuState extends State {
		
		public function MenuState():void {
			super();
		}
		
		override public function added(e:Event):void {
			super.added(e);
			//Main.changeState(new Level());
		}
	}
}