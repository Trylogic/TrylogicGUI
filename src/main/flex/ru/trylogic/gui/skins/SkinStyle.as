package ru.trylogic.gui.skins
{

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import ru.trylogic.gui.components.SkinnableTrylogicComponent;
	import ru.trylogic.gui.components.TrylogicComponent;

	[Bindable]
	public class SkinStyle extends EventDispatcher
	{
		protected const oldDestinationHolder : Dictionary = new Dictionary( true );

		public function set destination( value : TrylogicComponent ) : void
		{
			for ( var oldDestination : Object in oldDestinationHolder )
			{
				break;
			}

			if ( value == oldDestination )
			{
				return;
			}

			if ( oldDestination )
			{
				oldDestination["skinStyle"] = null;
				delete oldDestinationHolder[oldDestination];
			}

			value["skinStyle"] = this;

			oldDestinationHolder[value] = true;
		}

		public function SkinStyle()
		{
		}
	}
}
