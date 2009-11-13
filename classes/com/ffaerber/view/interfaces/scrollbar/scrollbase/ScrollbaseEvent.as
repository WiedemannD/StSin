package com.ffaerber.view.interfaces.scrollbar.scrollbase
{
	
	import flash.events.Event;
	
	public class ScrollbaseEvent extends Event
	{
		
		
		public static const SCROLLBASE_UPDATED:String = "scrollbase_updated";
		public var _scrollbaseVO:ScrollbaseVO;
		
		public function ScrollbaseEvent(type:String, scrollbaseVO:ScrollbaseVO, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_scrollbaseVO = scrollbaseVO;
		}
		
	}
}