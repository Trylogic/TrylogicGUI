package ru.trylogic.gui.adapters.native
{

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import ru.trylogic.gui.adapters.ITextFieldAdapter;

	public class NativeTextFieldAdapter extends TextField implements ITextFieldAdapter
	{
		protected var _textFormat : TextFormat;

		public function NativeTextFieldAdapter()
		{
			autoSize = TextFieldAutoSize.LEFT;
			selectable = false;
		}

		public function set component_text( value : String ) : void
		{
			text = value || "";
			if(_textFormat)
			{
				setTextFormat(_textFormat);
			}
		}

		public function get component_text() : String
		{
			return text;
		}

		public function set component_fontName( value : String ) : void
		{
			if ( !_textFormat )
			{
				_textFormat = new TextFormat( value );
			}
			else if ( _textFormat.font != value )
			{
				_textFormat.font = value;
			}
			setTextFormat( _textFormat );
		}

		public function get component_fontName() : String
		{
			return _textFormat ? _textFormat.font : "";
		}

		public function set component_fontSize( value : Object ) : void
		{
			if ( !_textFormat )
			{
				_textFormat = new TextFormat( null, value );
			}
			else if ( _textFormat.size != value )
			{
				_textFormat.size = value;
			}
			setTextFormat( _textFormat );
		}

		public function get component_fontSize() : Object
		{
			return _textFormat ? _textFormat.size : 0;
		}

		public function set component_multiline( value : Boolean ) : void
		{
			multiline = value;
		}

		public function get component_multiline() : Boolean
		{
			return multiline;
		}

		public function set component_autoSize( value : Boolean ) : void
		{
			autoSize = value ? TextFieldAutoSize.LEFT : TextFieldAutoSize.NONE;
		}

		public function get component_autoSize() : Boolean
		{
			return autoSize != TextFieldAutoSize.NONE;
		}

		public function set component_wordWrap( value : Boolean ) : void
		{
			wordWrap = value;
		}

		public function get component_wordWrap() : Boolean
		{
			return wordWrap;
		}
	}
}
