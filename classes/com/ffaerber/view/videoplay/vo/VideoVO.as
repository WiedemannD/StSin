package com.ffaerber.view.videoplay.vo
{
	
	public class VideoVO 
	{
		
		
		private var _autostart:Boolean = false;
		private var _tumbnail:Boolean = false;

		private var _videourl:String;	
		 
		
		
		
		public function VideoVO(videourl:String):void
		{
			_videourl = videourl;
		}
		
		
		
		
		
		
		public function set autostart(autostart:Boolean):void
		{
			_autostart = autostart;
		}
		
	
		
		
		
		
		
		public function get autostart():Boolean
		{
			return _autostart;
		}
		
		public function get videourl():String
		{
			return _videourl;
		}
		
		
		
		
		
	}
}