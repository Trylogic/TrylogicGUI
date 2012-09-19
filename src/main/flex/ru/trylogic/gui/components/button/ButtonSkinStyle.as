package ru.trylogic.gui.components.button
{

	import ru.trylogic.gui.components.textField.TextFieldSkinStyle;
	import ru.trylogic.gui.skins.SkinStyle;

	[Bindable]
	public class ButtonSkinStyle extends SkinStyle
	{
		public var upTexture : *;

		public var downTexture : *;

		public var disabledTexture : *;

		public var iconTexture : *;

		public var textFieldSkinStyle : TextFieldSkinStyle = new TextFieldSkinStyle();

		public function ButtonSkinStyle()
		{
		}
	}
}
