package ru.trylogic.gui.layouts
{

	import tl.view.IView;

	public class HorizontalLayout extends BasicLayout
	{
		protected var _hspace : Number = 0;

		public function get hspace() : Number
		{
			return _hspace;
		}

		[Bindable]
		public function set hspace( value : Number ) : void
		{
			_hspace = value;
			invalidateLayout();
		}

		public function HorizontalLayout()
		{
		}

		override public function invalidateLayout() : void
		{
			if ( !view )
			{
				return;
			}

			var newPosition : Number = 0;

			for each( var subView : IView in view.subViews )
			{
				subView.face.x = newPosition;
				//subView.face.y = 0;
				newPosition += subView.face.width + _hspace;
			}
		}
	}
}
