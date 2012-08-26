package ru.trylogic.gui.adapters.starling
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

	import ru.trylogic.gui.adapters.IImageAdapter;
	import ru.trylogic.gui.adapters.TextureFrame;

	import starling.display.Image;
	import starling.textures.Texture;

	public class StarlingImageAdapter extends Image implements IImageAdapter
	{
		private static const DEFAULT_TEXTURE : Texture = Texture.fromBitmapData( new BitmapData( 1, 1, true, 0 ) );
		private static const TEXTURES : Dictionary = new Dictionary(true);

		public function StarlingImageAdapter()
		{
			super( DEFAULT_TEXTURE );
		}

		public function set component_texture( value : * ) : void
		{
			if ( value == null )
			{
				texture = DEFAULT_TEXTURE;
			}
			else if ( value is Bitmap )
			{
				texture = Texture.fromBitmap( value );
			}
			else if ( value is BitmapData )
			{
				texture = Texture.fromBitmapData( value );
			}
			else if ( value is Texture )
			{
				texture = value;
			}
			else if (value is TextureFrame )
			{
				var frame : TextureFrame = value as TextureFrame;
				var atlasTexture : Texture = TEXTURES[frame.atlasBD];
				if(atlasTexture == null)
				{
					atlasTexture = Texture.fromBitmapData(frame.atlasBD);
					TEXTURES[frame.atlasBD] = atlasTexture;
				}
				texture = Texture.fromTexture(atlasTexture, new Rectangle(frame.x,  frame.y,  frame.width, frame.height));
			}
			else
			{
				throw new ArgumentError( "StarlingImageAdapter component_texture type '" + Object( value ).constructor + "' is not supported!" );
			}

			readjustSize();
		}

		public function get component_texture() : *
		{
			return texture;
		}
	}
}
