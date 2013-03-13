package attributes {
	import flash.display.BitmapData;

	public class Assets {
		
		[Embed(source = "../assets/block_blue.png")]
		private static const Blue:Class;
		[Embed(source = "../assets/block_green.png")]
		private static const Green:Class;
		[Embed(source = "../assets/block_orange.png")]
		private static const Orange:Class;
		[Embed(source = "../assets/block_purple.png")]
		private static const Purple:Class;
		[Embed(source = "../assets/block_red.png")]
		private static const Red:Class;
		[Embed(source = "../assets/block_white.png")]
		private static const White:Class;
		[Embed(source = "../assets/block_yellow.png")]
		private static const Yellow:Class;
		
		[Embed(source = "../assets/board_off.png")]
		private static const Board_0ff:Class;
		[Embed(source = "../assets/board_on.png")]
		private static const Board_On:Class;
		
		
		public static var
			wall:BitmapData,
			blocks:Array,
			holds:Array,
			boards:Array;
		
		public static function init():void {
			blocks = new Array(new Blue().bitmapData, new Green().bitmapData, new Orange().bitmapData, new Purple().bitmapData,
				new Red().bitmapData, new White().bitmapData, new Yellow().bitmapData);
				
			boards = new Array(new Board_0ff().bitmapData, new Board_On().bitmapData);
		}
	}
}