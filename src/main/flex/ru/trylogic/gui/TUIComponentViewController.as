/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 04.08.12
 * Time: 13:25
 */
package ru.trylogic.gui
{

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.skins.Skin;

	import tl.view.IView;
	import tl.adapters.IViewContainerAdapter;
	import tl.viewController.IVIewController;
	import tl.viewController.ViewController;

	public class TUIComponentViewController extends ViewController implements IView
	{

		protected var _skinClass : Class;
		protected var _skin : IView;

		public function get x() : Number
		{
			return skin.face.x;
		}

		[Bindable]
		public function set x( value : Number ) : void
		{
			skin.face.x = value;
		}

		public function get y() : Number
		{
			return skin.face.y;
		}

		[Bindable]
		public function set y( value : Number ) : void
		{
			skin.face.y = value;
		}

		public function get width() : Number
		{
			return skin.face.width;
		}

		[Bindable]
		public function set width( value : Number ) : void
		{
			skin.face.width = value;
		}

		public function get height() : Number
		{
			return skin.face.height;
		}

		[Bindable]
		public function set height( value : Number ) : void
		{
			skin.face.height = value;
		}

		public function get scaleX() : Number
		{
			return skin.face.scaleX;
		}

		[Bindable]
		public function set scaleX( value : Number ) : void
		{
			skin.face.scaleX = value;
		}

		public function get scaleY() : Number
		{
			return skin.face.scaleY;
		}

		[Bindable]
		public function set scaleY( value : Number ) : void
		{
			skin.face.scaleY = value;
		}

		public function get rotation() : Number
		{
			return skin.face.rotation;
		}

		[Bindable]
		public function set rotation( value : Number ) : void
		{
			skin.face.rotation = value;
		}

		public function get alpha() : Number
		{
			return skin.face.alpha;
		}

		[Bindable]
		public function set alpha( value : Number ) : void
		{
			skin.face.alpha = value;
		}

		public function get visible() : Boolean
		{
			return skin.face.visible;
		}

		[Bindable]
		public function set visible( value : Boolean ) : void
		{
			skin.face.visible = value;
		}

		public function get name() : String
		{
			return skin.face.name;
		}

		[Bindable]
		public function set name( value : String ) : void
		{
			skin.face.name = value;
		}

		public function TUIComponentViewController()
		{
		}

		[Bindable(event="propertyChange")]
		public function get face() : *
		{
			return skin.face;
		}

		[Bindable(event="propertyChange")]
		public function get skin() : IView
		{
			if ( _skin == null )
			{
				_skin = new _skinClass();
				_skin['hostComponent'] = this;
				initWithView( _skin );
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "skin", null, _skin ) );
			}
			return _skin;
		}

		override protected function get view() : IView
		{
			return skin;
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
			return skin.currentState;
		}

		public function set currentState( value : String ) : void
		{
			skin.currentState = value;
		}

		[ArrayElementType("mx.states.State")]
		public function get states() : Array
		{
			return skin.states;
		}

		public function set states( value : Array ) : void
		{
			skin.states = value;
		}

		[ArrayElementType("mx.states.Transition")]
		public function get transitions() : Array
		{
			return skin.transitions;
		}

		public function set transitions( value : Array ) : void
		{
			skin.transitions = value;
		}

		public function hasState( stateName : String ) : Boolean
		{
			return skin.hasState( stateName );
		}
	}
}
