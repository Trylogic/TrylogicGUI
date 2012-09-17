package ru.trylogic.gui.components.list
{

	import flash.events.Event;

	import mx.core.IFactory;
	import mx.events.PropertyChangeEvent;

	import ru.trylogic.gui.containers.ContainerBase;
	import ru.trylogic.gui.layouts.ILayout;
	import ru.trylogic.gui.dataProviders.IListDataProvider;

	import ru.trylogic.gui.components.SkinnableTrylogicComponent;

	import tl.view.IView;
	import tl.viewController.outlet;

	use namespace outlet;

	[Event(name="itemSelected", type="ru.trylogic.gui.components.list.ListEvent")]
	public class List extends SkinnableTrylogicComponent
	{
		private static const itemSelectedEvent : ListEvent = new ListEvent( ListEvent.ITEM_SELECTED );
		private const pool : Array = [];

		[Bindable]
		public var layout : ILayout;

		[Bindable]
		public var itemRenderer : IFactory;

		[Bindable]
		public var maxPages : uint = 1;

		protected var _itemsPerPage : uint = 10;
		protected var _currentPage : uint = 0;
		protected var _dataProvider : IListDataProvider;
		protected var _itemsContainer : ContainerBase;

		public var selectable : Boolean = false;

		[SkinPart(required="true")]
		public function set itemsContainer( value : ContainerBase ) : void
		{
			if ( value == _itemsContainer )
			{
				return;
			}

			if ( _itemsContainer )
			{
				_itemsContainer.removeEventListener( boundsChangedEvent.type, invalidateBounds );
			}

			_itemsContainer = value;

			if ( _itemsContainer )
			{
				_itemsContainer.addEventListener( boundsChangedEvent.type, invalidateBounds, false, 0, true );
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
		public function set currentPage( value : int ) : void
		{
			_currentPage = Math.min( Math.max( 0, value ), _dataProvider ? _dataProvider.length / _itemsPerPage : 0 );
			onDataChanged();
		}

		public function get currentPage() : int
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
			maxPages = _dataProvider ? (uint( _dataProvider.length / _itemsPerPage ) + 1) : 1;

			if ( _itemsContainer == null )
			{
				return;
			}

			var subViews : Vector.<IView> = _itemsContainer.subViews;

			var itemRendererInstance : ItemRenderer;
			while ( itemRendererInstance = (subViews.shift() as ItemRenderer) )
			{
				itemRendererInstance.cleanInternal();
				pool.unshift( itemRendererInstance );
			}

			if ( _dataProvider != null )
			{
				const totalItems : Number = Math.min( _currentPage * _itemsPerPage + _itemsPerPage, _dataProvider.length );
				for ( var i : uint = _currentPage * _itemsPerPage; i < totalItems; i++ )
				{
					itemRendererInstance = (pool.length > 0 ? pool.pop() : itemRenderer.newInstance());
					itemRendererInstance.initInternal( i, dataProvider, viewControllerInternal::onItemSelected );
					subViews.push( itemRendererInstance );
				}
			}

			var oldWidth : Number = width;
			var oldHeight : Number = height;

			_itemsContainer.subViews = subViews;

			if ( oldWidth != width )
			{
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "width", oldWidth, width ) );
			}

			if ( oldHeight != height )
			{
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "height", oldHeight, height ) );
			}
		}

		viewControllerInternal function onItemSelected( itemRendererInstance : ItemRenderer ) : void
		{
			itemSelectedEvent.index = itemRendererInstance.index;
			dispatchEvent( itemSelectedEvent );
		}
	}
}
