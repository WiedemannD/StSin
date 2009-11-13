package com.ffaerber.model
{
	import flash.events.Event;

	public class XMLDataLoaderFFEvent extends Event
	{
		
		public static const XML_LOADED:String = "xml_loaded";
		public static const XML_LOADING:String = "xml_loading";
		
		public var _xml:XML;
		
		
		public function XMLDataLoaderFFEvent(type:String, xml:XML, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_xml = xml;
		}
		
		
	}
}

