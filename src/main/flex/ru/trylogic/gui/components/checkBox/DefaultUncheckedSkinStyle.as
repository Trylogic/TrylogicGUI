package ru.trylogic.gui.components.checkBox
{

	import flash.display.BitmapData;

	import ru.trylogic.gui.components.button.ButtonSkinStyle;

	public class DefaultUncheckedSkinStyle extends ButtonSkinStyle
	{
		public function DefaultUncheckedSkinStyle()
		{
			upTexture = new BitmapData(30, 30, false, 0xFF0000);
		}
	}
}
