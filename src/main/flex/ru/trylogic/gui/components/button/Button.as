package ru.trylogic.gui.components.button
{

	import flash.events.Event;

	import mx.states.State;

	import ru.trylogic.gui.TUIComponentViewController;

	import ru.trylogic.unitouch.gestures.TapGesture;
	import ru.trylogic.unitouch.gestures.abstract.GestureEvent;

	import tl.viewController.outlet;

	use namespace outlet;

	[Event(name="tap")]
	[SkinState("up")]
	[SkinState("down")]
	[SkinState("disabled")]
	public class Button extends TUIComponentViewController
	{
		public static const TAP_EVENT : Event = new Event( "tap" );

		[Bindable]
		public var text : String = "";

		[Bindable]
		public var skinStyle : ButtonSkinStyle = new DefaultButtonSkinStyle();

		outlet var upState : State;

		outlet var downState : State;

		outlet var disabledState : State;

		protected var tapGesture : TapGesture;

		[Bindable]
		public function set disabled( value : Boolean ) : void
		{
			if ( value )
			{
				view.currentState = disabledState.name;
			}
			else if ( view.currentState == disabledState.name )
			{
				view.currentState = upState.name;
			}
		}

		public function get disabled() : Boolean
		{
			return view.currentState == disabledState.name;
		}

		public function Button()
		{
			skinClass = ButtonSkin;
		}

		override lifecycle function viewLoaded() : void
		{
			if ( tapGesture )
			{
				tapGesture.dispose();
			}

			tapGesture = new TapGesture();
			tapGesture.target = face;
			tapGesture.addEventListener( GestureEvent.POSSIBLE, tapGesture_onPossible, false, 0, true );
			tapGesture.addEventListener( GestureEvent.RECOGNIZED, tapGesture_onRecognized, false, 0, true );
			tapGesture.addEventListener( GestureEvent.FAILED, tapGesture_onFailed, false, 0, true );
			tapGesture.addEventListener( GestureEvent.CANCELED, tapGesture_onFailed, false, 0, true );
		}

		protected function tapGesture_onPossible( event : GestureEvent ) : void
		{
			if ( view.currentState == disabledState.name )
			{
				return;
			}

			view.currentState = downState.name;
			dispatchEvent( event );
		}

		protected function tapGesture_onRecognized( event : GestureEvent ) : void
		{
			if ( view.currentState == disabledState.name )
			{
				return;
			}

			view.currentState = upState.name;
			dispatchEvent( TAP_EVENT );
		}

		protected function tapGesture_onFailed( event : GestureEvent ) : void
		{
			if ( view.currentState == disabledState.name )
			{
				return;
			}

			view.currentState = upState.name;
			dispatchEvent( event );
		}
	}
}
