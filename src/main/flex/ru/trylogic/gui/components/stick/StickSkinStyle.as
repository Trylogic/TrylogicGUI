package ru.trylogic.gui.components.stick
{

	import ru.trylogic.gui.components.button.ButtonSkinStyle;
	import ru.trylogic.gui.skins.SkinStyle;

	[Bindable]
	public class StickSkinStyle extends SkinStyle
	{
		public var stickButtonSkinStyle : ButtonSkinStyle;

		public var backgroundTexture : *;

		public function StickSkinStyle()
		{
		}
	}
}
