package ru.trylogic.gui.components.image
{

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.adapters.IImageAdapter;

	import ru.trylogic.gui.components.TrylogicComponent;

	import tl.ioc.IoCHelper;

	public class Image extends TrylogicComponent
	{
		protected var _face : IImageAdapter;

		public function get texture() : *
		{
			return _face == null ? null : _face.component_texture;
		}

		[Bindable]
		public function set texture( value : * ) : void
		{
			if ( value is Class )
			{
				texture = new value();
				return;
			}

			var oldWidth : Number = width;
			var oldHeight : Number = height;

			face.component_texture = value;

			if ( oldWidth != width )
			{
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", 0, width ) );
			}

			if ( oldHeight != height )
			{
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", 0, height ) );
			}
		}

		override public function get face() : *
		{
			_face ||= IoCHelper.resolve( IImageAdapter, this ) as IImageAdapter;
			return _face;
		}

		override protected function isPropertyAffectingAtBouns( propName : String ) : Boolean
		{
			return propName == "texture" || super.isPropertyAffectingAtBouns( propName );
		}
	}
}