package ru.trylogic.gui.layouts
{

	import tl.view.ViewContainer;

	public interface ILayout
	{
		function storeView( view : ViewContainer ) : void;

		function invalidateLayout() : void;
	}
}
