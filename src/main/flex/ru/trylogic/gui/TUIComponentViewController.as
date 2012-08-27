/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 04.08.12
 * Time: 13:25
 */
package ru.trylogic.gui
{

	import spark.components.supportClasses.SkinnableComponent;

	import tl.view.IView;
	import tl.viewController.IVIewController;

	public class TUIComponentViewController extends SkinnableComponent implements IView
	{
		use namespace viewControllerInternal;

		protected var _skinClass : Class;

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

		public function get name() : String
		{
			return face.name;
		}

		[Bindable]
		public function set name( value : String ) : void
		{
			face.name = value;
		}

		public function TUIComponentViewController()
		{
		}

		public function get face() : *
		{
			return view.face;
		}

		override protected function get view() : IView
		{
			if ( _viewInstance == null )
			{
				_viewInstance = new _skinClass();
				_viewInstance['hostComponent'] = this;
				initWithView( _viewInstance );
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

		public function hasState( stateName : String ) : Boolean
		{
			return view.hasState( stateName );
		}
	}
}
