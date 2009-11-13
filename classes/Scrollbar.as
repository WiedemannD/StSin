
/**
	 * Flashscaper Scrollbar Component
	 * Customizable Scrollbar
	 *
	 * @author		Li Jiansheng
	 * @version		1.0.0
	 * @private
	 * @website     http://www.flashscaper
	 */

package {
		
	import caurina.transitions.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;

	public class Scrollbar extends MovieClip {

		private var target:MovieClip;
		private var top:Number;
		private var bottom:Number;
		private var dragBot:Number;
		private var range:Number;
		private var ratio:Number;
		private var sPos:Number;
		private var sRect:Rectangle;
		private var ctrl:Number;//This is to adapt to the target's position
		private var trans:String;
		private var timing:Number;
		private var isUp:Boolean;
		private var isDown:Boolean;
		private var isArrow:Boolean;
		private var arrowMove:Number;
		private var upArrowHt:Number;
		private var downArrowHt:Number;
		private var sBuffer:Number;
		
		// Daniel's Code
		private var track:Sprite;
		private var upArrow:Sprite;
		private var downArrow:Sprite;
		private var scroller:Sprite;				
		//
		
		public function Scrollbar():void {
			
			// Daniel's Code
			track = new Sprite();
			track.graphics.beginFill(0x666666,0.5);
			track.graphics.drawRect(0, 0, 10, 100);
			track.graphics.endFill();
			track.x = 0;
			track.y = 0;
			addChild(track);
			
			upArrow = new Sprite();
			upArrow.graphics.beginFill(0x666666,1);
			upArrow.graphics.drawRect(0, 0, 10, 10);
			upArrow.graphics.endFill();
			upArrow.x = 0;
			upArrow.y = 0;
			addChild(upArrow);		
			
			downArrow = new Sprite();
			downArrow.graphics.beginFill(0x666666,1);
			downArrow.graphics.drawRect(0, 0, 10, 10);
			downArrow.graphics.endFill();
			downArrow.x = 0;
			downArrow.y = 100;
			addChild(downArrow);
			
			scroller = new Sprite();
			scroller.graphics.beginFill(0x666666,1);
			scroller.graphics.drawRect(0, 0, 10, 10);
			scroller.graphics.endFill();
			scroller.x = 0;
			scroller.y = 10;
			addChild(scroller);
			//
			
			
			scroller.addEventListener(MouseEvent.MOUSE_DOWN, dragScroll);
			//stage.addEventListener(MouseEvent.MOUSE_UP, stopScroll);			
			//stage.addEventListener(MouseEvent.MOUSE_WHEEL,mouseWheelHandler);
		}
		//
		public function init(t:MovieClip, tr:String,tt:Number,sa:Boolean,b:Number):void {
			target = t;
			trans = tr;
			timing = tt;
			isArrow = sa;
			sBuffer = b;
			if (target.height <= track.height) {
				this.visible = false;
			}			

			//
			upArrowHt = upArrow.height;
			downArrowHt = downArrow.height;
			if (isArrow) {
				top = scroller.y;
				dragBot = (scroller.y + track.height) - scroller.height;
				bottom = track.height - (scroller.height/sBuffer);

			} else {
				top = scroller.y;
				dragBot = (scroller.y + track.height) - scroller.height;
				bottom = track.height - (scroller.height/sBuffer);

				upArrowHt = 0;
				downArrowHt = 0;
				removeChild(upArrow);
				removeChild(downArrow);
			}
			range = bottom - top;
			sRect = new Rectangle(0,top,0,dragBot);
			ctrl = target.y;
			//set Mask
			isUp = false;
			isDown = false;
			arrowMove = 10;
			
			if (isArrow) {
				upArrow.addEventListener(Event.ENTER_FRAME, upArrowHandler);
				upArrow.addEventListener(MouseEvent.MOUSE_DOWN, upScroll);
				upArrow.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
				//
				downArrow.addEventListener(Event.ENTER_FRAME, downArrowHandler);
				downArrow.addEventListener(MouseEvent.MOUSE_DOWN, downScroll);
				downArrow.addEventListener(MouseEvent.MOUSE_UP, stopScroll);
			}
			var square:Sprite = new Sprite();
			square.graphics.beginFill(0xFF0000);
			square.graphics.drawRect(target.x, target.y, target.width+5, (track.height+upArrowHt+downArrowHt));
			addChild(square);			
			target.mask = square;
			
		}
		public function upScroll(event:MouseEvent):void {
			isUp = true;
		}
		public function downScroll(event:MouseEvent):void {
			isDown = true;
		}
		public function upArrowHandler(event:Event):void {
			if (isUp) {
				if (scroller.y > top) {
					scroller.y-=arrowMove;
					if (scroller.y < top) {
						scroller.y = top;
					}
					startScroll();
				}
			}
		}
		//
		public function downArrowHandler(event:Event):void {
			if (isDown) {
				if (scroller.y < dragBot) {
					scroller.y+=arrowMove;
					if (scroller.y > dragBot) {
						scroller.y = dragBot;
					}
					startScroll();
				}
			}
		}
		//
		public function dragScroll(event:MouseEvent):void {			
			scroller.startDrag(false, sRect);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, moveScroll);
		}
		//
		public function mouseWheelHandler(event:MouseEvent):void {
			if (event.delta < 0) {
				if (scroller.y < dragBot) {
					scroller.y-=(event.delta*2);
					if (scroller.y > dragBot) {
						scroller.y = dragBot;
					}
					startScroll();
				}
			} else {
				if (scroller.y > top) {
					scroller.y-=(event.delta*2);
					if (scroller.y < top) {
						scroller.y = top;
					}
					startScroll();
				}
			}
		}
		//
		public function stopScroll(event:MouseEvent):void {
			isUp = false;
			isDown = false;
			scroller.stopDrag();

			stage.removeEventListener(MouseEvent.MOUSE_MOVE, moveScroll);
		}
		//
		public function moveScroll(event:MouseEvent):void {
			startScroll();

		}
		public function startScroll():void {
			ratio = (target.height - range)/range;
			sPos = (scroller.y * ratio)-ctrl;
			
			Tweener.addTween(target, {y:-sPos, time:timing, transition:trans});
		}
	}
}