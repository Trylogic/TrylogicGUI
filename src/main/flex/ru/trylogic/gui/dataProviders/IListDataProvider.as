package ru.trylogic.gui.dataProviders
{


	[Event(name="changed")]
	public interface IListDataProvider extends IDataProvider
	{
		function get length() : uint;

		function addItem( item : Object ) : uint;

		function getItemAt( index : int ) : Object;

		function setItemAt( index : int, item : Object ) : void;

		function removeItemAt( index : int ) : Object;

		function removeAllItems() : void;
	}
}
