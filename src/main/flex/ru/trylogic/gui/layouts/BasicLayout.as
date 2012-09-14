package ru.trylogic.gui.layouts
{

	import ru.trylogic.gui.containers.ContainerBase;

	public class BasicLayout implements ILayout
	{
		protected var view : ContainerBase;

		public function BasicLayout()
		{
		}

		public function storeView( view : ContainerBase ) : void
		{
			this.view = view;
		}

		public function invalidateLayout() : void
		{
		}
	}
}
