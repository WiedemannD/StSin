package com.ffaerber.view.mediaplayer.vo
{
	
	public class MediaItemVO 
	{
		
		



		private var _mediatyp:String;
		private var _mediaurl:String;	
		private var _title:String; 
		private var _description:String;
		private var _tumbnailurl:String;
		private var _autostart:Boolean = false;
		
		
		
		
		
		public function MediaItemVO(mediatyp:String, mediaurl:String, tumbnailurl:String, title:String, description:String, autostart:Boolean):void
		{
			_mediatyp = mediatyp;
			_mediaurl = mediaurl;
			_tumbnailurl = tumbnailurl;
			_title = title;
			_description = description;
			_autostart = autostart;
		}
		
		
		

	
		
		
		
		public function get mediatyp():String
		{
			return _mediatyp;
		}
		
		public function get mediaurl():String
		{
			return _mediaurl;
		}
		
		public function get tumbnailurl():String
		{
			return _tumbnailurl;
		}
		
		public function get title():String
		{
			return _title;
		}
		
		public function get description():String
		{
			return _description;
		}
		
		public function get autostart():Boolean
		{
			return _autostart;
		}	
		
		
		
		
		
		
		
		
		
		
	}
}