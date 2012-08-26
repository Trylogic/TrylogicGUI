package ru.trylogic.gui.dataProviders
{

	import ru.trylogic.gui.dataProviders.IDataProvider;

	[Event(name="changed")]
	public interface IListDataProvider extends IDataProvider
	{
		function get length() : uint;

		function addItem(item : *) : uint;

		function getItemAt(index : int) : *;

		function setItemAt(index : int, item : *) : void;

		function removeItemAt(index : int) : *;

		function removeAllItems() : void;
	}
}
