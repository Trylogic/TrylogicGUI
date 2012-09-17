package ru.trylogic.gui.components.list
{

	import ru.trylogic.gui.containers.ContainerBase;
	import ru.trylogic.gui.dataProviders.IListDataProvider;

	public class ItemRenderer extends ContainerBase
	{
		use namespace viewInternal;

		[Bindable]
		public var hostComponent : ListButton;

		private var myIndex : int;

		public function get index() : uint
		{
			return myIndex;
		}

		public function ItemRenderer()
		{
		}

		protected function init( index : uint, dataProvider : IListDataProvider ) : void
		{
		}

		protected function clean() : void
		{
		}

		internal function initInternal( index : int, dataProvider : IListDataProvider ) : void
		{
			this.myIndex = index;
			init( index, dataProvider );
		}

		internal function cleanInternal() : void
		{
			myIndex = -1;
			clean();
		}
	}
}
