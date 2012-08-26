package ru.trylogic.gui.adapters
{

	import flash.display.BitmapData;

	public class TextureFrame
	{
		public var atlasBD : BitmapData;
		public var x : Number = 0;
		public var y : Number = 0;
		public var width : Number = 1;
		public var height : Number = 1;

		public var frameX : Number = 0;
		public var frameY : Number = 0;
		public var frameWidth : Number = 1;
		public var frameHeight : Number = 1;

		public function TextureFrame( atlasBD : BitmapData = null, x : Number = 0, y : Number = 0, width : Number = 0, height : Number = 0, frameX : Number = 0, frameY : Number = 0, frameWidth : Number = 1, frameHeight : Number = 1 )
		{
			this.atlasBD = atlasBD;
			this.x = x;
			this.y = y;
			this.width = width;
			this.height = height;
			this.frameX = frameX;
			this.frameY = frameY;
			this.frameWidth = frameWidth;
			this.frameHeight = frameHeight;
		}
	}
}
