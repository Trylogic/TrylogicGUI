package ru.trylogic.gui.components.image
{

	import ru.trylogic.gui.adapters.IImageAdapter;

	import tl.ioc.IoCHelper;
	import tl.view.AbstractView;
	import tl.viewController.IVIewController;

	public class ImageSkin extends AbstractView
	{
		public var hostComponent : Image;

		public function get adapter() : IImageAdapter
		{
			return face;
		}

		override public function get controller() : IVIewController
		{
			return hostComponent;
		}

		public function ImageSkin()
		{
		}

		override protected function lazyCreateFace() : *
		{
			return IoCHelper.resolve( IImageAdapter, this );
		}
	}
}
