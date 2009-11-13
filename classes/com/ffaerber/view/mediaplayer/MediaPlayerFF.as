package com.ffaerber.view.mediaplayer
{
	
	
	
	import com.ffaerber.view.mediaplayer.vo.MediaItemVO;
	import com.ffaerber.view.mediaplayer.vo.MediaplayerVO;
	
	import flash.display.Sprite;
	
	import org.osmf.audio.AudioElement;
	import org.osmf.audio.SoundLoader;
	import org.osmf.composition.SerialElement;
	import org.osmf.display.MediaPlayerSprite;
	import org.osmf.events.MediaPlayerStateChangeEvent;
	import org.osmf.image.ImageElement;
	import org.osmf.image.ImageLoader;
	import org.osmf.media.URLResource;
	import org.osmf.net.NetLoader;
	import org.osmf.proxies.TemporalProxyElement;
	import org.osmf.swf.SWFElement;
	import org.osmf.swf.SWFLoader;
	import org.osmf.utils.URL;
	import org.osmf.video.VideoElement;
	
	public class MediaPlayerFF extends Sprite
	{
		
		
		private var container:Sprite;
		private var serialElement:SerialElement;
		private var mediaPlayerSprite:MediaPlayerSprite;
		
		private var _mediaplayerVO:MediaplayerVO;
		private var _playlist:Array
		
		
		public function MediaPlayerFF(mediaplayerVO:MediaplayerVO)
		{
			
			_mediaplayerVO = mediaplayerVO
			_playlist = _mediaplayerVO.playlist	
				
			init()
			
		}
		
		
		
		
		
		
		private function init():void
		{
			
			container = new Sprite();
			serialElement = new SerialElement();
			mediaPlayerSprite = new MediaPlayerSprite();
			
			
			
			for (var i:int=0; i<_playlist.length; i++)
			{
				var mediaItemVO:MediaItemVO = _playlist[i]
					
				var myURL:URL = new URL(mediaItemVO.mediaurl);
					switch (mediaItemVO.mediatyp) 
					{
						case "video":
								var videoElement:VideoElement = new VideoElement(new NetLoader(), new URLResource(myURL) );
								serialElement.addChild(videoElement);
							break;	
						
						case "image":
								var temporalImageProxyElement:TemporalProxyElement = new TemporalProxyElement( 3, new ImageElement( new ImageLoader(), new URLResource(myURL)));
								serialElement.addChild(temporalImageProxyElement);
							break;
						
						case "swf":
								var temporalSWFProxyElement:TemporalProxyElement = new TemporalProxyElement( 3, new SWFElement( new SWFLoader(), new URLResource(myURL)))
								serialElement.addChild(temporalSWFProxyElement);
							break;
						
						case "mp3":
								var audioElement:AudioElement = new AudioElement( new SoundLoader(), new URLResource(myURL));
								serialElement.addChild(audioElement);
							break;						
					}
			}
			
			mediaPlayerSprite.mediaPlayer.autoPlay = _mediaplayerVO.autostart
			mediaPlayerSprite.element = serialElement
			mediaPlayerSprite.mediaPlayer.addEventListener(MediaPlayerStateChangeEvent.MEDIA_PLAYER_STATE_CHANGE, onStateChange);
			
			this.addChild(container)
			container.addChild(mediaPlayerSprite);
		}
		
		
		
		
		
		
		
		
		private function onStateChange(event:MediaPlayerStateChangeEvent):void
		{
			trace( "State Change: " + event.newState.name)
		}

		
		
		
		
		
		
		public function videoReset():void
		{
			mediaPlayerSprite.mediaPlayer.pause()
			mediaPlayerSprite.mediaPlayer.seek(0)
			this.removeChild(container)
		}
		
		
		
		
		
		
		
		
		
		
	}
}