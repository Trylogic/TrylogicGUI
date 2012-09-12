package ru.trylogic.gui.components
{

	import flash.display.Stage;
	import flash.events.Event;

	import mx.core.IStateClient2;
	import mx.events.PropertyChangeEvent;

	import ru.trylogic.unitouch.UniTouch;

	import tl.ioc.IoCHelper;
	import tl.view.IDisplayObject;
	import tl.view.IView;
	import tl.viewController.IVIewController;
	import tl.viewController.ViewController;

	public class TrylogicComponent extends ViewController implements IView
	{
		private static const boundsChangedEvent : Event = new Event( "boundsChanged" );
		private static const stage : Stage = IoCHelper.resolve( Stage, TrylogicComponent );

		{
			UniTouch.stage = stage;
		}

		[Inject]
		protected var _statesImpl : IStateClient2 = IoCHelper.resolve( IStateClient2, this );

		protected var boundsAreDirty : Boolean = false;

		use namespace viewControllerInternal;

		public function get face() : IDisplayObject
		{
			return view.face;
		}

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

		public function get controller() : IVIewController
		{
			return this;
		}

		override protected function get view() : IView
		{
			return this;
		}

		public function TrylogicComponent()
		{
			stage.addEventListener( Event.RENDER, stage_renderHandler );
		}

		override viewControllerInternal function installView() : void
		{
			super.installView();

			if ( _viewInstance )
			{
				_viewInstance.addEventListener( boundsChangedEvent.type, dispatchEvent, false, 0, true );
			}
		}

		override viewControllerInternal function uninstallView() : void
		{
			super.uninstallView();

			if ( _viewInstance )
			{
				_viewInstance.removeEventListener( boundsChangedEvent.type, dispatchEvent );
			}
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
				case "x":
				case "y":
				case "scaleX":
				case "scaleY":
				case "visible":
				case "texture":
				case "skinStyle":
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

		public function get currentState() : String
		{
			return _statesImpl.currentState;
		}

		[Bindable(event="propertyChange")]
		public function set currentState( value : String ) : void
		{
			var oldValue : String = _statesImpl.currentState;
			if ( value == oldValue )
			{
				return;
			}

			_statesImpl.currentState = value;

			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "currentState", oldValue, value ) );
		}

		[ArrayElementType("mx.states.State")]
		public function get states() : Array
		{
			return _statesImpl.states;
		}

		public function set states( value : Array ) : void
		{
			if ( value == _statesImpl.states )
			{
				return;
			}

			_statesImpl.states = value;
		}

		[ArrayElementType("mx.states.Transition")]
		public function get transitions() : Array
		{
			return _statesImpl.transitions;
		}

		public function set transitions( value : Array ) : void
		{
			if ( value == _statesImpl.transitions )
			{
				return;
			}

			_statesImpl.transitions = value;
		}

		public function hasState( stateName : String ) : Boolean
		{
			return _statesImpl.hasState( stateName );
		}
	}
}
