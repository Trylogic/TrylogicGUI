package ru.trylogic.gui.containers
{

	import flash.display.Stage;
	import flash.events.Event;

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.layouts.BasicLayout;

	import ru.trylogic.gui.layouts.ILayout;
	import ru.trylogic.unitouch.UniTouch;

	import tl.ioc.IoCHelper;
	import tl.view.IDisplayObject;
	import tl.view.IView;
	import tl.view.ViewContainer;

	public class ContainerBase extends ViewContainer
	{
		protected static const boundsChangedEvent : Event = new Event( "boundsChanged" );

		[Inject]
		protected static const stage : Stage = IoCHelper.resolve( Stage, ContainerBase );

		{
			UniTouch.stage = stage;
		}

		use namespace viewInternal;

		protected var _layout : ILayout;
		private var boundsAreDirty : Boolean = false;
		private var layoutIsDirty : Boolean = false;
		private var oldWidth : Number = 0;
		private var oldHeight : Number = 0;

		override public function set subViews( value : Vector.<IView> ) : void
		{
			if ( _face )
			{
				var oldWidth : Number = width;
				var oldHeight : Number = height;
			}
			super.subViews = value;

			if ( _face )
			{
				if ( oldWidth != width )
				{
					dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", oldWidth, width ) );
				}

				if ( oldHeight != height )
				{
					dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", oldHeight, height ) );
				}
			}

			invalidateLayout();
		}

		public function get layout() : ILayout
		{
			return _layout;
		}

		[Bindable]
		public function set layout( value : ILayout ) : void
		{
			if ( _layout )
			{
				_layout.storeView( null );
			}

			_layout = value || new BasicLayout();

			_layout.storeView( this );

			invalidateLayout();
		}

		public function ContainerBase()
		{
			stage.addEventListener( Event.RENDER, validate );
		}

		override protected function lazyCreateFace() : IDisplayObject
		{
			var result : IDisplayObject = super.lazyCreateFace();
			invalidateBounds();
			return result;
		}

		protected function isPropertyAffectingAtBounds( propName : String ) : Boolean
		{
			switch ( propName )
			{
				case "x":
				case "y":
				case "scaleX":
				case "scaleY":
				case "width":
				case "height":
				case "visible":
				{
					return true;
				}
					break;
			}

			return false;
		}

		override viewInternal function installChildViewAtIndex( child : IView, index : int ) : void
		{
			super.installChildViewAtIndex( child, index );
			child.addEventListener( boundsChangedEvent.type, invalidateLayout, false, 0, true );
		}

		override viewInternal function uninstallChildView( child : IView ) : void
		{
			super.uninstallChildView( child );
			child.removeEventListener( boundsChangedEvent.type, invalidateLayout );
		}

		viewInternal function invalidateBounds( e : Event = null ) : void
		{
			if ( boundsAreDirty )
			{
				return;
			}

			boundsAreDirty = true;
			stage.invalidate();
		}

		viewInternal function invalidateLayout( e : Event = null ) : void
		{
			if ( layoutIsDirty )
			{
				return;
			}

			layoutIsDirty = true;
			stage.invalidate();
		}

		viewInternal function validate( event : Event = null ) : void
		{

			if ( boundsAreDirty )
			{
				boundsAreDirty = false;
			}

			if ( layoutIsDirty )
			{
				layoutIsDirty = false;

				_layout && _layout.invalidateLayout();
			}

			const newWidth : Number = width;
			const newHeight : Number = height;

			if ( oldWidth != newWidth || oldHeight != newHeight )
			{
				trace( "ContainerBase", "validate", this );
				if ( oldWidth != newWidth )
				{
					super.dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", oldWidth, newWidth ) );
					oldWidth = newWidth;
				}

				if ( oldHeight != newHeight )
				{
					super.dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", oldHeight, newHeight ) );
					oldHeight = newHeight;
				}

				super.dispatchEvent( boundsChangedEvent );
			}
		}
	}
}
