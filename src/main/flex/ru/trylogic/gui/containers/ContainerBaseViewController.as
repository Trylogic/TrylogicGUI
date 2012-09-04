/**
 * Created by IntelliJ IDEA.
 * User: bsideup
 * Date: 04.08.12
 * Time: 13:31
 */
package ru.trylogic.gui.containers
{

	import flash.display.Stage;
	import flash.events.Event;

	import tl.ioc.IoCHelper;
	import tl.viewController.ViewController;

	public class ContainerBaseViewController extends ViewController
	{

		[Inject]
		protected static const stage : Stage = IoCHelper.resolve( Stage, ContainerBaseViewController );

		public function ContainerBaseViewController()
		{
		}

		override lifecycle function viewBeforeAddedToStage() : void
		{
			stage.addEventListener( Event.RENDER, onRender );
		}

		override lifecycle function viewBeforeRemovedFromStage() : void
		{
			stage.removeEventListener( Event.RENDER, onRender );
		}

		protected function onRender( event : Event ) : void
		{
			( view as ContainerBase).validate();
		}
	}
}
