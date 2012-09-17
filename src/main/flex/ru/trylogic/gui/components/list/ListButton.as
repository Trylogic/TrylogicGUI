package ru.trylogic.gui.components.list
{

	import ru.trylogic.gui.components.button.Button;
	import ru.trylogic.gui.dataProviders.IListDataProvider;

	[SkinState("selected")]
	public class ListButton extends Button
	{

		protected var dataProvider : IListDataProvider;
		protected var _index : int = 0;

		use namespace viewControllerInternal;

		public function get index() : int
		{
			return _index;
		}

		public function  get selected() : Boolean
		{
			return view.currentState == "selected";
		}

		public function set selected( value : Boolean ) : void
		{
			if ( selected == value )
			{
				return;
			}

			if ( value )
			{
				view.currentState = "selected";
			}
			else if ( selected )
			{
				view.currentState = "up";
			}
		}

		override public function get disabled() : Boolean
		{
			return selected || super.disabled;
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