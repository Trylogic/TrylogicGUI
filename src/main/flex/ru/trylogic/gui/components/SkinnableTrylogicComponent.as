/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 04.08.12
 * Time: 13:25
 */
package ru.trylogic.gui.components
{

	import tl.view.AbstractView;
	import tl.view.IView;

	public class SkinnableTrylogicComponent extends TrylogicComponent
	{
		protected var _skinClass : Class;

		use namespace viewControllerInternal;

		override protected function get view() : IView
		{
			if ( _viewInstance == null )
			{
				var viewInstance : IView = new _skinClass();
				viewInstance.addEventListener( boundsChangedEvent.type, invalidate, false, 0, true );
				viewInstance['hostComponent'] = this;
				initWithView( viewInstance );
			}
			return _viewInstance;
		}

		public function get skinClass() : Class
		{
			return _skinClass;
		}

		public function set skinClass( value : Class ) : void
		{
			if ( _skinClass == value )
			{
				return;
			}

			_skinClass = value;
		}

		protected function get skinParts() : Object
		{
			return null;
		}

		public function SkinnableTrylogicComponent()
		{
		}

		override viewControllerInternal function installView() : void
		{
			super.installView();

			if ( _viewInstance )
			{
				for ( var skinPart : String in skinParts )
				{
					if ( skinParts[skinPart] == false && !Object( _viewInstance ).hasOwnProperty( skinPart ) )
					{
						continue;
					}

					this[skinPart] = _viewInstance[skinPart];
				}
			}
		}

		override viewControllerInternal function uninstallView() : void
		{
			super.uninstallView();

			for ( var skinPart : String in skinParts )
			{
				this[skinPart] = null;
			}
		}
	}
}
