package com.ffaerber.view.mediaplayer.vo
{
	
	public class MediaplayerVO 
	{
		
		
		private var _autostart:Boolean = false;
		private var _autonextvideo:Boolean = false;
		private var _timeline:Boolean = false;
		private var _volumen:Boolean = false;
		private var _playlist:Array;
		
		
		
		public function MediaplayerVO(playlist:Array, autostart:Boolean, autonextvideo:Boolean, timeline:Boolean, volumen:Boolean):void
		{
			_autostart = autostart;
			_autonextvideo = autonextvideo;
			_timeline = timeline;
			_volumen = volumen;
			_playlist = playlist;
		}
		
		
		
		
		
		
		
		public function get autostart():Boolean
		{
			return _autostart;
		}

		public function get autonextvideo():Boolean
		{
			return _autonextvideo;
		}		
		
		public function get timeline():Boolean
		{
			return _timeline;
		}

		public function get volumen():Boolean
		{
			return _volumen;
		}
		
		public function get playlist():Array
		{
			return _playlist;
		}
		
		
		
		
		
	}
}