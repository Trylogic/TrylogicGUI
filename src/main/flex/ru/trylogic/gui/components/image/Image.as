package ru.trylogic.gui.components.image
{

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.*;
	import ru.trylogic.gui.adapters.IImageAdapter;

	import tl.viewController.outlet;

	public class Image extends TUIComponentViewController
	{
		use namespace viewControllerInternal;
		use namespace outlet;

		outlet var adapter : IImageAdapter;

		public function get texture() : *
		{
			return adapter ? adapter.component_texture : null;
		}

		[Bindable]
		public function set texture( value : * ) : void
		{
			if ( value is Class )
			{
				texture = new value();
				return;
			}

			adapter.component_texture = value;

			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", 0, face.width ) );
			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", 0, face.height ) );
		}

		public function Image()
		{
			skinClass ||= ImageSkin;
		}
	}
}
