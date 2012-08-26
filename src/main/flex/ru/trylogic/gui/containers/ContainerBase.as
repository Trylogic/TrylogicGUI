package ru.trylogic.gui.containers
{

	import flash.display.Stage;
	import flash.events.Event;

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.containers.layouts.ILayout;

	import tl.ioc.IoCHelper;
	import tl.view.IView;
	import tl.view.ViewContainer;

	public class ContainerBase extends ViewContainer
	{

		[Inject]
		protected const stage : Stage = IoCHelper.resolve(Stage, this);

		protected var dirty : Boolean = false;

		private var _layout : ILayout;

		public function get isDirty() : Boolean
		{
			return dirty;
		}

		public function get layout() : ILayout
		{
			return _layout;
		}

		[Bindable(event="propertyChange")]
		public function set layout( value : ILayout ) : void
		{
			if(value == _layout)
			{
				return;
			}

			var oldLayout : ILayout = _layout;
			if ( oldLayout )
			{
				oldLayout.storeView( null );
			}

			_layout = value;

			if ( _layout )
			{
				_layout.storeView( this );
			}

			invalidateProperty("layout", value);
		}

		public function get x() : Number
		{
			return face.x;
		}

		[Bindable(event="propertyChange")]
		public function set x( value : Number ) : void
		{
			if(value == face.x)
			{
				return;
			}

			face.x = value;
			invalidateProperty("x", value);
		}

		public function get y() : Number
		{
			return face.y;
		}

		[Bindable(event="propertyChange")]
		public function set y( value : Number ) : void
		{
			if(value == face.y)
			{
				return;
			}
			face.y = value;
			invalidateProperty("y", value);
		}

		public function get width() : Number
		{
			return face.width;
		}

		[Bindable(event="propertyChange")]
		public function set width( value : Number ) : void
		{
			if(value == face.width)
			{
				return;
			}

			face.width = value;
			invalidateProperty("width", value);
		}

		public function get height() : Number
		{
			return face.height;
		}

		[Bindable(event="propertyChange")]
		public function set height( value : Number ) : void
		{
			if(value == face.height)
			{
				return;
			}
			face.height = value;
			invalidateProperty("height", value);
		}

		public function get scaleX() : Number
		{
			return face.scaleX;
		}

		[Bindable(event="propertyChange")]
		public function set scaleX( value : Number ) : void
		{
			if(value == face.scaleX)
			{
				return;
			}
			face.scaleX = value;
			invalidateProperty("scaleX", value);
		}

		public function get scaleY() : Number
		{
			return face.scaleY;
		}

		[Bindable(event="propertyChange")]
		public function set scaleY( value : Number ) : void
		{
			if(value == face.scaleY)
			{
				return;
			}
			face.scaleY = value;
			invalidateProperty("scaleY", value);
		}

		public function get rotation() : Number
		{
			return face.rotation;
		}

		[Bindable(event="propertyChange")]
		public function set rotation( value : Number ) : void
		{
			if(value == face.rotation)
			{
				return;
			}
			face.rotation = value;
			invalidateProperty("rotation", value);
		}

		public function get alpha() : Number
		{
			return face.alpha;
		}

		[Bindable(event="propertyChange")]
		public function set alpha( value : Number ) : void
		{
			if(value == face.alpha)
			{
				return;
			}
			face.alpha = value;
			invalidateProperty("alpha", value);
		}

		public function get visible() : Boolean
		{
			return face.visible;
		}

		[Bindable(event="propertyChange")]
		public function set visible( value : Boolean ) : void
		{
			if(value == face.visible)
			{
				return;
			}
			face.visible = value;
			invalidateProperty("visible", value);
		}

		public function get name() : String
		{
			return face.name;
		}

		[Bindable(event="propertyChange")]
		public function set name( value : String ) : void
		{
			if(value == face.name)
			{
				return;
			}
			face.name = value;
			invalidateProperty("name", value);
		}

		public function ContainerBase()
		{
			controllerClass = ContainerBaseViewController;
		}

		override public function set subViews(value : Vector.<IView>) : void
		{
			super.subViews = value;

			invalidateProperty("subViews", value);
		}

		public function invalidate() : void
		{
			if(dirty)
			{
				return;
			}

			trace("invalidate " + this + " " + layout);
			dirty = true;
			stage.invalidate();
		}

		public function validate() : void
		{
			if(!dirty)
			{
				return;
			}

			trace("validate " + this + " " + layout);

			var oldWidth : Number = width;
			var oldHeight : Number = height;

			if(_layout)
			{
				_layout.invalidateLayout();
			}
			dirty = false;

			if(oldWidth != width)
			{
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "width", oldWidth, width));
			}

			if(oldHeight != height)
			{
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "height", oldHeight, height));
			}
		}

		protected function invalidateProperty(prop : String, value : *) : void
		{
			trace("invalidateProperty [" + prop + "] on " + this + " withValue: " + value);
			invalidate();
			dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, prop, null, value));
		}
	}
}
