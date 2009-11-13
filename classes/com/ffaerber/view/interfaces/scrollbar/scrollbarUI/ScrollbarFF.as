package com.ffaerber.view.interfaces.scrollbar.scrollbarUI
{
	import com.ffaerber.controller.utilities.macMouseWheel.MacMouseWheel;
	import com.ffaerber.view.graphics.RectangleFF;
	import com.ffaerber.view.interfaces.scrollbar.scrollbase.Scrollbase;
	import com.ffaerber.view.interfaces.scrollbar.scrollbase.ScrollbaseEvent;
	
	import flash.display.Sprite;
	
	
	
	public class ScrollbarFF extends Sprite
	{
		
		private var _viewHeight:int;
		private var _viewWidth:int;
		private var _contentHeight:int;
		private var _contentWidth:int;
		
		private var sb:Scrollbase;
		
		private var contMask:Sprite;
		private var content:Sprite;
		private var scrollbar:Sprite;
		private var drager:Sprite;
		
		
		// ist dataMode true wird content versteckt und gescalte
		private var _dataMode:Boolean
		private var _debug:Boolean		
		
		public function ScrollbarFF(myContent:Sprite = null,debug:Boolean = false)
		{

			_debug = debug;
			
			if (myContent){
				content = new Sprite()
				content.addChild(myContent)
				_dataMode = false
			}else{
				content = new Sprite()
				content.graphics.beginFill(0xffff00)
				content.graphics.drawRect(0,0,100,100)
				content.graphics.endFill()
				content.alpha = 0.5
				_dataMode = true
			}		
					
					
			if (content) {
				initElements()
				addChilds()
			}
			
		}
		
		
		
		
		
		
		private function initElements():void
		{

		//	MacMouseWheel.addListener( this );
			
			contMask = new Sprite()
			var rec:RectangleFF = new RectangleFF(0,0,50,50,0,0xffffff,0x000000)
			contMask.addChild(rec)

				
			scrollbar = new Sprite()
			scrollbar.graphics.beginFill(0x000000)
			scrollbar.graphics.drawRect(0,0,10,40)
			scrollbar.graphics.endFill()


			
			drager = new Sprite()
			drager.graphics.beginFill(0x666666)
			drager.graphics.drawRect(0,0,10,10)
			drager.graphics.endFill()

			sb = new Scrollbase(content,contMask,drager,scrollbar,1,5)
			sb.addEventListener(ScrollbaseEvent.SCROLLBASE_UPDATED, newPosi)
			sb.verifyHeight();
		}
		
		
		
		
		private function newPosi(event:ScrollbaseEvent):void
		{
			dispatchEvent(new ScrollbarFFEvent(ScrollbarFFEvent.SCROLLBAR_UPDATED, event._scrollbaseVO))
		}
	
		
		
		
		
		private function addChilds():void
		{
			addChild(contMask)		
			addChild(content)
			addChild(scrollbar)
			addChild(drager)
		}

		

		
		
		
		public function updateScrollbar( viewWidth:int, viewHeight:int, contentWidth:int, contentHeight:int ):void
		{
			_viewWidth = viewWidth;			
			_viewHeight = viewHeight;
			_contentHeight = contentHeight;
			_contentWidth = contentWidth;
			
			updateElements()
		}
		
		

		

		public function updateElements():void
		{
			if (_dataMode)
			{
				content.height = _contentHeight;
				content.width = _contentWidth;
				if(_debug){
					content.visible = true
				}else{
					content.visible = false
				}
			}
			
			contMask.height = _viewHeight
			contMask.width = _contentWidth
			scrollbar.height = _viewHeight;
			
			sb.verifyHeight();
		}
		
		
		

		
		
		
		
		
		
		
	}
}