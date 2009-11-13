package com.ffaerber.model
{
	import flash.events.*;
	import flash.net.*;
	
	
	
	public class XMLDataLoaderFF extends EventDispatcher
	{
		
		
		
		
		private var _url:String;
		private var _xmlData:XML;
		private var request:URLRequest;
		private var loader:URLLoader;
		private var _debug:Boolean;
		
		
		
		public function XMLDataLoaderFF( url:String, debug:Boolean = false )
		{
			
			_url = url;
			_debug = debug;
			setupLoader()
			configureListeners()
		}
		
		
		
		
		
		private function setupLoader():void
		{
			loader = new URLLoader();
            request = new URLRequest(_url);
            
            try {
                loader.load(request);
                if (_debug){ trace("load requested document.");}
            } catch (error:Error) {
                if (_debug){ trace("Unable to load requested document.");}
            }

			
		}
		
		
		
		private function configureListeners():void
		{
			loader.addEventListener(Event.COMPLETE, completeHandler);
            loader.addEventListener(Event.OPEN, openHandler);
            loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
            loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
            loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}
		
		
		
		
		
		
        private function openHandler(event:Event):void {
        	if (_debug){
           		trace("openHandler: " + event);
        	}
        }

        private function progressHandler(event:ProgressEvent):void {
        	if (_debug){
           		trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
         	}
        }

        private function securityErrorHandler(event:SecurityErrorEvent):void {
           if (_debug){
        		trace("securityErrorHandler: " + event);
        	}
        }

        private function httpStatusHandler(event:HTTPStatusEvent):void {
			if (_debug){
          		trace("httpStatusHandler: " + event);
			}
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
        	if (_debug){
        		trace("ioErrorHandler: " + event);
        	}
        }
		








		private function completeHandler(event:Event):void 
		{	
			if (_debug){  trace("XML completeHandler"); }
			_xmlData = new XML( event.target.data );
			_xmlData.ignoreWhitespace = true;
			
			dispatchEvent(  new XMLDataLoaderFFEvent( XMLDataLoaderFFEvent.XML_LOADED, _xmlData)   );
			
		}
		
		
		
		
		public function get xmlData():XML{
			return _xmlData
		}
		
		
		
		
		
		
		
	}
	
	
	
	
	
	
	
}
















		
		

		
		
		
		
		





