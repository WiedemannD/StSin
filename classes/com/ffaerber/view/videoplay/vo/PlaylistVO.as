package com.ffaerber.view.videoplay.vo
{
	
	public class PlaylistVO 
	{
		
		
		private var _autostart:Boolean = false;
		private var _autonextvideo:Boolean = false;
		private var _timeline:Boolean = false;
		private var _volumen:Boolean = false;

		private var _playlist:Array;
		
		
		
		public function PlaylistVO(videos:Array):void
		{
			_playlist = playlist;
		}
		
		
		
		
		
		public function set autostart(autostart:Boolean):void
		{
			_autostart = autostart;
		}

		public function set autonextvideo(autonextvideo:Boolean):void
		{
			_autonextvideo = autonextvideo;
		}		
		
		public function set timeline(timeline:Boolean):void
		{
			_timeline = timeline;
		}
		
		public function set volumen(volumen:Boolean):void
		{
			_volumen = volumen;
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