package ru.trylogic.gui.containers.layouts
{

	import tl.view.ViewContainer;

	public class BasicLayout implements ILayout
	{
		protected var view : ViewContainer;

		public function BasicLayout()
		{
		}

		public function storeView( view : ViewContainer ) : void
		{
			this.view = view;
		}

		public function invalidateLayout() : void
		{
		}
	}
}
