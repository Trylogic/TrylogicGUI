package ru.trylogic.gui.skins
{

	import mx.core.UIComponent;
	import mx.events.PropertyChangeEvent;

	import tl.ioc.IoCHelper;

	import tl.view.IView;
	import tl.adapters.IViewContainerAdapter;

	import tl.viewController.IVIewController;

	[DefaultProperty("view")]
	public class Skin extends UIComponent implements IView
	{
		private var _view : IView;

		protected var _face : *;

		public function Skin()
		{
		}

		public function get controller() : IVIewController
		{
			return this['hostComponent'];
		}

		[Bindable(event="propertyChange")]
		public function get face() : *
		{
			if ( _face == null )
			{
				_face = IoCHelper.resolve( IViewContainerAdapter, this );
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "face", null, _face ) );
			}

			return _face;
		}

		public function destroy() : void
		{
			_view.destroy();
			_view = null;
		}

		public function get view() : IView
		{
			return _view;
		}

		public function set view( value : IView ) : void
		{
			if ( _view )
			{
				_view.removeEventListener( "boundsChanged", dispatchEvent );
				_view.controller.removeViewFromContainer( face );
			}

			_view = value;

			if ( _view )
			{
				_view.controller.addViewToContainer( face );
				_view.addEventListener( "boundsChanged", dispatchEvent, false, 0, true );
			}
		}
	}
}
