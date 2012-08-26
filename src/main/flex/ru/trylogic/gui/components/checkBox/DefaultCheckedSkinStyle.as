package ru.trylogic.gui.components.checkBox
{
	import flash.display.BitmapData;

	import ru.trylogic.gui.components.button.ButtonSkinStyle;

	public class DefaultCheckedSkinStyle extends ButtonSkinStyle
	{
		public function DefaultCheckedSkinStyle()
		{
			upTexture = new BitmapData(30, 30, false, 0x00FF00);
		}
	}
}
