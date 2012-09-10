package ru.trylogic.gui.components.image
{

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.*;
	import ru.trylogic.gui.adapters.IImageAdapter;

	import tl.ioc.IoCHelper;

	public class Image extends TUIComponent
	{
		public function get texture() : *
		{
			return _face == null ? null : IImageAdapter( _face ).component_texture;
		}

		[Bindable]
		public function set texture( value : * ) : void
		{
			if ( value is Class )
			{
				texture = new value();
				return;
			}

			IImageAdapter( face ).component_texture = value;

			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", 0, width ) );
			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", 0, height ) );
		}

		override protected function lazyCreateFace() : *
		{
			return IoCHelper.resolve( IImageAdapter, this );
		}

		override protected function isPropertyAffectingAtBouns( propName : String ) : Boolean
		{
			return propName == "texture" || super.isPropertyAffectingAtBouns( propName );
		}
	}
}
