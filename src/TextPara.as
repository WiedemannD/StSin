package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class TextPara extends Sprite
	{
		private var formatter:TextFormat;
		private var field:TextField;		
		private var embedFonts:Fonts = new Fonts();
		private var _url:String;
		private var _data:String;
		
		public function TextPara(text:String, color:Number, font:String, size:Number = 14, textAlign:String = "left", paraWidth:Number = 300, paraHeight:Number = 300)
		{
			/*var textBox:TextFTEFF = new TextFTEFF("hjk", "stan0763", 0xFFFFFF, 20, 0, 100, true);
			addChild(textBox);*/
			
			formatter  = new TextFormat();
			formatter.font = font;
			formatter.color = color;
			formatter.size = size;
			formatter.align = textAlign;
			
			field = new TextField();       
			field.multiline = true;
			//field.html = true;
			field.wordWrap = true;
			//field.embedFonts = true;
			field.width = paraWidth;
			field.height = paraHeight;
			field.text = text;
			
			/*if(html)
			{
				field.htmlText = text;
			}
			else
			{
				field.text = text;
			}*/
			
			
			
			field.setTextFormat(formatter);
			
			
			addChild(field);

		}
		
		public function set paraWidth(paraWidth:Number):void
		{
			field.width = paraWidth;
		}
		
		public function set paraHeight(paraHeight:Number):void
		{
			field.height = paraHeight;
		}
		
		public function set url(url:String):void
		{
			this.buttonMode = true;
			field.mouseEnabled = false;
			_url = url;
			this.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}

		private function onClick(event:MouseEvent):void
		{
			navigateToURL(new URLRequest(_url), "_blank");
		}
		
		public function set data(data:String):void
		{
			this.buttonMode = true;
			field.mouseEnabled = false;
			_data = data;
		}
		
		public function get data():String
		{
			return _data;
		}
		
	}
}