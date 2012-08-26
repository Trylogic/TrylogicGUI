package ru.trylogic.gui.containers.layouts
{

	import tl.view.ViewContainer;

	public interface ILayout
	{
		function storeView( view : ViewContainer ) : void;

		function invalidateLayout() : void;
	}
}
