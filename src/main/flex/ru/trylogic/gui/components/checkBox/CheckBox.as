package ru.trylogic.gui.components.checkBox
{

	import flash.events.Event;

	import ru.trylogic.gui.components.button.Button;

	import ru.trylogic.gui.components.SkinnableTrylogicComponent;

	import tl.viewController.outlet;

	use namespace outlet;

	[SkinState("checked")]
	[SkinState("unchecked")]
	public class CheckBox extends SkinnableTrylogicComponent
	{
		public static const CHANGED_EVENT : Event = new Event( "changed" );

		[Bindable]
		public var label : String = "";

		[Bindable]
		public var skinStyle : CheckBoxSkinStyle = null;

		[SkinPart(required="true")]
		public var checkButton : Button;

		private var _checked : Boolean = false;

		override lifecycle function viewLoaded() : void
		{
			checkButton.addEventListener( Button.TAP_EVENT.type, onCheckButtonTap );
		}

		public function CheckBox() : void
		{
			skinClass = CheckBoxSkin;
		}

		[Bindable]
		public function set checked( value : Boolean ) : void
		{
			var oldValue : Boolean = _checked;
			if ( oldValue != value )
			{
				_checked = value;
				view.currentState = checked ? "checked" : "unchecked";
				dispatchEvent( CHANGED_EVENT );
			}
		}

		public function get checked() : Boolean
		{
			return _checked;
		}

		protected function onCheckButtonTap( e : Event ) : void
		{
			checked = !checked;
		}
	}
}
