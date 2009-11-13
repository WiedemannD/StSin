package com.ffaerber.view.interfaces.scrollbar.scrollbase
{
	
	
	public class ScrollbaseVO 
	{
		
		
		private var _scrollbarActiv:Boolean;
		private var _contentY:int;
		
		
		
		public function ScrollbaseVO(contentY:int, scrollbarActiv:Boolean):void
		{
			_scrollbarActiv = scrollbarActiv;
			_contentY = contentY;
		}
		
		
		
		public function get scrollbarActiv():Boolean
		{
			return _scrollbarActiv;
		}
		
		
		public function get contentY():int
		{
			return _contentY;
		}
		
		
		
		
	}
}