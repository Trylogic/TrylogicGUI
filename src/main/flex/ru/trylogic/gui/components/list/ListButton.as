package ru.trylogic.gui.components.list
{

	import ru.trylogic.gui.components.button.Button;
	import ru.trylogic.gui.dataProviders.IListDataProvider;

	public class ListButton extends Button
	{

		[Bindable]
		public var selected : Boolean = false;

		protected var dataProvider : IListDataProvider;
		protected var _index : int = 0;

		use namespace viewControllerInternal;

		public function get index() : int
		{
			return _index;
		}

		public function ListButton()
		{
			super();
			skinClass = ListButtonSkin;
		}

		override lifecycle function viewLoaded() : void
		{
			super.lifecycle::viewLoaded();
			ItemRenderer( view ).initInternal( _index, dataProvider );
		}

		public function update( dataProvider : IListDataProvider, i : int ) : void
		{
			this.dataProvider = dataProvider;
			this._index = i;
			if ( _viewInstance )
			{
				ItemRenderer( view ).initInternal( _index, dataProvider );
			}
		}
	}
}