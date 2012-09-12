package ru.trylogic.gui.containers
{

	import flash.display.Stage;
	import flash.events.Event;

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.layouts.BasicLayout;

	import ru.trylogic.gui.layouts.ILayout;
	import ru.trylogic.unitouch.UniTouch;

	import tl.ioc.IoCHelper;
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
			if ( !boundsAreDirty )
			{
				return;
			}

			boundsAreDirty = false;

			dispatchEvent( boundsChangedEvent );

		}

		override public function set subViews( value : Vector.<IView> ) : void
		{
			super.subViews = value;

			invalidateLayout();
		}

		override public function addView( element : IView ) : void
		{
			super.addView( element );
			element.addEventListener( boundsChangedEvent.type, invalidateLayout, false, 0, true );
		}

		override public function removeView( element : IView ) : void
		{
			element.removeEventListener( boundsChangedEvent.type, invalidateLayout );
			super.removeView( element );
		}

		protected function invalidateLayout( e : Event = null ) : void
		{
			if ( _layout != null )
			{
				//trace( "ContainerBase", "invalidateLayout", _layout, this );
				var oldWidth : Number = width;
				var oldHeight : Number = height;

				_layout.invalidateLayout();

				if ( oldWidth != width || oldHeight != height )
				{
					invalidate();

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
				invalidate();
			}
		}
	}
}
