package com.ffaerber.view.text
{
	
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.text.engine.CFFHinting;
	import flash.text.engine.ElementFormat;
	import flash.text.engine.FontDescription;
	import flash.text.engine.FontLookup;
	import flash.text.engine.RenderingMode;
	import flash.text.engine.TextBlock;
	import flash.text.engine.TextElement;
	import flash.text.engine.TextLine;
	
	import flashx.textLayout.conversion.TextConverter;
	import flashx.textLayout.elements.TextFlow;
	import flashx.textLayout.factory.TextFlowTextLineFactory;
	
	public class TextFTEFF extends Sprite
	{
		
		private var _txt:String;
		private var _font:Object;
		private var _color:Number;
		private var _size:int;				
		private var _leading:int;
		private var _textboxwidth:int;
		private var _wordWrap:Boolean;
		private var _align:String;
		private var _lineHeight:String;
		private var _kerning:String;
		
		private var _url:String;
		private var _target:String = "_blank";
		private var _data:*;
		
		private var textElement:TextElement;
		private var elementFormat:ElementFormat;
		private var textBlock:TextBlock;
		private var textLine:TextLine;
		private var mysprite:Sprite;
		
		private var fontDescription:FontDescription;
		
		private var textcontainer:Sprite;
		
		
		
		
		public function TextFTEFF(
			txt:String, 
			font:Object = AssetManager.ARIAL, 
			color:Number = 0xffffff, 
			size:int = 20,
			leading:int = 0,
			textboxwidth:int = 1000,
			wordWrap:Boolean = true,
			align:String = "left",
			lineHeight:String = "120%",
			kerning:String = "0"
		)
			
		{
			_txt = txt;
			_font = font;
			_color = color;
			_size = size;
			_leading = leading;
			_textboxwidth = textboxwidth;
			_wordWrap = wordWrap;
			_align = align;
			_lineHeight = lineHeight;
			_kerning = kerning;
			
			configureLabel();
		}
		
		
		
		
		public function configureLabel():void
		{
			textcontainer = new Sprite()
			addChild(textcontainer)
			
			var markup:String = "<TextFlow  xmlns='http://ns.adobe.com/textLayout/2008'>"+_txt+"</TextFlow>";
			
			var textFlow:TextFlow = TextConverter.importToFlow(markup, TextConverter.TEXT_LAYOUT_FORMAT);
			textFlow.color = _color;
			textFlow.fontSize = _size;
			textFlow.fontFamily = _font; //AssetManager.ROTIS_SEM_SER; 
			textFlow.fontLookup = FontLookup.EMBEDDED_CFF;
			textFlow.renderingMode = RenderingMode.CFF;
			textFlow.cffHinting = CFFHinting.NONE;
			textFlow.textAlign = _align;
			textFlow.lineHeight = _lineHeight;
			textFlow.kerning = "on";
			textFlow.trackingRight = _kerning;
			//textFlow.breakOpportunity = "none";
			if(!_wordWrap)
			{
				textFlow.lineBreak = "explicit";
			}
			
				
				
			var factory:TextFlowTextLineFactory = new TextFlowTextLineFactory();
			factory.compositionBounds = new Rectangle(0,0,_textboxwidth,700);
			factory.createTextLines(callback,textFlow);			
		}
		
		
		
		
		
		private function callback(tl:TextLine):void
		{ 
			textcontainer.addChild(tl); 
		}
		
		
		
		
		
		

		
		
		
		
		
		
		
		public function get labelTxt():String
		{
			return textElement.text
		}
		
		
		public function get textWidth():int
		{
			return textcontainer.width
		}
		
		
		public function get textHeight():int
		{
			return textLine.textHeight
		}
		
		
		
		
		
		// TextBox that links to url in target window
		public function set url(url:String):void
		{
			this.buttonMode = true;
			textcontainer.mouseEnabled = false;
			_url = url;
			this.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		public function set target(target:String):void
		{
			_target = target;
		}
		
		private function onClick(event:MouseEvent):void
		{
			navigateToURL(new URLRequest(_url), _target);
		}
		
		// data property for anything
		public function set data(data:*):void
		{
			_data = data;
		}
		
		public function get data():*
		{
			return _data;
		}
		
		
		
		
		
		
	}
}