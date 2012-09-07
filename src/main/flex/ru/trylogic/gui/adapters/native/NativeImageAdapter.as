package ru.trylogic.gui.adapters.native
{

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import ru.trylogic.gui.adapters.IImageAdapter;
	import ru.trylogic.gui.adapters.TextureFrame;

	public class NativeImageAdapter extends Bitmap implements IImageAdapter
	{
		private static const DEFAULT_TEXTURE : BitmapData = new BitmapData( 1, 1, true, 0 );

		public function NativeImageAdapter()
		{
			pixelSnapping = PixelSnapping.NEVER;
		}

		public function set component_texture( value : * ) : void
		{
			if ( value == null )
			{
				bitmapData = DEFAULT_TEXTURE;
			}
			else if ( value is Bitmap )
			{
				bitmapData = ( value as Bitmap ).bitmapData;
			}
			else if ( value is BitmapData )
			{
				bitmapData = ( value as BitmapData );
			}
			else if ( value is TextureFrame )
			{
				var frame : TextureFrame = value as TextureFrame;
				bitmapData = new BitmapData( frame.width, frame.height, true, 0 );
				bitmapData.copyPixels( frame.atlasBD, new Rectangle( frame.x, frame.y, frame.width, frame.height ), new Point( 0, 0 ) );
			}
			else
			{
				throw new ArgumentError( "NativeImageAdapter component_texture type '" + Object( value ).constructor + "' is not supported!" );
			}
		}

		public function get component_texture() : *
		{
			return bitmapData;
		}
	}
}
