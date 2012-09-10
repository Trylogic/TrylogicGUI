package ru.trylogic.gui.containers
{

	import flash.display.Stage;
	import flash.events.Event;

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.containers.layouts.BasicLayout;

	import ru.trylogic.gui.containers.layouts.ILayout;
	import ru.trylogic.unitouch.UniTouch;

	import tl.ioc.IoCHelper;
	import tl.view.IView;
	import tl.view.ViewContainer;

	public class ContainerBase extends ViewContainer
	{
		[Inject]
		protected static const stage : Stage = IoCHelper.resolve( Stage, ContainerBase );

		{
			UniTouch.stage = stage;
		}

		protected var dirty : Boolean = false;

		protected var _layout : ILayout;

		public function get isDirty() : Boolean
		{
			return dirty;
		}

		public function get layout() : ILayout
		{
			return _layout;
		}

		//[Bindable]
		public function set layout( value : ILayout ) : void
		{
			if ( value == _layout )
			{
				return;
			}

			if ( _layout )
			{
				_layout.storeView( null );
			}

			_layout = value || new BasicLayout();

			_layout.storeView( this );

			invalidateLayout();
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

		[Bindable(event="propertyChange")]
		public function get width() : Number
		{
			return face.width;
		}

		[Bindable(event="propertyChange")]
		public function get height() : Number
		{
			return face.height;
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

		public function ContainerBase()
		{
		}

		override public function set subViews( value : Vector.<IView> ) : void
		{
			super.subViews = value;

			invalidateLayout();
		}

		override public function addView( element : IView ) : void
		{
			super.addView( element );
			element.addEventListener( "boundsChanged", invalidateLayout );
		}

		override public function removeView( element : IView ) : void
		{
			element.removeEventListener( "boundsChanged", invalidateLayout );
			super.removeView( element );
		}

		protected function invalidateLayout( ...args ) : void
		{
			if ( _layout != null )
			{
				//trace( "invalidateLayout", _layout );
				var oldWidth : Number = width;
				var oldHeight : Number = height;
				_layout.invalidateLayout();

				if ( oldWidth != width || oldHeight != height )
				{
					dispatchEvent( new Event( "boundsChanged" ) );
				}

				if ( oldWidth != width )
				{
					dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", oldWidth, width ) );
				}

				if ( oldHeight != height )
				{
					dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", oldHeight, height ) );
				}
			}
			else
			{
				dispatchEvent( new Event( "boundsChanged" ) );
			}
		}
	}
}
