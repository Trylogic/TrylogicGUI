package ru.trylogic.gui.components.stick
{

	import flash.display.Stage;

	import ru.trylogic.gui.components.button.Button;
	import ru.trylogic.gui.containers.ContainerBase;
	import ru.trylogic.unitouch.gestures.MoveGesture;
	import ru.trylogic.unitouch.gestures.abstractGesture.GestureEvent;

	import ru.trylogic.gui.components.SkinnableTrylogicComponent;

	import tl.ioc.IoCHelper;
	import tl.viewController.outlet;

	use namespace outlet;

	public class Stick extends SkinnableTrylogicComponent
	{

		[Bindable]
		public var skinStyle : StickSkinStyle = new StickSkinStyle();

		[Bindable]
		public var delegate : Function;

		[SkinPart(required="true")]
		public var stickButton : Button;

		[SkinPart(required="true")]
		public var controls : ContainerBase;

		[SkinPart(required="true")]
		public var moveGesture : MoveGesture;

		public static const STICK_SIZE : int = 100;

		[Inject]
		protected static const stage : Stage = IoCHelper.resolve( Stage, Stick );

		protected var oldX : Number = Number.MAX_VALUE;
		protected var oldY : Number = Number.MAX_VALUE;

		public function Stick()
		{
			skinClass = StickSkin;
		}

		override lifecycle function viewLoaded() : void
		{
			updatePosition( 0, 0 );
			moveGesture.addEventListener( GestureEvent.POSSIBLE, moveGesture_possible );
			moveGesture.addEventListener( GestureEvent.BEGAN, moveGesture_changed );
			moveGesture.addEventListener( GestureEvent.CHANGED, moveGesture_changed );
			moveGesture.addEventListener( GestureEvent.RECOGNIZED, moveGesture_failed );
			moveGesture.addEventListener( GestureEvent.CANCELED, moveGesture_failed );
			moveGesture.addEventListener( GestureEvent.FAILED, moveGesture_failed );
		}

		override lifecycle function viewBeforeRemovedFromStage() : void
		{
			updatePosition( 0, 0 );
		}

		public function updatePosition( newX : Number, newY : Number ) : void
		{
			if ( Math.sqrt( newX * newX + newY * newY ) > STICK_SIZE )
			{
				var corner : Number = Math.atan2( newX, newY );
				newX = Math.sin( corner ) * STICK_SIZE;
				newY = Math.cos( corner ) * STICK_SIZE;
			}

			if ( newX != oldX || newY != oldY )
			{
				stickButton.x = newX - stickButton.width * 0.5 + STICK_SIZE;
				stickButton.y = newY - stickButton.height * 0.5 + STICK_SIZE;

				oldX = newX;
				oldY = newY;

				if ( delegate != null )
				{
					delegate( this, newX / STICK_SIZE, -newY / STICK_SIZE );
				}
			}
		}

		protected function moveGesture_possible( event : GestureEvent ) : void
		{
			controls.x = (moveGesture.currentTouchContext.stageX - face.x) - controls.width / 2;
			controls.y = (moveGesture.currentTouchContext.stageY - face.y) - controls.height / 2;
			controls.visible = true;
			updatePosition( 0, 0 );
		}

		protected function moveGesture_changed( event : GestureEvent ) : void
		{
			updatePosition( (moveGesture.currentTouchContext.stageX - face.x) - controls.x - STICK_SIZE, (moveGesture.currentTouchContext.stageY - face.y) - controls.y - STICK_SIZE );
		}

		protected function moveGesture_failed( event : GestureEvent ) : void
		{
			controls.visible = false;
			updatePosition( 0, 0 );
		}
	}
}
