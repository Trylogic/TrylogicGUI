package ru.trylogic.gui.containers
{

	import flash.geom.Rectangle;

	import ru.trylogic.gui.TUIComponentViewController;

	import tl.adapters.IViewContainerAdapter;
	import tl.view.IView;
	import tl.view.ViewContainer;

	[DefaultProperty("subViews")]
	public class SimpleContainer extends TUIComponentViewController implements IViewContainerAdapter
	{
		use namespace viewControllerInternal;

		protected var container : ViewContainer;

		protected var _subViews : Vector.<IView>;

		public function SimpleContainer()
		{
			skinClass = ViewContainer;
		}

		override protected function get view() : IView
		{
			if ( _viewInstance == null )
			{
				container = new _skinClass();
				if ( _subViews )
				{
					container.subViews = _subViews;
				}
				initWithView( container );
			}
			return _viewInstance;
		}

		public function set viewScrollRect( value : Rectangle ) : void
		{
			if ( container )
			{
				container.viewScrollRect = value;
			}
		}

		public function get viewScrollRect() : Rectangle
		{
			return container ? container.viewScrollRect : null;
		}

		public function get numViews() : uint
		{
			return container ? container.numViews : 0;
		}

		public function set subViews( value : Vector.<IView> ) : void
		{
			if ( container )
			{
				container.subViews = value;
			}
			else
			{
				_subViews = value;
			}
		}

		public final function get subViews() : Vector.<IView>
		{
			return container ? subViews : null;
		}

		public function addView( element : IView ) : void
		{
			if ( container )
			{
				container.addView( element );
			}
		}

		public function addViewAtIndex( element : IView, index : int ) : void
		{
			if ( container )
			{
				container.addViewAtIndex( element, index );
			}
		}

		public function setViewIndex( element : IView, index : int ) : void
		{
			if ( container )
			{
				container.setViewIndex( element, index );
			}
		}

		public function removeViewAt( index : int ) : void
		{
			if ( container )
			{
				container.removeViewAt( index );
			}
		}

		public function removeView( element : IView ) : void
		{
			if ( container )
			{
				container.removeView( element );
			}
		}
	}
}