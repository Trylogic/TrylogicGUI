package ru.trylogic.gui.components.image
{

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.*;
	import ru.trylogic.gui.adapters.IImageAdapter;

	import tl.ioc.IoCHelper;

	public class Image extends TUIComponent
	{

		[Bindable(event="propertyChange")]
		override public function get face() : *
		{
			if ( _face == null )
			{
				_face = IoCHelper.resolve( IImageAdapter, this );
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "face", null, _face ) );
			}

			return _face;
		}

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

			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", 0, face.width ) );
			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", 0, face.height ) );
		}
	}
}
