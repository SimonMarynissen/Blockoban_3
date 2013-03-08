package bl {
	
	import flash.utils.ByteArray;
	
	/**
	 * BL manager files rewritten to properly work with FlashDevelop.
	 * @author Jean-Philippe Sarda
	 * @edited Simon Marynissen
	 */
	
	public class MyEditorManager extends EditorManager {
		
		private static var theOne:MyEditorManager = null;
		
		/**
		 * Constructor.
		 * @param	main	Your main class, must be named Main.
		 */
		public function MyEditorManager(main:Main) {
			super(main);
			theOne = this;
		}
		
		/**
		 * Returns the BLManager, once it's instantiated.
		 */
		public static function getInstance():MyEditorManager {
			return theOne;
		}
		
		/**
		 * The BL API will call this function if the player wants to edit a level.
		 * @param	data	A ByteArray containing the level data to be unserialized. If it's empty, you deal with a new level.
		 */
		override public function blEditLvl(data:ByteArray):void {
		    // You must implement this function.
			
			// example:
			// theroot.unserializeAndEdit(data);
			// sendEditResult(true, "");
		}
		
		/**
		 * The BL API will call this function when the player wants to save a level.
		 */
		override public function blGetLvlData():void {
			// You must implement this function.
			
		    // example:
			// sendLvlData(true, theroot.serializeData());
		}
		
		/**
		 * Is called by the level manager, when your editor is loaded and the BL API is ready
		 */
		override public function blInit():void {
		    // You may implement this.
		}
		
		/**
		 * Is called by the level manager when the stop button is pressed. It's a request to show the welcome screen of your game.
		 */
		override public function blWelcome():void {
		    // You may implement this.
		}
		
		/**
		 * Is called by the level manager, when your editor is paused (put in background).
		 */
		override public function blPause():void {
			// You may implement this.
			// Don't forget to call super.blPause();
		}
		
		/**
		 * Is called by the level manager, when your editor is resumed (put in foreground).
		 */
		override public function blResume():void {
			// You may implement this.
			// Don't forget to call	super.blResume();
		}
	}
}