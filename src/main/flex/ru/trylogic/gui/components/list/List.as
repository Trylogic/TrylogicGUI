package ru.trylogic.gui.components.list
{

	import flash.events.Event;

	import mx.core.IFactory;
	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.TUIComponentViewController;
	import ru.trylogic.gui.containers.ContainerBase;
	import ru.trylogic.gui.containers.layouts.ILayout;
	import ru.trylogic.gui.dataProviders.IListDataProvider;

	import tl.view.IView;
	import tl.viewController.outlet;

	use namespace outlet;

	[Event(name="itemSelected")]
	public class List extends TUIComponentViewController
	{
		private const pool : Array = [];

		[Bindable]
		public var layout : ILayout;

		[Bindable]
		public var itemRenderer : IFactory;

		protected var _itemsPerPage : uint = 10;
		protected var _currentPage : uint = 0;
		protected var _dataProvider : IListDataProvider;
		protected var _itemsContainer : ContainerBase;

		public function get itemsContainer() : ContainerBase
		{
			return _itemsContainer;
		}

		[SkinPart(required="true")]
		public function set itemsContainer( value : ContainerBase ) : void
		{
			if ( _itemsContainer )
			{
				_itemsContainer.removeEventListener( "boundsChanged", dispatchEvent );
			}

			_itemsContainer = value;

			if ( _itemsContainer )
			{
				_itemsContainer.addEventListener( "boundsChanged", dispatchEvent, false, 0, true );
			}
		}

		[Bindable]
		public function set itemsPerPage( value : uint ) : void
		{
			_itemsPerPage = value;
			onDataChanged();
		}

		public function get itemsPerPage() : uint
		{
			return _itemsPerPage;
		}

		[Bindable]
		public function set currentPage( value : uint ) : void
		{
			_currentPage = value;
			onDataChanged();
		}

		public function get currentPage() : uint
		{
			return _currentPage;
		}

		[Bindable]
		public function set dataProvider( value : IListDataProvider ) : void
		{
			if ( _dataProvider == value )
			{
				return;
			}

			if ( _dataProvider )
			{
				_dataProvider.removeEventListener( "changed", onDataChanged );
			}

			_dataProvider = value;

			if ( _dataProvider )
			{
				_dataProvider.addEventListener( "changed", onDataChanged, false, 0, true );
			}

			onDataChanged();
		}

		public function get dataProvider() : IListDataProvider
		{
			return _dataProvider;
		}

		public function List()
		{
			skinClass = ListSkin;
		}

		protected function onDataChanged( event : Event = null ) : void
		{
			if ( _itemsContainer == null )
			{
				return;
			}

			var subViews : Vector.<IView> = _itemsContainer.subViews;

			var subView : IView;
			while ( subView = subViews.shift() )
			{
				pool.unshift( subView );
			}

			if ( _dataProvider == null )
			{
				_itemsContainer.subViews = null;
				return;
			}

			for ( var i : uint = _currentPage * _itemsPerPage; i < Math.min( _currentPage * _itemsPerPage + _itemsPerPage, _dataProvider.length ); i++ )
			{
				var itemRenderer : ItemRenderer = pool.length > 0 ? pool.pop() : itemRenderer.newInstance();
				itemRenderer.initInternal( i, dataProvider );
				subViews.push( itemRenderer );
			}

			_itemsContainer.subViews = subViews;

			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", null, width ) );
			dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", null, height ) );
		}
	}
}
