package ru.trylogic.gui.dataProviders
{

	import flash.events.EventDispatcher;

	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;

	import ru.trylogic.gui.dataProviders.IListDataProvider;

	[Event(name="changed")]
	[DefaultProperty("data")]
	public class ArrayDataProvider extends EventDispatcher implements IListDataProvider
	{
		protected var _data : Array = [];

		public function get data() : Array
		{
			return _data;
		}

		[Bindable(event="changed")]
		public function set data( value : Array ) : void
		{
			if ( _data == value )
			{
				return;
			}

			_data = value;
			invalidate();
		}

		public function get length() : uint
		{
			return _data.length;
		}

		public function ArrayDataProvider()
		{
		}

		public function getItemAt( index : int ) : *
		{
			return _data[index];
		}

		public function setItemAt( index : int, item : * ) : void
		{
			_data[index] = item;
			invalidate();
		}

		public function removeItemAt( index : int ) : *
		{
			var item : * = _data[index];
			_data.splice( index, 1 );
			invalidate();
			return item;
		}

		public function removeAllItems() : void
		{
			_data.length = 0;
			invalidate();
		}

		public function addItem( item : * ) : uint
		{
			var result : uint = _data.push( item );
			invalidate();
			return result;
		}

		public function invalidate() : void
		{
			dispatchEvent( new PropertyChangeEvent( "changed", false, false, PropertyChangeEventKind.UPDATE, "data", null, data ) );
		}
	}
}
