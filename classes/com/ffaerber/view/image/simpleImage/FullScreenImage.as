package com.ffaerber.view.image.simpleImage
{
	
	
	
	import com.ffaerber.view.graphics.RectangleFF;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	
	
	/**
	 * ...
	 * @author Josh Chernoff | josh@gfxcomplex.com
	 * @version .01
	 * @usage FullScreenImage will take any displayObject and scale it in a number of ways to fit the whole screen
	 * @example var image:FullScreenImage = new FullScreenImage(bitmapSmoothing = false); // Note crossdomain.xml file maybe needed for bitmapSmoothing
	 * @link http://gfxcomlpex.com/labs/full-screen-image
	 */

	
	
	
	
	
	public class FullScreenImage extends Sprite
	{
		
		
		private var _bitmapSmoothing:Boolean
		private var _contentHolder:Sprite;		
		private var initStage:Boolean = false;
		private var initLoad:Boolean = false;		
		private var _align:String;
		
		private var sH:int;
		private var sW:int;
		
		private var _scale:Boolean;
		
		private var _debug:Boolean;
		private var _debug_box:RectangleFF;
		// mask for debug or mask
		private var _mask:RectangleFF;
		private var _masking:Boolean;
		
		private var _viewWidth:int;
		private var _viewHeight:int;		

		
		
		
		public function FullScreenImage(
							url:String, 
							align:String = "TL", 
							bitmapSmoothing:Boolean = false,
							viewWidth:int = 9999,
							viewHeight:int = 9999,
							masking:Boolean = false,
							debug:Boolean = false
							)
		{
		
			
			var loader:Loader = new Loader();
			var loaderContext:LoaderContext = new LoaderContext(bitmapSmoothing);
			
			_align = align;			
			_bitmapSmoothing = bitmapSmoothing;

			_viewWidth = viewWidth
			_viewHeight = viewHeight
			
			
			if (_viewWidth == 0 || _viewHeight == 0)
			{
				_scale = true;
			}
			else if(_viewWidth == 9999 || _viewHeight == 9999)
			{
				_scale = false;
				trace("----------sssssssss")
			}
			else
			{
				_scale = false;
				sW = _viewWidth;
				sH = _viewHeight;			
			}
			

			
			_debug = debug;
			_masking = masking
			configureListeners(loader.contentLoaderInfo);
	
			loader.load(new URLRequest(url), loaderContext);			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);	
		}
		
		
		
		
		
		
		
		
		
		//STAGE EVENTS				
		private function onAddedToStage(e:Event):void 
		{
			initStage = true;
			
			if(_scale)
			{
				stage.addEventListener(Event.RESIZE, onResize);
			}


			onResize(null);
			if (initLoad && initStage)
			{
				onResize(null);
			}
			
		}
		
		
		
		
		
		
		
		
		
		
		private function onResize(e:Event):void 
		{
			
			if (_debug) trace("scale: "+_scale+" | sW"+sW)
			
			if (  _contentHolder is Sprite) 
			{

				
				var image:DisplayObject;

				if(_scale)
				{
					sH = stage.stageHeight;
					sW = stage.stageWidth;
				}
				
				
				if(_masking && _mask){
					_mask.width = sW;
					_mask.height = sH;
				}
				
				
				if(_debug && _debug_box)
				{
					_debug_box.width = sW;
					_debug_box.height = sH;
				}

					
				switch(_align) {
					
					case "TL":						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;
					
					case "T":
						image = _contentHolder.getChildAt(0);
						image.x = -(image.width >> 1);
						_contentHolder.x = sW >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;
					
					case "TR":
						image = _contentHolder.getChildAt(0);
						image.x = -(image.width);
						_contentHolder.x = sW;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;	
			
					case "CL":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height >> 1);
						_contentHolder.y = sH >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;	
					
					case "C":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height >> 1);
						image.x = -(image.width >> 1);
						
						_contentHolder.y = sH >> 1;
						_contentHolder.x = sW >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;
					
					case "CR":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height >> 1);
						image.x = -(image.width);
						
						_contentHolder.y = sH >> 1;
						_contentHolder.x = sW;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;
					
					case "BL":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height);
						
						_contentHolder.y = sH;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;
					
					case "B":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height);
						image.x = -(image.width >> 1);
						
						_contentHolder.y = sH;
						_contentHolder.x = sW >> 1;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;	
					
					case "BR":
						image = _contentHolder.getChildAt(0);
						image.y = -(image.height);
						image.x = -(image.width);
						
						_contentHolder.y = sH;
						_contentHolder.x = sW;
						
						_contentHolder.width = sW;
						_contentHolder.scaleY = _contentHolder.scaleX;
						
						if (_contentHolder.height < sH) {
							_contentHolder.height = sH;
							_contentHolder.scaleX = _contentHolder.scaleY;
						}						
					break;						
					}
				
			}
		}
		
		
		


		
		
		
		
		//LOADER EVENTS
		private function configureListeners(dispatcher:IEventDispatcher):void {
            dispatcher.addEventListener(Event.COMPLETE, onLoadComplete);
            dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            dispatcher.addEventListener(Event.INIT, initHandler);
            dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            dispatcher.addEventListener(Event.OPEN, openHandler);
            dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
        }
		
		
		
		
		
		
		
		
		private function onLoadComplete(e:Event):void 
		{
			initLoad = true;
			
			_contentHolder = new Sprite();
			addChild(_contentHolder)
			

			


			if(_bitmapSmoothing){
				this.dispatchEvent(e);
				var bitmap:Bitmap = e.target.loader.content as Bitmap;
				bitmap.smoothing = _bitmapSmoothing;				
				_contentHolder.addChild(bitmap);
			}
			else 
			{
				_contentHolder.addChild(e.target.loader as Loader);
			}
			
			
			if(_viewWidth == 9999 || _viewHeight == 9999)
			{
				var b:Bitmap = e.target.loader.content as Bitmap;
				sW = b.width;
				sH = b.height;	
			}
			
			
			if (initLoad && initStage){
				onResize(null);
			}
	
			
			
			if(_debug){
				_debug_box = new RectangleFF(0,0,sW,sH,0,0xffffff,0x00ffff);
				addChild(_debug_box);
				_debug_box.alpha = 0.2;
			} 
			
			if(_masking){
				_mask = new RectangleFF(0,0,sW,sH,0,0xffffff,0x000000);
				addChild(_mask);
				_contentHolder.mask = _mask
			} 


			
			onResize(null);
			
		}
		
		
	
		
		
		
		
		
		
		private function progressHandler(event:ProgressEvent):void 
		{
			dispatchEvent(event);
		}
        private function httpStatusHandler(event:HTTPStatusEvent):void 
		{
            dispatchEvent(event);
        }
        private function initHandler(event:Event):void 
		{
			dispatchEvent(event);
        }
        private function ioErrorHandler(event:IOErrorEvent):void 
		{
            dispatchEvent(event);
        }
        private function openHandler(event:Event):void 
		{
            dispatchEvent(event);
        }
		
		
		
		
		
		
		
		public function get imageWidth():int
		{
			return sW
		}
		
		
		public function get imageHeight():int
		{
			return sH
		}
		
		
		
		
		
		
		
	}	
}