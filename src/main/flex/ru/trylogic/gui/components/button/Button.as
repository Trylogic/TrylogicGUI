package ru.trylogic.gui.components.button
{

	import flash.events.Event;

	import ru.trylogic.unitouch.gestures.TapGesture;
	import ru.trylogic.unitouch.gestures.abstract.GestureEvent;

	import ru.trylogic.gui.components.SkinnableTrylogicComponent;

	import tl.viewController.outlet;

	use namespace outlet;

	[Event(name="tap")]
	[SkinState("up")]
	[SkinState("down")]
	[SkinState("disabled")]
	public class Button extends SkinnableTrylogicComponent
	{
		public static const TAP_EVENT : Event = new Event( "tap" );

		[Bindable]
		public var text : String = "";

		[Bindable]
		public var skinStyle : ButtonSkinStyle = new DefaultButtonSkinStyle();

		protected var tapGesture : TapGesture;

		[Bindable]
		public function set disabled( value : Boolean ) : void
		{
			if ( value )
			{
				view.currentState = "disabled";
			}
			else if ( disabled )
			{
				view.currentState = "up";
			}
		}

		public function get disabled() : Boolean
		{
			return view.currentState == "disabled";
		}

		public function Button()
		{
			skinClass = ButtonSkin;
		}

		override lifecycle function viewLoaded() : void
		{
			super.lifecycle::viewLoaded();
			if ( tapGesture )
			{
				tapGesture.dispose();
			}

			tapGesture = new TapGesture();
			tapGesture.target = face;
			tapGesture.addEventListener( GestureEvent.POSSIBLE, tapGesture_onPossible, false, 0, true );
			tapGesture.addEventListener( GestureEvent.RECOGNIZED, tapGesture_onRecognized, false, 0, true );
			tapGesture.addEventListener( GestureEvent.FAILED, tapGesture_onFailed, false, 0, true );
		}

		protected function tapGesture_onPossible( event : GestureEvent ) : void
		{
			if ( disabled )
			{
				return;
			}

			view.currentState = "down";
			dispatchEvent( event );
		}

		protected function tapGesture_onRecognized( event : GestureEvent ) : void
		{
			if ( disabled )
			{
				return;
			}

			view.currentState = "up";
			dispatchEvent( TAP_EVENT );
		}

		protected function tapGesture_onFailed( event : GestureEvent ) : void
		{
			if ( disabled )
			{
				return;
			}

			view.currentState = "up";
			dispatchEvent( event );
		}
	}
}
