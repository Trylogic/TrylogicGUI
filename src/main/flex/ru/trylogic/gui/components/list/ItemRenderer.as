package ru.trylogic.gui.components.list
{

	import ru.trylogic.gui.containers.ContainerBase;
	import ru.trylogic.gui.dataProviders.IListDataProvider;

	public class ItemRenderer extends ContainerBase
	{
		private var myIndex : uint;

		public function get index() : uint
		{
			return myIndex;
		}

		public function ItemRenderer()
		{
		}

		internal function initInternal( index : uint, dataProvider : IListDataProvider ) : void
		{
			this.myIndex = index;
			init( index, dataProvider );
		}

		protected function init( index : uint, dataProvider : IListDataProvider ) : void
		{
		}

		public function set selected( value : Boolean ) : void
		{

		}
	}
}
