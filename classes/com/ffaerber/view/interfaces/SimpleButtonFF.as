package com.ffaerber.view.interfaces
{
	import com.ffaerber.view.graphics.RectangleFF;
	import com.ffaerber.view.text.TextFF;
	
	import flash.display.Sprite;


	
	
	public class SimpleButtonFF extends Sprite
	{
		
		
		
		
		
		private var _txt:String;
		private var _font:String;
		private var _color:Number;
		private var _size:int;	

		
		private var _background:Boolean;
		private var _x:int
		private var _y:int 
		private var _witdh:int
		private var _height:int
		private var _radius:Array
		private var _borderSize:int
		private var _borderColor:Number
		private var _bgColor:Number;
		private var _bgAlpha:Number;	
		
		private var ground:RectangleFF;
		private var label:TextFF;
		
		
		
		
		
		
		
		public function SimpleButtonFF(
											txt:String, 
											font:String = "Arial", 
											color:Number = 0xffffff, 
											size:int = 20,
											
											background:Boolean = true,
											radius:Array=null, 
											borderSize:int=0,
											borderColor:Number=0x666666,
											bgColor:Number=0xffffff,
											bgAlpha:Number=1
									)
		{
			
			
			_txt = txt;
			_font = font;
			_color = color;
			_size = size;
			
			
			_background = background;
			_radius = radius
			_borderSize = borderSize
			_borderColor = borderColor
			_bgColor = bgColor;
			_bgAlpha = bgAlpha
			
			configureLabel()
			configureBGround()
			addElements()
		}
		










		public function configureLabel():void
		{
            label = new TextFF( _txt, "Arial", 0xffffff, 30 )
		}










		public function configureBGround():void
		{
            if (_background){
            	ground = new RectangleFF(-4, 0, label.textWidth+14, label.textHeight+3 ,_borderSize, _borderColor, _bgColor, _bgAlpha, _radius)
            }
		}










		public function addElements():void
		{
			addChild(ground);
			addChild(label);
		}


		
		
		
		
		
		
	}
}