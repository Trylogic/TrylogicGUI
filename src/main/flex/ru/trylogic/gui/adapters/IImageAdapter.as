package ru.trylogic.gui.adapters
{


	public interface IImageAdapter
	{
		function set component_texture( value : * ) : void;

		function get component_texture() : *;
	}
}

import ru.trylogic.gui.adapters.IImageAdapter;
import ru.trylogic.gui.adapters.native.NativeImageAdapter;
import ru.trylogic.gui.adapters.starling.StarlingImageAdapter;

import tl.adapters.nativeDisplayList.NativeViewContainerAdapter;
import tl.adapters.starling.StarlingViewContainerAdapter;
import tl.ioc.IoCHelper;
import tl.adapters.IViewContainerAdapter;

class StaticConstruct
{
	{
		switch ( IoCHelper.resolve( IViewContainerAdapter ).constructor )
		{
			case NativeViewContainerAdapter:
			{
				IoCHelper.registerType( IImageAdapter, NativeImageAdapter );

			}
				break;

			case StarlingViewContainerAdapter:
			{
				IoCHelper.registerType( IImageAdapter, StarlingImageAdapter );
			}
				break;
		}
	}
}