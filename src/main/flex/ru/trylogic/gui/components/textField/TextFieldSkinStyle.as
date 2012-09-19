package ru.trylogic.gui.components.textField
{

	import ru.trylogic.gui.skins.SkinStyle;

	[Bindable]
	public class TextFieldSkinStyle extends SkinStyle
	{

		public var fontSize : uint = 20;

		public var fontName : String;

		public var fontColor : uint = 0x00000000;

		public function TextFieldSkinStyle()
		{
		}
	}
}
