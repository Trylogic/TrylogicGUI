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

		protected var _skinStyle : TextFieldSkinStyle;

		public function set skinStyle( value : TextFieldSkinStyle ) : void
		{
			if ( value == _skinStyle )
			{
				return;
			}

			if ( _skinStyle )
			{
				_skinStyle.removeEventListener( PropertyChangeEvent.PROPERTY_CHANGE, onSkinStyleChanged );
			}

			_skinStyle = value;

			if ( _skinStyle )
			{
				fontName = value.fontName;
				fontColor = value.fontColor;
				fontSize = value.fontSize;
				filters = value.filters;
				_skinStyle.addEventListener( PropertyChangeEvent.PROPERTY_CHANGE, onSkinStyleChanged, false, 0, true );
			}
		}

		public function get filters() : Array
		{
			return _face ? (face as ITextFieldAdapter).component_filters : null;
		}

		[Bindable]
		public function set filters( value : Array ) : void
		{
			(face as ITextFieldAdapter).component_filters = value;
		}

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
			return _face == null ? "" : ITextFieldAdapter( _face ).component_fontName;
		}

		[Bindable]
		public function set fontName( value : String ) : void
		{
			( face as ITextFieldAdapter ).component_fontName = value;
		}

		public function get fontColor() : uint
		{
			return _face == null ? 0 : ITextFieldAdapter( _face ).component_fontColor;
		}

		[Bindable]
		public function set fontColor( value : uint ) : void
		{
			( face as ITextFieldAdapter ).component_fontColor = value;
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

		protected function onSkinStyleChanged( event : PropertyChangeEvent ) : void
		{
			this[event.property] = event.newValue;
		}

		override protected function isPropertyAffectingAtBounds( propName : String ) : Boolean
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

			return super.isPropertyAffectingAtBounds( propName );
		}
	}
}
