package ru.trylogic.gui.components.textField
{

	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.*;
	import ru.trylogic.gui.adapters.ITextFieldAdapter;

	import tl.ioc.IoCHelper;
	import tl.viewController.ViewController;

	public class TextField extends TUIComponent
	{

		[Bindable(event="propertyChange")]
		override public function get face() : *
		{
			if ( _face == null )
			{
				_face = IoCHelper.resolve(ITextFieldAdapter, this);
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "face", null, _face ) );
			}

			return _face;
		}

		public function get text() : String
		{
			return _face == null ? "" : ITextFieldAdapter(_face).component_text;
		}

		[Bindable]
		public function set text( value : String ) : void
		{
			ITextFieldAdapter(face).component_text = value;
		}

		public function get fontName() : String
		{
			return ITextFieldAdapter( face ).component_fontName;
		}

		[Bindable]
		public function set fontName( value : String ) : void
		{
			ITextFieldAdapter(face ).component_fontName = value;
		}

		public function get fontSize() : Object
		{
			return ITextFieldAdapter( face ).component_fontSize;
		}

		[Bindable]
		public function set fontSize( value : Object ) : void
		{
			ITextFieldAdapter( face ).component_fontSize = value;
		}

		public function get multiline() : Boolean
		{
			return ITextFieldAdapter( face ).component_multiline;
		}

		[Bindable]
		public function set multiline( value : Boolean ) : void
		{
			ITextFieldAdapter( face ).component_multiline = value;
		}

		public function get autoSize() : Boolean
		{
			return ITextFieldAdapter( face ).component_autoSize;
		}

		[Bindable]
		public function set autoSize( value : Boolean ) : void
		{
			ITextFieldAdapter( face ).component_autoSize = value;
		}

		public function get wordWrap() : Boolean
		{
			return ITextFieldAdapter( face ).component_wordWrap;
		}

		[Bindable]
		public function set wordWrap( value : Boolean ) : void
		{
			ITextFieldAdapter( face ).component_wordWrap = value;
		}

		public function TextField()
		{
			super();
			controllerClass = ViewController;
		}
	}
}
