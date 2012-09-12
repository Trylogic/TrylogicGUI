package ru.trylogic.gui.layouts
{

	import ru.trylogic.gui.containers.ContainerBase;

	public interface ILayout
	{
		function storeView( view : ContainerBase ) : void;

		function invalidateLayout() : void;
	}
}
