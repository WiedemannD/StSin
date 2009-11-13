package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	public class SimpleImage extends Sprite
	{
		private var _loader:Loader = new Loader();
		private var image:Bitmap;
		private var loaded:Boolean = false;
		private var _url:String;
		private var _data:String;
		
		public function SimpleImage(path:String, url:String = "")
		{
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			_loader.load(new URLRequest(path));
			
			_url = url
			if(url != "")
			{
				this.buttonMode = true;
			}
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function onComplete(event:Event):void 
		{         
			image = Bitmap(_loader.content);
			var bitmap:BitmapData = image.bitmapData; 
			addChild(image);
			loaded = true;
		}
		
		private function onClick(event:MouseEvent):void 
		{         
			if(_url != "")
			{
				navigateToURL(new URLRequest(_url), "_blank");
			}
		}
		
		public function set data(data:String):void
		{
			_data = data;
		}
		
		public function get data():String
		{
			return _data;
		}
		
		
	}
}