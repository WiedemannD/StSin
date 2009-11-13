package com.ffaerber.view.graphics
{
	import flash.display.Shape;
	import flash.display.Sprite;
	

	
	
	
	public class RectangleFF extends Sprite
	{
		private var _id:int;
		private var _x:int;
		private var _y:int;
		private var _witdh:int;
		private var _height:int;
		private var _topLeftRadius:int;
		private var _topRightRadius:int;
		private var _bottomLeftRadius:int;
		private var _bottoRightRadius:int;
		
		private var _borderSize:int;
		private var _borderColor:Number;
		
		private var _bgColor:Number;
		private var _bgAlpha:Number;

		private var _vo:Object;


		private var child:Shape = new Shape();
		

		public function RectangleFF(
										x:int=0, 
										y:int=0, 
										witdh:int=50, 
										height:int=50, 
										borderSize:int=1,
										borderColor:Number=0x666666,
										bgColor:Number=0xffffff,
										bgAlpha:Number=1,
										radius:Array=null,
										id:int=0,
										vo:Object=null
									)
		{
			_vo = vo
			_id = id;
			_x = x; 
			_y = y;
			_witdh = witdh;
			_height = height;
			_borderSize = borderSize;
			_borderColor = borderColor;
			_bgColor = bgColor;
			_bgAlpha = bgAlpha;
			
			if (radius){
				
				if(radius.length == 4)
				{
					_topLeftRadius = radius[0]
					_topRightRadius = radius[1]
					_bottomLeftRadius = radius[2]
					_bottoRightRadius = radius[3]
				}
				else if(radius.length == 1)
				{
					_topLeftRadius = radius[0]
					_topRightRadius = radius[0]
					_bottomLeftRadius = radius[0]
					_bottoRightRadius = radius[0]
				}
				else
				{
					trace("RectangleFF radius ERROR -> null, 1 or 4 ints")
				}
				
			}
			else
			{
				_topLeftRadius = 0
				_topRightRadius = 0
				_bottomLeftRadius = 0
				_bottoRightRadius = 0
			}

			
			// add Graphic
			addGraphic()
			
			
			
			
		}
		
		
		private function addGraphic():void
		{
            child.graphics.beginFill(_bgColor);
            if (_borderSize != 0) child.graphics.lineStyle(_borderSize, _borderColor);
            child.graphics.drawRoundRectComplex(_x, _y, _witdh, _height, _topLeftRadius, _topRightRadius, _bottomLeftRadius, _bottoRightRadius)
            child.graphics.endFill();
            child.alpha = _bgAlpha
            addChild(child);
		}
		
		
		
		public function get id():int
		{
			return _id
		}
		
		public function get vo():Object
		{
			return _vo
		}

		
		
		
		
		
		
		
		
		
	}
}