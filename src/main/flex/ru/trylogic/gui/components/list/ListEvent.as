package ru.trylogic.gui.components.list
{

	import flash.events.Event;

	public class ListEvent extends Event
	{
		public static const ITEM_SELECTED : String = "itemSelected";

		public var index : int;

		public function ListEvent( type : String )
		{
			super( type, false, false );
		}

		override public function clone() : Event
		{
			var newEvent : ListEvent = new ListEvent( type );
			newEvent.index = index;
			return newEvent;
		}
	}
}
