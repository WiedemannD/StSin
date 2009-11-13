package com.ffaerber.controller.utilities.keyboard
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;

	public class KeyboardFFEvent extends Event
	{
		
		public static const KEY_DOWN:String = "key_down";
		
		private var _event:KeyboardEvent;
		
		public function KeyboardFFEvent(type:String, event:KeyboardEvent, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_event = event
		}
		
		
	}
}

