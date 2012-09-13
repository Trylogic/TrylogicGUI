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

		protected var dirty : Boolean = false;

		protected var _layout : ILayout;
		private var boundsAreDirty : Boolean = false;
		private var layoutIsDirty : Boolean = false;

		public function get isDirty() : Boolean
		{
			return dirty;
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
			stage.addEventListener( Event.RENDER, stage_renderHandler );
		}

		protected function invalidate( e : Event = null ) : void
		{
			boundsAreDirty = true;
			stage.invalidate();
		}

		override public function dispatchEvent( event : Event ) : Boolean
		{
			if ( event is PropertyChangeEvent && isPropertyAffectingAtBouns( (event as PropertyChangeEvent).property as String ) )
			{
				invalidate();
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

		protected function stage_renderHandler( event : Event ) : void
		{
			var needsDispatch : Boolean = false;
			if ( boundsAreDirty )
			{
				boundsAreDirty = false;

				needsDispatch = true;
			}

			if ( layoutIsDirty )
			{
				if ( _layout != null )
				{
					//trace( "ContainerBase", "invalidateLayout", _layout, this );
					var oldWidth : Number = width;
					var oldHeight : Number = height;

					_layout.invalidateLayout();

					if ( oldWidth != width || oldHeight != height )
					{
						needsDispatch = true;

						if ( oldWidth != width )
						{
							dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", oldWidth, width ) );
						}

						if ( oldHeight != height )
						{
							dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", oldHeight, height ) );
						}
					}
				}
				else
				{
					needsDispatch = true;
				}
			}

			if ( needsDispatch )
			{
				dispatchEvent( boundsChangedEvent );
			}

		}

		override public function set subViews( value : Vector.<IView> ) : void
		{
			var element : IView;

			for each ( element in _subViews )
			{
				element.removeEventListener( boundsChangedEvent.type, invalidateLayout );
			}

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

			for each( element in _subViews )
			{
				element.addEventListener( boundsChangedEvent.type, invalidateLayout, false, 0, true );
			}

			invalidateLayout();
		}

		protected function invalidateLayout( e : Event = null ) : void
		{
			layoutIsDirty = true;
			stage.invalidate();
		}

		override protected function lazyCreateFace() : IDisplayObject
		{
			var result : IDisplayObject = super.lazyCreateFace();
			invalidate();
			return result;
		}
	}
}
