package ru.trylogic.gui.components.list
{

	import flash.events.Event;

	import mx.core.ClassFactory;

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

		[Bindable]
		public var layout : ILayout;

		[Bindable]
		public var itemRenderer : IFactory;

		[Bindable]
		public var selectable : Boolean = false;

		protected var _maxPages : uint = 1;
		protected var _itemsPerPage : uint = 10;
		protected var _currentPage : uint = 0;
		protected var _dataProvider : IListDataProvider;
		protected var _itemsContainer : ContainerBase;
		protected var _selectedItem : ListButton = null;

		use namespace viewControllerInternal;

		[SkinPart(required="true")]
		public function set itemsContainer( value : ContainerBase ) : void
		{
			if ( value == _itemsContainer )
			{
				return;
			}

			_itemsContainer = value;

			onDataChanged();
		}

		[Bindable(event="propertyChange")]
		public function get maxPages() : uint
		{
			return _maxPages;
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
			_dataProvider && _dataProvider.removeEventListener( "changed", onDataChanged );

			_dataProvider = value;

			_dataProvider && _dataProvider.addEventListener( "changed", onDataChanged, false, 0, true );

			onDataChanged();
		}

		public function get dataProvider() : IListDataProvider
		{
			return _dataProvider;
		}

		[Bindable]
		public function set selectedIndex( value : int ) : void
		{
			if ( _selectedItem )
			{
				_selectedItem.selected = false;
				_selectedItem = null;
			}

			if ( value != -1 && _itemsContainer != null )
			{
				_selectedItem = _itemsContainer.subViews[value - _currentPage * _itemsPerPage] as ListButton;
				_selectedItem.selected = true;
			}
		}

		public function get selectedIndex() : int
		{
			return _selectedItem ? _selectedItem.index : -1;
		}

		public function List()
		{
			skinClass = ListSkin;
		}

		viewControllerInternal function onDataChanged( event : Event = null ) : void
		{
			var oldMaxPages : uint = _maxPages;
			_maxPages = _dataProvider ? (uint( _dataProvider.length / _itemsPerPage ) + 1) : 1;

			if ( _maxPages != oldMaxPages )
			{
				dispatchEvent( PropertyChangeEvent.createUpdateEvent( this, "maxPages", oldMaxPages, _maxPages ) );
			}

			selectedIndex = -1;

			if ( _itemsContainer == null )
			{
				return;
			}

			var subViews : Vector.<IView> = _itemsContainer.subViews;
			var newViews : Vector.<IView> = new Vector.<IView>();

			if ( _dataProvider != null )
			{
				const totalItems : Number = Math.min( _currentPage * _itemsPerPage + _itemsPerPage, _dataProvider.length );
				for ( var i : uint = _currentPage * _itemsPerPage; i < totalItems; i++ )
				{
					var itemRendererInstance : ListButton = subViews.shift() as ListButton;
					if ( itemRendererInstance == null )
					{
						itemRendererInstance = new ListButton();
						itemRendererInstance.addEventListener( "tap", onItemSelected, false, 0, true );
					}

					itemRendererInstance.skinClass = itemRenderer && ( itemRenderer as ClassFactory ).generator ? ( itemRenderer as ClassFactory ).generator : ListButtonSkin;
					itemRendererInstance.update( dataProvider, i );
					newViews.push( itemRendererInstance );
				}
			}

			while ( itemRendererInstance = (subViews.pop() as ListButton) )
			{
				itemRendererInstance.removeEventListener( "tap", onItemSelected );
			}

			_itemsContainer.subViews = newViews;
		}

		viewControllerInternal function onItemSelected( event : Event ) : void
		{
			itemSelectedEvent.index = (event.target as ListButton).index;
			if ( selectable )
			{
				selectedIndex = itemSelectedEvent.index;
			}
			dispatchEvent( itemSelectedEvent );
		}
	}
}
