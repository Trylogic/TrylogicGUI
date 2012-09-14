package ru.trylogic.gui.skins
{

	import flash.events.EventDispatcher;
	import flash.utils.Dictionary;

	import ru.trylogic.gui.components.SkinnableTrylogicComponent;

	[Bindable]
	public class SkinStyle extends EventDispatcher
	{
		protected const oldDestinationHolder : Dictionary = new Dictionary( true );

		public function set destination( value : SkinnableTrylogicComponent ) : void
		{
			var oldDestination : Object;
			for ( oldDestination in oldDestinationHolder )
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
			}

			delete oldDestinationHolder[oldDestination];

			value["skinStyle"] = this;

			oldDestinationHolder[value] = true;
		}

		public function SkinStyle()
		{
		}
	}
}
