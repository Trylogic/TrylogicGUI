/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 04.08.12
 * Time: 13:25
 */
package ru.trylogic.gui
{

	import flash.display.Stage;
	import flash.events.Event;

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.unitouch.UniTouch;

	import spark.components.supportClasses.SkinnableComponent;

	import tl.ioc.IoCHelper;

	import tl.view.IView;
	import tl.viewController.IVIewController;

	public class TUIComponentViewController extends SkinnableComponent implements IView
	{
		private static const boundsChangedEvent : Event = new Event( "boundsChanged" );
		private static const stage : Stage = IoCHelper.resolve( Stage, TUIComponentViewController );

		{
			UniTouch.stage = stage;
		}

		protected var boundsAreDirty : Boolean = false;

		protected var _skinClass : Class;

		use namespace viewControllerInternal;

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

		public function get face() : *
		{
			return view.face;
		}

		override protected function get view() : IView
		{
			if ( _viewInstance == null )
			{
				var viewInstance : IView = new _skinClass();
				viewInstance.addEventListener( "boundsChanged", dispatchEvent, false, 0, true );
				viewInstance['hostComponent'] = this;
				initWithView( viewInstance );
			}
			return _viewInstance;
		}

		public function get skinClass() : Class
		{
			return _skinClass;
		}

		public function set skinClass( value : Class ) : void
		{
			if ( _skinClass == value )
			{
				return;
			}

			_skinClass = value;
		}

		public function get controller() : IVIewController
		{
			return this;
		}

		public function get currentState() : String
		{
			return view.currentState;
		}

		public function set currentState( value : String ) : void
		{
			view.currentState = value;
		}

		[ArrayElementType("mx.states.State")]
		public function get states() : Array
		{
			return view.states;
		}

		public function set states( value : Array ) : void
		{
			view.states = value;
		}

		[ArrayElementType("mx.states.Transition")]
		public function get transitions() : Array
		{
			return view.transitions;
		}

		public function set transitions( value : Array ) : void
		{
			view.transitions = value;
		}

		protected function get skinParts() : Object
		{
			return null;
		}

		public function TUIComponentViewController()
		{
			stage.addEventListener( Event.RENDER, stage_renderHandler );
		}

		public function hasState( stateName : String ) : Boolean
		{
			return view.hasState( stateName );
		}

		override viewControllerInternal function installView() : void
		{
			super.installView();

			if ( _viewInstance )
			{
				_viewInstance.addEventListener( "boundsChanged", dispatchEvent, false, 0, true );
				for ( var skinPart : String in skinParts )
				{
					if ( skinParts[skinPart] == false && !Object( _viewInstance ).hasOwnProperty( skinPart ) )
					{
						continue;
					}

					this[skinPart] = _viewInstance[skinPart];
				}
			}
		}

		override viewControllerInternal function uninstallView() : void
		{
			super.uninstallView();

			if ( _viewInstance )
			{
				_viewInstance.removeEventListener( "boundsChanged", dispatchEvent );
			}

			for ( var skinPart : String in skinParts )
			{
				this[skinPart] = null;
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
	}
}
