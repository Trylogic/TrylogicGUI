package ru.trylogic.gui.components.textField
{

	import mx.events.PropertyChangeEvent;

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
			var oldWidth : Number = width;
			var oldHeight : Number = height;

			( face as ITextFieldAdapter ).component_text = value;

			if ( oldWidth != width )
			{
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", oldWidth, width ) );
			}

			if ( oldHeight != height )
			{
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", oldHeight, height ) );
			}
		}

		public function get fontName() : String
		{
			return _face == null ? "" : ITextFieldAdapter( _face ).component_fontName;
		}

		[Bindable]
		public function set fontName( value : String ) : void
		{
			( face as ITextFieldAdapter ).component_fontName = value;
		}

		public function get fontSize() : Object
		{
			return _face == null ? null : ITextFieldAdapter( _face ).component_fontSize;
		}

		[Bindable]
		public function set fontSize( value : Object ) : void
		{
			( face as ITextFieldAdapter ).component_fontSize = value;
		}

		public function get multiline() : Boolean
		{
			return _face == null ? false : ITextFieldAdapter( _face ).component_multiline;
		}

		[Bindable]
		public function set multiline( value : Boolean ) : void
		{
			( face as ITextFieldAdapter ).component_multiline = value;
		}

		public function get autoSize() : Boolean
		{
			return _face == null ? false : ITextFieldAdapter( _face ).component_autoSize;
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
			return _face ||= IoCHelper.resolve( ITextFieldAdapter, this ) as ITextFieldAdapter;
		}

		override protected function isPropertyAffectingAtBouns( propName : String ) : Boolean
		{
			switch ( propName )
			{
				case "text":
				case "fontName":
				case "fontSize":
				case "multiline":
				case "autoSize":
				case "wordWrap":
				{
					return true;
				}
					break;
			}

			return super.isPropertyAffectingAtBouns( propName );
		}
	}
}
