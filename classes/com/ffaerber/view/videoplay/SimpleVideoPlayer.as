package  com.ffaerber.view.videoplay
{
	
	import flash.display.Sprite;
	import flash.events.*;
	import flash.geom.*;
	import flash.media.Video;
	import flash.net.*;
	
	public class SimpleVideoPlayer extends Sprite {
		
		private var _videoURL:String;
		private var _video:Video;
		private var _vidDuration:Number;
		private var _vidXmax:Number;
		private var _vidYmax:Number;
		private var _vidWidth:Number;
		private var _vidHeight:Number;

		
		private var _main_nc:NetConnection = new NetConnection();
		private var _serverLoc:String;
		private var _ns:NetStream;
		
		private var _smooth:Boolean; 
		private var _buffertime:Number;
		private var bufferFull:Boolean;
		private var _stop:Sprite;	






		/* ------------Contructors/Initialization-----------*/
		public function SimpleVideoPlayer(serverLoc:String, flvLocation:String, smooth:Boolean, buffertime:Number ):void
		{
			_buffertime = buffertime
			_smooth = smooth
			_videoURL = flvLocation;
			
			//add eventListeners to NetConnection and connect
			_main_nc.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			_main_nc.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			_main_nc.connect(serverLoc);
		}
		
		
		
		
		

		
		
		
		
		
		private function onNetStatus(event:Object):void 
		{
			switch (event.info.code) {
				
				case "NetConnection.Connect.Success":
					connectStream();
				break;
					
				case "NetStream.Play.StreamNotFound":
					trace("Stream not found: " + _videoURL);
				break;
					
				case "NetStream.Play.Stop":
					//do if video is stopped
				break;
					
				case "NetStream.Buffer.Full":
					//do if video is stopped
					startVideo()
				break;
					
				case "NetStream.Buffer.Empty":
					trace("video is empty")
				break;
					
			}
			trace(event.info.code);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		/* -------------------Connection------------------- */
		private function connectStream():void {
			
			//netstream object
			_ns = new NetStream(_main_nc);
			_ns.bufferTime = _buffertime;
			_ns.addEventListener(AsyncErrorEvent.ASYNC_ERROR, asyncErrorHandler);
			_ns.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			
			//other event handlers assigned 
			//to the netstream client property
			var custom_obj:Object = new Object();
			custom_obj.onMetaData = onMetaDataHandler;
			custom_obj.onCuePoint = onCuePointHandler;
		//	custom_obj.onPlayStatus = playStatus;
			_ns.client = custom_obj;
			
			
			//attach netstream to the video object
			_video = new Video()
			_video.attachNetStream(_ns);
			_video.height = _vidHeight;
			_video.width = _vidWidth;
			_video.smoothing = _smooth
			_video.alpha = 0;
			addChild(_video);
			setVideoInit();
			
		}
		
		
		
		
		
		
		
		



		private function videoPlayComplete():void {
			setVideoInit();
		}


		private function setVideoInit():void {
			bufferFull = false
			_ns.play(_videoURL);
		}
		
		
		
		private function startVideo():void 
		{
			if (bufferFull == false)
			{
				bufferFull = true
				_video.alpha = 1;
				_ns.pause();
				_ns.seek(_vidDuration);
				_ns.play(_videoURL);
			}
		}
		

		
		
		
		

		
		
		
		
		
		private function onMetaDataHandler(metaInfoObj:Object):void {
			_video.width = metaInfoObj.width;
			_video.height = metaInfoObj.height;
			_vidWidth = metaInfoObj.width;
			_vidHeight = metaInfoObj.height;
			//trace("metadata: duration=" + metaInfoObj.duration + "width=" + metaInfoObj.width + " height=" + metaInfoObj.height + " framerate=" + metaInfoObj.framerate);
		}
		
		private function onCuePointHandler(cueInfoObj:Object):void {
		//	trace("cuepoint: time=" + cueInfoObj.time + " name=" + ueInfoObj.name + " type=" + cueInfoObj.type);
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		private function fullscreenOnClicked(e:MouseEvent):void {
			stage.fullScreenSourceRect = new Rectangle(0,0,320,240);
			//stage.displayState = StageDisplayState.FULL_SCREEN;
		}

		private function fullscreenOffClicked(e:MouseEvent):void {
			// go to back to normal mode
			//stage.displayState = StageDisplayState.NORMAL;
			stage.displayState = stage.displayState = "NORMAL";
		}
		
		private function onFullscreen(e:FullScreenEvent):void {
			// check if we're entering or leaving fullscreen mode
		    if (e.fullScreen) {
				// switch fullscreen buttons
		    } else {
				// reset video display
		    }
		}
		
		
		
		
		
		
		
		
		
		
		
		/* -----------------------Error handlers------------------------ */
		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
		private function asyncErrorHandler(event:AsyncErrorEvent):void {
			trace(event.text);
		}
		
		
		
		
		
		
		
		
		
	}
}
