package ru.trylogic.gui.components.list
{

	import ru.trylogic.gui.containers.ContainerBase;
	import ru.trylogic.gui.dataProviders.IListDataProvider;
	import ru.trylogic.unitouch.gestures.TapGesture;
	import ru.trylogic.unitouch.gestures.abstract.GestureEvent;

	public class ItemRenderer extends ContainerBase
	{
		use namespace viewInternal;

		protected var itemSelectedCallback : Function;
		private var myIndex : int;

		viewInternal var _tapGesture : TapGesture;

		public function set selected( value : Boolean ) : void
		{

		}

		public function get index() : uint
		{
			return myIndex;
		}

		public function ItemRenderer()
		{
		}

		protected function configureTapGesture( tapGesture : TapGesture ) : void
		{
			tapGesture.target = face;
			tapGesture.tapDelay = uint.MAX_VALUE;
		}

		protected function init( index : uint, dataProvider : IListDataProvider ) : void
		{
		}

		protected function clean() : void
		{

		}

		internal function initInternal( index : int, dataProvider : IListDataProvider, itemSelectedCallback : Function = null ) : void
		{
			if ( !_tapGesture )
			{
				_tapGesture = new TapGesture();
				_tapGesture.addEventListener( GestureEvent.RECOGNIZED, tapGesture_onRecognized, false, 0, true );
				_tapGesture.addEventListener( GestureEvent.POSSIBLE, tapGesture_onPossible, false, 0, true );
				configureTapGesture( _tapGesture );
			}
			this.myIndex = index;
			this.itemSelectedCallback = itemSelectedCallback;
			init( index, dataProvider );
		}

		internal function cleanInternal() : void
		{
			if ( _tapGesture )
			{
				_tapGesture.removeEventListener( GestureEvent.RECOGNIZED, tapGesture_onRecognized );
				_tapGesture.removeEventListener( GestureEvent.POSSIBLE, tapGesture_onPossible );
				_tapGesture.dispose();
				_tapGesture = null;
			}
			myIndex = -1;
			clean();
		}

		viewInternal function tapGesture_onRecognized( event : GestureEvent ) : void
		{
			itemSelectedCallback && itemSelectedCallback( this );
			selected = false;
		}

		viewInternal function tapGesture_onPossible( event : GestureEvent ) : void
		{
			selected = true;
		}
	}
}
