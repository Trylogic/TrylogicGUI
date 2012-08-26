package ru.trylogic.gui.components.checkBox
{

	import ru.trylogic.gui.components.button.ButtonSkinStyle;
	import ru.trylogic.gui.skins.SkinStyle;

	[Bindable]
	public class CheckBoxSkinStyle extends SkinStyle
	{
		public var checkedButtonSkinStyle : ButtonSkinStyle = new DefaultCheckedSkinStyle();

		public var uncheckedButtonSkinStyle : ButtonSkinStyle = new DefaultUncheckedSkinStyle();

		public function CheckBoxSkinStyle()
		{
		}
	}
}