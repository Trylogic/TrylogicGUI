package ru.trylogic.gui.adapters
{

	public interface ITextFieldAdapter
	{
		function set component_text( value : String ) : void;

		function get component_text() : String;

		function set component_fontName( value : String ) : void;

		function get component_fontName() : String;

		function set component_fontSize( value : Object ) : void;

		function get component_fontSize() : Object;

		function set component_multiline( value : Boolean ) : void;

		function get component_multiline() : Boolean;

		function set component_autoSize( value : Boolean ) : void;

		function get component_autoSize() : Boolean;

		function set component_wordWrap( value : Boolean ) : void;

		function get component_wordWrap() : Boolean;
	}
}

import ru.trylogic.gui.adapters.ITextFieldAdapter;
import ru.trylogic.gui.adapters.native.NativeTextFieldAdapter;
import ru.trylogic.gui.adapters.starling.StarlingTextFieldAdapter;

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
				IoCHelper.registerType( ITextFieldAdapter, NativeTextFieldAdapter );
			}
				break;

			case StarlingViewContainerAdapter:
			{
				IoCHelper.registerType( ITextFieldAdapter, StarlingTextFieldAdapter );
			}
				break;
		}
	}
}