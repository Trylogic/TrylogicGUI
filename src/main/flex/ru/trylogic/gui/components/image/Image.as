package ru.trylogic.gui.components.image
{

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.adapters.IImageAdapter;
	import ru.trylogic.gui.components.TrylogicComponent;

	import tl.ioc.IoCHelper;
	import tl.view.IDisplayObject;

	public class Image extends TrylogicComponent
	{
		protected var _face : IImageAdapter;

		public function get texture() : *
		{
			return _face == null ? null : _face.component_texture;
		}

		[Bindable(event="propertyChange")]
		public function set texture( value : * ) : void
		{
			if ( value is Class )
			{
				texture = new value();
				return;
			}

			(face as IImageAdapter).component_texture = value;
			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "texture", null, value ) );
		}

		override public function get face() : IDisplayObject
		{
			return _face ||= IoCHelper.resolve( IImageAdapter, this ) as IImageAdapter;
		}

		override protected function isPropertyAffectingAtBounds( prop : String ) : Boolean
		{
			return prop == "texture" || super.isPropertyAffectingAtBounds( prop );
		}
	}
}