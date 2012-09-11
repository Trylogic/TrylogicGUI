package ru.trylogic.gui.layouts
{

	import tl.view.IView;

	public class VerticalLayout extends BasicLayout
	{
		protected var _vspace : Number = 0;

		public function get vspace() : Number
		{
			return _vspace;
		}

		[Bindable]
		public function set vspace( value : Number ) : void
		{
			_vspace = value;
			invalidateLayout();
		}

		public function VerticalLayout()
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
				//subView.face.x = 0;
				subView.face.y = newPosition;
				newPosition += subView.face.height + _vspace;
			}
		}
	}
}
