package ru.trylogic.gui.components.checkBox
{

	import flash.events.Event;

	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;

	import mx.states.State;

	import ru.trylogic.gui.TUIComponentViewController;
	import ru.trylogic.gui.components.button.Button;
	import ru.trylogic.gui.components.button.ButtonSkinStyle;

	/*
 смотри, что надо сделать:

 1) делаешь компонент (Checkbox extends TUIComponentViewController)
 2) у него свойства: label : String , checked : Boolean = false
 3) должен диспатчить событие changed
 в скине у тебя должны быть:
 2 кнопки (checkedButton и uncheckedButton) и TextField
 2 состояния (checked, unhecked)
 в контроллере по тапу на кнопке переключаешь состояние

 а, да

 в CheckboxSkinStyle должны быть 2 свойства типа ButtonSkinStyle: checkedButtonSkinStyle и uncheckedButtonSkinStyle

 короче, смотри) делаем одну единственную кнопку, в ней делаем
 skinStyle.checked="{hostComponent.skinStyle.checkedSkinStyle}"
 skinStyle.unchecked="{hostComponent.skinStyle.uncheckedSkinStyle}", во

*/

	public class CheckBox extends TUIComponentViewController
	{
		public static const CHANGED_EVENT : Event = new Event( "changed" );

		[Bindable]
		public var label : String = "";

		[Bindable]
		public var skinStyle : CheckBoxSkinStyle = null;//***

		[Outlet]
		public var checkedState : State;

		[Outlet]
		public var uncheckedState : State;

		[Outlet]
		public var checkButton : Button;

		private var _checked : Boolean = false;

		override lifecycle function viewLoaded() : void
		{
			checkButton.addEventListener(Button.TAP_EVENT.type, onCheckButtonTap);
		}

		public function CheckBox() : void
		{
			skinClass = CheckBoxSkin;
		}

		[Bindable]
		public function set checked(value : Boolean) : void
		{
			var oldValue : Boolean = _checked;
			if (oldValue != value)
			{
				_checked = value;
				view.currentState = checked ? checkedState.name : uncheckedState.name;
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
