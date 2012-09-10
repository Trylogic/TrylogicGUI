package ru.trylogic.gui
{

	import flash.display.Stage;
	import flash.events.Event;

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.unitouch.UniTouch;

	import tl.ioc.IoCHelper;

	import tl.view.AbstractView;

	public class TUIComponent extends AbstractView
	{
		private static const boundsChangedEvent : Event = new Event( "boundsChanged" );
		private static const stage : Stage = IoCHelper.resolve( Stage, TUIComponentViewController );

		{
			UniTouch.stage = stage;
		}

		protected var boundsAreDirty : Boolean = false;

		public function get x() : Number
		{
			return face.x;
		}

		[Bindable]
		public function set x( value : Number ) : void
		{
			face.x = value;
		}

		public function get y() : Number
		{
			return face.y;
		}

		[Bindable]
		public function set y( value : Number ) : void
		{
			face.y = value;
		}

		public function get width() : Number
		{
			return face.width;
		}

		[Bindable]
		public function set width( value : Number ) : void
		{
			face.width = value;
		}

		public function get height() : Number
		{
			return face.height;
		}

		[Bindable]
		public function set height( value : Number ) : void
		{
			face.height = value;
		}

		public function get scaleX() : Number
		{
			return face.scaleX;
		}

		[Bindable]
		public function set scaleX( value : Number ) : void
		{
			face.scaleX = value;
		}

		public function get scaleY() : Number
		{
			return face.scaleY;
		}

		[Bindable]
		public function set scaleY( value : Number ) : void
		{
			face.scaleY = value;
		}

		public function get rotation() : Number
		{
			return face.rotation;
		}

		[Bindable]
		public function set rotation( value : Number ) : void
		{
			face.rotation = value;
		}

		public function get alpha() : Number
		{
			return face.alpha;
		}

		[Bindable]
		public function set alpha( value : Number ) : void
		{
			face.alpha = value;
		}

		public function get visible() : Boolean
		{
			return face.visible;
		}

		[Bindable]
		public function set visible( value : Boolean ) : void
		{
			face.visible = value;
		}

		public function TUIComponent()
		{
			stage.addEventListener( Event.RENDER, stage_renderHandler, false, 0, true );
		}

		override public function dispatchEvent( event : Event ) : Boolean
		{
			if ( event is PropertyChangeEvent && isPropertyAffectingAtBouns( (event as PropertyChangeEvent).property as String ) )
			{
				boundsAreDirty = true;
				stage.invalidate();
			}

			return super.dispatchEvent( event );
		}

		protected function isPropertyAffectingAtBouns( propName : String ) : Boolean
		{
			switch ( propName )
			{
				case "width":
				case "height":
				case "visible":
				case "x":
				case "y":
				case "scaleX":
				case "scaleY":
				{
					return true;
				}
					break;
			}

			return false;
		}

		protected function stage_renderHandler( event : Event ) : void
		{
			if ( !boundsAreDirty )
			{
				return;
			}

			boundsAreDirty = false;

			dispatchEvent( boundsChangedEvent );

		}
	}
}