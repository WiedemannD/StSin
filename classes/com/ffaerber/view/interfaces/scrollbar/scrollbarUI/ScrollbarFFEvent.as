package com.ffaerber.view.interfaces.scrollbar.scrollbarUI
{
	
	import com.ffaerber.view.interfaces.scrollbar.scrollbase.ScrollbaseVO;
	
	import flash.events.Event;
	
	public class ScrollbarFFEvent extends Event
	{
		
		
		public static const SCROLLBAR_UPDATED:String = "scrollbar_updated";
		public var _scrollbaseVO:ScrollbaseVO;
		
		public function ScrollbarFFEvent(type:String, scrollbaseVO:ScrollbaseVO, bubbles:Boolean=true, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_scrollbaseVO = scrollbaseVO;
		}
		
	}
}