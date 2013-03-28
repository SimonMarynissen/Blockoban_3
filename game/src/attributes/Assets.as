package attributes {
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Assets {
		
		[Embed(source="../assets/Blue-Square.png")]
		private static const Blue:Class;
		[Embed(source="../assets/Green-Square.png")]
		private static const Green:Class;
		[Embed(source="../assets/Orange-Square.png")]
		private static const Orange:Class;
		[Embed(source="../assets/Purple-Square.png")]
		private static const Purple:Class;
		[Embed(source="../assets/Red-Square.png")]
		private static const Red:Class;
		[Embed(source="../assets/White-Square.png")]
		private static const White:Class;
		[Embed(source="../assets/Yellow-Square.png")]
		private static const Yellow:Class;
		
		[Embed(source = "../assets/Blue-Circle.png")]
		private static const Blue_Circle:Class;
		[Embed(source = "../assets/Green-Circle.png")]
		private static const Green_Circle:Class;
		[Embed(source = "../assets/Orange-Circle.png")]
		private static const Orange_Circle:Class;
		[Embed(source = "../assets/Purple-Circle.png")]
		private static const Purple_Circle:Class;
		[Embed(source = "../assets/Red-Circle.png")]
		private static const Red_Circle:Class;
		[Embed(source = "../assets/White-Circle.png")]
		private static const White_Circle:Class;
		[Embed(source = "../assets/Yellow-Circle.png")]
		private static const Yellow_Circle:Class;
		
		[Embed(source="../assets/auto-dark.png")]
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
			blocks_square:Array,
			blocks_circle:Array,
			walls:Array,
			holds:Array,
			undoButton:BitmapData,
			board:BitmapData;
		
		public static function init():void {
			blocks_square = new Array(new Blue().bitmapData, new Green().bitmapData, new Orange().bitmapData,
				new Purple().bitmapData, new Red().bitmapData, new White().bitmapData,
				new Yellow().bitmapData);
			blocks_circle = new Array(new Blue_Circle().bitmapData, new Green_Circle().bitmapData, new Orange_Circle().bitmapData,
				new Purple_Circle().bitmapData, new Red_Circle().bitmapData, new White_Circle().bitmapData,
				new Yellow_Circle().bitmapData);
			walls = new Array();
			var wall:BitmapData = new Wall().bitmapData;
			for (var i:int = 0; i < 20; i++) {
				var bit:BitmapData = new BitmapData(48, 48, true, 0);
				bit.copyPixels(wall, new Rectangle(48 * i, 0, 48, 48), new Point(0, 0), null, null, true);
				walls.push(bit);
			}
			holds = new Array(new Red_Hold().bitmapData, new Red_Hold().bitmapData, new Red_Hold().bitmapData,
				new Red_Hold().bitmapData, new Red_Hold().bitmapData, new Red_Hold().bitmapData,
				new Yellow_Hold().bitmapData);
			undoButton = new Button_Undo().bitmapData;
			board = new Board().bitmapData;
		}
	}
}