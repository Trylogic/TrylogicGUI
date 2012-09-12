package ru.trylogic.gui.layouts
{

	import tl.view.IDisplayObject;
	import tl.view.IView;

	public class TileLayout extends BasicLayout
	{
		protected var _colls : uint = 3;
		protected var _vspace : Number = 2;
		protected var _hspace : Number = 2;


		public function get colls() : uint
		{
			return _colls;
		}

		[Bindable]
		public function set colls( value : uint ) : void
		{
			_colls = value;
			invalidateLayout();
		}

		public function get vspace() : Number
		{
			return _vspace;
		}

		[Bindable]
		public function set vspace( value : Number ) : void
		{
			_vspace = value;
			invalidateLayout();
		}

		public function get hspace() : Number
		{
			return _hspace;
		}

		[Bindable]
		public function set hspace( value : Number ) : void
		{
			_hspace = value;
			invalidateLayout();
		}

		public function TileLayout()
		{
		}

		override public function invalidateLayout() : void
		{
			if ( !view )
			{
				return;
			}

			const subViews : Vector.<IView> = view.subViews;

			var newX : Number = 0;
			var newY : Number = 0;

			var maxHeight : Number = 1;
			for ( var i : uint = 0; i < subViews.length; i++ )
			{
				const face : IDisplayObject = subViews[i].face;
				maxHeight = Math.max( face.height, maxHeight );

				face.x = newX;
				face.y = newY;
				newX += (face.width + _hspace);

				if ( (i + 1) % _colls == 0 )
				{
					newX = 0;
					newY += (maxHeight + _vspace);
					maxHeight = 1;
				}
			}

		}

	}
}
