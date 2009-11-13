package com.ffaerber.view.interfaces.scrollbar.scrollbase
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	
	
	public class Scrollbase extends Sprite
	{
		
		
		
		
		
		private var _content			:Sprite 			= new Sprite;
		private var _contMask			:Sprite			 	= new Sprite;
		private var _dragger			:Sprite 			= new Sprite;
		private var _scrollbar			:Sprite 			= new Sprite;
		private var scrollPercent		:Number				= new Number(0);
		
		private var _speed				:uint;
		private var _padding			:uint;
		
		
		
		
		
		
		public function Scrollbase(content:Sprite, contMask:Sprite, dragger:Sprite, scrollbar:Sprite, speed:uint = 1, padding:uint = 0):void
		{
			_content 			= content;
			_contMask			= contMask;
			_dragger 			= dragger;
			_scrollbar 			= scrollbar;
			_padding			= padding;
			_speed				= speed;			
			_content.mask 		= _contMask;			
			_content.y 			= _contMask.y;
			_dragger.y 			= _scrollbar.y;
			

			
			_dragger.addEventListener(MouseEvent.MOUSE_DOWN, moveDrag);

			_content.addEventListener(MouseEvent.MOUSE_UP, releaseDrag);
			_dragger.addEventListener(MouseEvent.MOUSE_UP, releaseDrag);
			_dragger.addEventListener(MouseEvent.ROLL_OUT, releaseDrag);
			//stage.addEventListener(MouseEvent.MOUSE_UP, releaseDrag);
			
			_dragger.addEventListener(MouseEvent.MOUSE_WHEEL, moveContentWheel);
		//	_content.addEventListener(MouseEvent.MOUSE_WHEEL, moveContentWheel);
			
			_scrollbar.addEventListener(MouseEvent.CLICK, moveDragPercent);			
			
			
			
			
			verifyHeight();
		}
		
		
		
		
		
		
		
		
		
		/* 
		When the mouse_down into the dragger clip function
		Execute function to drag scroll slider 
		*/
		
		private function moveDrag(m:MouseEvent):void
		{
			var newRect:Rectangle = new Rectangle(_scrollbar.x,_scrollbar.y,0,_scrollbar.height - _dragger.height);
			_dragger.startDrag(false,newRect);
			
			/* Moving the content together when move the dragger */		
			_dragger.addEventListener(MouseEvent.MOUSE_MOVE, dragdrager);
		}
		
		
		
		
		
		private function dragdrager(e:MouseEvent):void
		{
			_dragger.addEventListener(Event.ENTER_FRAME, moveContent);
		}
		
		
		
		
		
		
		
		
		/*
		Execute release Drag to stop all enter frame function
		and stop the content scroll
		*/
		
		private function releaseDrag(m:MouseEvent):void
		{
			_dragger.stopDrag();
			_dragger.removeEventListener(Event.ENTER_FRAME, moveContent);
			moveContent(null);
		}
		
		
		
		
		
		
		
		
		/*
		CLICK IN THE SCROLL AND GOTO
		When click on the scroll will
		jump to position with out slide
		the dragger movieclip
		*/
		
		private function moveDragPercent(m:MouseEvent):void
		{
			_dragger.y = mouseY;			
			_dragger.addEventListener(Event.ENTER_FRAME, moveContent);
		}
		
		
		
		
		
		
		
		
		
		
		/*
		Execute this function using EnterFrame when moveDrag is working
		*/
		
		private function moveContent(e:Event):void
		{
			/* Verify if dragger is inside the background */
				
			if ( _dragger.y > ( (_scrollbar.y + _scrollbar.height) - _dragger.height )) _dragger.y = (_scrollbar.y + _scrollbar.height) - _dragger.height;
			if ( _dragger.y < _scrollbar.y ) _dragger.y = _scrollbar.y;
			
			/* Scroll Move */
			
			scrollPercent = ( 100 / ( _scrollbar.height - _dragger.height ) ) * ( _dragger.y - _scrollbar.y );
			
			var acty:Number = Number(_content.y);
			var endy:Number = Number(_contMask.y + ( ( _contMask.height - _content.height - _padding ) / 100 ) * scrollPercent);
			
			_content.y += (endy - acty) / _speed;
			
			verifyHeight();
		}
		
		
		
		
		
		
		
		
		/*
		Using Mouse Wheel
		*/
		
		private function moveContentWheel(m:MouseEvent):void
		{
			if ( mouseX > _contMask.x && mouseX < _contMask.x + _contMask.width && mouseY > _contMask.y && mouseY < _contMask.y + _contMask.height )
			{
				_dragger.y -= ( m.delta * 5 );
				moveContent(null);
			}
		}
		
		
		
		
		
		
		
		/*
		Verify if need or not the content
		If content is smaller than mask 
		will not show the scroller
		*/
		
		public function verifyHeight():void
		{
			if ( _contMask.height > _content.height )
			{
				_dragger.visible = false;
				_scrollbar.visible = false;
				_dragger.y = 0;
				_content.y = 0;
			}
			else
			{
				_dragger.visible = true;
				_scrollbar.visible = true;
				
				/* Change the dragger size */
				_dragger.height = ((_contMask.height / _content.height) * _scrollbar.height);
			}
			
			var scrollbaseVO:ScrollbaseVO = new ScrollbaseVO(_content.y, _scrollbar.visible)
			dispatchEvent(new ScrollbaseEvent(ScrollbaseEvent.SCROLLBASE_UPDATED, scrollbaseVO))
			
		}
		
		
		
		
		
		
		
		
		
		
		
		
		

	}
}