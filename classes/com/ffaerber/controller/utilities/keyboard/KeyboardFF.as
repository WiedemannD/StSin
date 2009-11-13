package com.ffaerber.controller.utilities.keyboard
{
    import flash.display.Stage;
    import flash.events.*;
    
    
    public class KeyboardFF extends Stage 
    {
    	
        private var bgColor:uint = 0x00CCFF;
        private var size:uint = 80;
        
        
        
        public function KeyboardFF() 
        {
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
          //  addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
        }
        
        
        
        private function keyDownHandler(event:KeyboardEvent):void {
            trace("keyDownHandler: " + event.keyCode);
            trace("ctrlKey: " + event.ctrlKey);
            trace("keyLocation: " + event.keyLocation);
            trace("shiftKey: " + event.shiftKey);
            trace("altKey: " + event.altKey);
           
           	dispatchEvent(  new KeyboardFFEvent( KeyboardFFEvent.KEY_DOWN, event)   );
        }
        
        
        
        private function keyUpHandler(event:KeyboardEvent):void {
            trace("keyUpHandler: " + event.keyCode);
        }
        
        
        
    }
}
