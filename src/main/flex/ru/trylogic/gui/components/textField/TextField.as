package ru.trylogic.gui.components.textField
{

	import ru.trylogic.gui.adapters.ITextFieldAdapter;
	import ru.trylogic.gui.components.TrylogicComponent;

	import tl.ioc.IoCHelper;
	import tl.view.IDisplayObject;

	public class TextField extends TrylogicComponent
	{
		protected var _face : ITextFieldAdapter;

		public function get text() : String
		{
			return _face == null ? "" : ITextFieldAdapter( _face ).component_text;
		}

		[Bindable]
		public function set text( value : String ) : void
		{
			( face as ITextFieldAdapter ).component_text = value;
		}

		public function get fontName() : String
		{
			return ( face as ITextFieldAdapter ).component_fontName;
		}

		[Bindable]
		public function set fontName( value : String ) : void
		{
			( face as ITextFieldAdapter ).component_fontName = value;
		}

		public function get fontSize() : Object
		{
			return ( face as ITextFieldAdapter ).component_fontSize;
		}

		[Bindable]
		public function set fontSize( value : Object ) : void
		{
			( face as ITextFieldAdapter ).component_fontSize = value;
		}

		public function get multiline() : Boolean
		{
			return ( face as ITextFieldAdapter ).component_multiline;
		}

		[Bindable]
		public function set multiline( value : Boolean ) : void
		{
			( face as ITextFieldAdapter ).component_multiline = value;
		}

		public function get autoSize() : Boolean
		{
			return ( face as ITextFieldAdapter ).component_autoSize;
		}

		[Bindable]
		public function set autoSize( value : Boolean ) : void
		{
			( face as ITextFieldAdapter ).component_autoSize = value;
		}

		public function get wordWrap() : Boolean
		{
			return ( face as ITextFieldAdapter ).component_wordWrap;
		}

		[Bindable]
		public function set wordWrap( value : Boolean ) : void
		{
			( face as ITextFieldAdapter ).component_wordWrap = value;
		}

		public function TextField()
		{
			super();
		}

		override public function get face() : IDisplayObject
		{
			_face ||= IoCHelper.resolve( ITextFieldAdapter, this ) as ITextFieldAdapter;
			return _face;
		}
	}
}
