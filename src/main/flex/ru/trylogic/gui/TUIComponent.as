package ru.trylogic.gui
{

	import mx.core.IStateClient2;
	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.components.button.ButtonSkin;
	import ru.trylogic.gui.skins.Skin;

	import tl.ioc.IoCHelper;

	import tl.view.AbstractView;

	public class TUIComponent extends AbstractView
	{

		public function get x() : Number
		{
			return face.x;
		}

		[Bindable]
		public function set x( value : Number ) : void
		{
			face.x = value;
		}

		public function get y() : Number
		{
			return face.y;
		}

		[Bindable]
		public function set y( value : Number ) : void
		{
			face.y = value;
		}

		public function get width() : Number
		{
			return face.width;
		}

		[Bindable]
		public function set width( value : Number ) : void
		{
			face.width = value;
		}

		public function get height() : Number
		{
			return face.height;
		}

		[Bindable]
		public function set height( value : Number ) : void
		{
			face.height = value;
		}

		public function get scaleX() : Number
		{
			return face.scaleX;
		}

		[Bindable]
		public function set scaleX( value : Number ) : void
		{
			face.scaleX = value;
		}

		public function get scaleY() : Number
		{
			return face.scaleY;
		}

		[Bindable]
		public function set scaleY( value : Number ) : void
		{
			face.scaleY = value;
		}

		public function get rotation() : Number
		{
			return face.rotation;
		}

		[Bindable]
		public function set rotation( value : Number ) : void
		{
			face.rotation = value;
		}

		public function get alpha() : Number
		{
			return face.alpha;
		}

		[Bindable]
		public function set alpha( value : Number ) : void
		{
			face.alpha = value;
		}

		public function get visible() : Boolean
		{
			return face.visible;
		}

		[Bindable]
		public function set visible( value : Boolean ) : void
		{
			face.visible = value;
		}

		public function get name() : String
		{
			return face.name;
		}

		[Bindable]
		public function set name( value : String ) : void
		{
			face.name = value;
		}

		public function TUIComponent()
		{
		}
	}
}