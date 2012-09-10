package ru.trylogic.gui.components.list
{

	import ru.trylogic.gui.containers.ContainerBase;
	import ru.trylogic.gui.dataProviders.IListDataProvider;
	import ru.trylogic.unitouch.UniTouch;
	import ru.trylogic.unitouch.processor.IRawTouchListener;

	public class ItemRenderer extends ContainerBase implements IRawTouchListener
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

		public function onRawTouchBegin( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
			trace( "item selected at index", myIndex );
		}

		public function onRawTouchMove( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
		}

		public function onRawTouchEnd( touchPointID : int, stageX : Number, stageY : Number ) : void
		{
		}

		override lifecycle function init() : void
		{
			super.lifecycle::init();
			UniTouch.getTouchProcessor( this.face ).addRawTouchListener( this );
		}

		override lifecycle function destroy() : void
		{
			super.lifecycle::destroy();
			UniTouch.getTouchProcessor( this.face ).removeRawTouchListener( this );
		}
	}
}
