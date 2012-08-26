package ru.trylogic.gui.components.button
{

	import flash.display.BitmapData;

	public class DefaultButtonSkinStyle extends ButtonSkinStyle
	{
		public function DefaultButtonSkinStyle()
		{
			upTexture = new BitmapData(100, 40, false, 0x00FF00);
			downTexture = new BitmapData(110, 50, false, 0x00FF00);
			disabledTexture = new BitmapData(100, 40, false, 0x808080);
		}
	}
}
