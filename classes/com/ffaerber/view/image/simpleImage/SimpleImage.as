package com.ffaerber.view.image.simpleImage
{
	import caurina.transitions.Tweener;
	
	import com.ffaerber.view.graphics.RectangleFF;
	
	import flash.display.*;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Felix Faerber
	 * @version .01
	 * @usage SimpleImage will take any displayObject and scale it in a number of ways to  the screen
	 * @example var image:FullScreenImage = new FullScreenImage(bitmapSmoothing = false); // Note crossdomain.xml file maybe needed for bitmapSmoothing
	 * @link http://gfxcomlpex.com/labs/full-screen-image
	 */
	
	
	
	public class SimpleImage extends Sprite
	{

		
		
		// make debug aktiv or not
		private var _debug:Boolean = false
			
		private var image:FullScreenImage;
		
		private var _viewWidth:int;
		private var _viewHeight:int;
		
		private var imageComplete:Boolean = false
		
		
		
		public function SimpleImage(
									viewWidth:int = 200,
									viewHeight:int = 300,
									debug:Boolean = false)
		{
			_debug = debug;
			_viewWidth = viewWidth;
			_viewHeight = viewHeight;
			
			if(stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		

		
		

		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);

			if (_debug){
				var viewbg:RectangleFF = new RectangleFF(0, 0, _viewWidth, _viewHeight, 0, 0, 0xff0000, 0.2)
				addChild(viewbg)	
			}			
			
			
		}
		
		

		
		
		
		
		
		private function complete (event:Event) : void
		{	
			imageComplete = true
			Tweener.addTween(image, {alpha:1, time:.2, transition:"easeoutquad"});
		}
		
	
		public function set debug ( debug:Boolean ) : void
		{
			_debug = debug;
		}	
		
		
		
		
		
		
		
		
		public function updateImage (imageURL:String) : void
		{
			image = new FullScreenImage(imageURL, FullScreenAlign.CENTER, true, _viewWidth, _viewHeight);
			image.addEventListener(Event.COMPLETE ,complete)
			image.alpha = 0;
			addChild(image)
		}	
		
		
		
		public function updateSize (viewWidth:int, viewHeight:int) : void
		{
			_viewWidth = viewWidth;
			_viewHeight = viewHeight;
			if(imageComplete){
		//		image.updateSize(_viewWidth, _viewHeight)
			}
		}	
		
		
		
		
		
		
		
		
		
	}
}