package com.ffaerber.view.text
{
	

	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.engine.FontDescription;
	
	
	public class TextFF extends Sprite
	{

		private var _txt:String;
		private var _font:String;
		private var _color:Number;
		private var _size:int;				
		private var _leading:int;
		private var _textboxwidth:int;
		private var _wordWrap:Boolean;
		
		private var myTextBox:TextField;
		
		
		private var fontDescription:FontDescription;
		
		
		
		
			
		
		public function TextFF(
						txt:String, 
						font:String ="Arial", 
						color:Number = 0xffffff, 
						size:int = 20,
						leading:int = 0,
						textboxwidth:int = 1000,
						wordWrap:Boolean = true
						)
			
		{
			_txt = txt;
			_font = font;
			_color = color;
			_size = size;
			_leading = leading;
			_textboxwidth = textboxwidth;
			_wordWrap = wordWrap;
			
            configureLabel();
            
		}







		public function configureLabel():void
		{
		
			
			var format:TextFormat = new TextFormat(); 
			format.font = AssetManager.ROTIS_SEM_SER
			format.size = _size
			format.color = _color

				
			var myTextBox:TextField = new TextField();
			myTextBox.multiline = true; 
			myTextBox.wordWrap = true; 
			myTextBox.setTextFormat(format)
			myTextBox.width = 300; 
			myTextBox.autoSize = TextFieldAutoSize.LEFT; 

			
			addChild(myTextBox);
			
			myTextBox.htmlText = _txt; 

		}

		

		
		


        public function get labelTxt():String
        {
            return myTextBox.htmlText
        }

		
		public function get textWidth():int
		{
			return 200
		}

	
		public function get textHeight():int
		{
			return myTextBox.textHeight
		}









	}
}