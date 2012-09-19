package ru.trylogic.gui.adapters.starling
{

	import ru.trylogic.gui.adapters.ITextFieldAdapter;

	import starling.text.TextField;

	public class StarlingTextFieldAdapter extends TextField implements ITextFieldAdapter
	{
		public function StarlingTextFieldAdapter()
		{
			super( 100, 20, "" );
			autoScale = true;
		}

		public function set component_text( value : String ) : void
		{
			text = value;
		}

		public function get component_text() : String
		{
			return text;
		}

		public function set component_fontName( value : String ) : void
		{
			fontName = value;
		}

		public function get component_fontName() : String
		{
			return fontName;
		}

		public function set component_fontSize( value : Object ) : void
		{
			fontSize = value as Number;
		}

		public function get component_fontSize() : Object
		{
			return fontSize;
		}

		public function set component_multiline( value : Boolean ) : void
		{
			// It's already multiline and it's can not be disabled:(
		}

		public function get component_multiline() : Boolean
		{
			return true;
		}

		public function set component_autoSize( value : Boolean ) : void
		{
			autoScale = value;
		}

		public function get component_autoSize() : Boolean
		{
			return autoScale;
		}

		public function set component_wordWrap( value : Boolean ) : void
		{
		}

		public function get component_wordWrap() : Boolean
		{
			return false;
		}

		public function set component_fontColor( value : uint ) : void
		{
			super.color = value;
		}

		public function get component_fontColor() : uint
		{
			return super.color;
		}
	}
}
