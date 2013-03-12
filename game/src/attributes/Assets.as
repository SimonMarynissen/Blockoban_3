package attributes {
	import flash.display.BitmapData;

	public class Assets {
		
		[Embed(source = "../assets/Blue Square.png")]
		private static const Blue:Class;
		[Embed(source = "../assets/Green Square.png")]
		private static const Green:Class;
		[Embed(source = "../assets/Orange Square.png")]
		private static const Orange:Class;
		[Embed(source = "../assets/Purple Square.png")]
		private static const Purple:Class;
		[Embed(source = "../assets/Red Square.png")]
		private static const Red:Class;
		[Embed(source = "../assets/White Square.png")]
		private static const White:Class;
		[Embed(source = "../assets/Yellow Square.png")]
		private static const Yellow:Class;
		
		[Embed(source = "../assets/Temp Wall Block.png")]
		private static const Wall:Class;
		
		[Embed(source = "../assets/red hold.png")]
		private static const Red_Hold:Class;
		[Embed(source = "../assets/yellow hold.png")]
		private static const Yellow_Hold:Class;
		
		[Embed(source = "../assets/button_undo.png")]
		private static const Button_Undo:Class;
		
		[Embed(source = "../assets/Background Tile.png")]
		private static const Board:Class;
		
		public static var
			blocks:Array,
			walls:Array,
			holds:Array,
			undoButton:BitmapData,
			board:BitmapData;
		
		public static function init():void {
			blocks = new Array(new Blue().bitmapData, new Green().bitmapData, new Orange().bitmapData,
				new Purple().bitmapData, new Red().bitmapData, new White().bitmapData,
				new Yellow().bitmapData);
			walls = new Array(new Wall().bitmapData);
			holds = new Array(new Red_Hold().bitmapData, new Red_Hold().bitmapData, new Red_Hold().bitmapData,
				new Red_Hold().bitmapData, new Red_Hold().bitmapData, new Red_Hold().bitmapData,
				new Yellow_Hold().bitmapData);
			undoButton = new Button_Undo().bitmapData;
			board = new Board().bitmapData;
		}
	}
}