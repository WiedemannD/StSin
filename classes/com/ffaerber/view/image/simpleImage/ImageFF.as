package com.ffaerber.view.image.simpleImage
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	public class ImageFF extends Sprite
	{
		
		
		
		private var fadeInImage:Bitmap;
		private var image:Bitmap;
		
		
		
		
		
		public function ImageFF()
		{
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		
		
		
		
		private function init(e:Event = null):void 
		{
			fadeInImage = new Bitmap();
			image = new Bitmap();
			add()
		}
		
		
		
		private function add():void
		{
			addChild(image)
			addChild(fadeInImage)
		}	
		
		
		
		
		
		public function set newBitmap(newImage:Bitmap):void
		{
			fadeInImage = newImage;
			updateImage();
		}
		


		
		
		
		private function updateImage():void
		{
			fadeInImage
		}	
			
		
		
		
		
		
	}

}