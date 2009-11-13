package {
	import caurina.transitions.Tweener;
	
	import com.ffaerber.view.interfaces.scrollbar.scrollbarUI.ScrollbarFF;
	import com.ffaerber.view.mediaplayer.MediaPlayerFF;
	import com.ffaerber.view.mediaplayer.vo.MediaItemVO;
	import com.ffaerber.view.mediaplayer.vo.MediaplayerVO;
	import com.ffaerber.view.text.TextFTEFF;
	import com.ffaerber.view.videoplay.SimpleVideoPlayer;
	import com.leebrimelow.utils.Math2;
	import com.theflashblog.SimpleZSorter.SimpleZSorter;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	

	[SWF(width="1024", backgroundColor="#000000", frameRate="30")] //height="768",

	public class StSin extends Sprite
	{
		private var swfWidth:Number = 1024;
		private var swfHeight:Number = 768;
		
		private var headerContainer:Sprite;
		private var container:Sprite;
		private var boxContainer:Sprite;
		private var layer:Sprite;
		private var layerContainer:Sprite;
		private var disclaimer:TextFTEFF;
		private var footerNaviContainer:Sprite;
		private var flagDE:SimpleImage;
		private var flagEN:SimpleImage;
		private var flagFR:SimpleImage;
		private var switchesContainer:Sprite;
		
		private var loader:URLLoader;
		private var xml:XML;
		
		private var anglePer:Number;
		private var currentLang:String = new String("de");
		private var radius:Number = new Number(600);
		private var carouselRotation:Number;
		
		private var white:Number = 0xFFFFFF;
		private var lightGrey:Number = 0x666666;
		private var darkGrey:Number = 0x333333;
		
		public function StSin()
		{
			init();
		}
		
		private function init():void
		{
			var background:SimpleImage = new SimpleImage("../images/background.jpg");
			background.y = 0;
			background.x = 0;
			addChild(background);
						
			headerContainer = new Sprite();
			headerContainer.x = 0;
			headerContainer.y = 90;
			addChild(headerContainer);
			
			container = new Sprite();
			container.x = 350;
			container.y = 250;
			container.z = 700;
			addChild(container);
			
			boxContainer = new Sprite();
			//boxContainer.width = 1024;
			boxContainer.x = 0;
			boxContainer.y = 520;
			addChild(boxContainer);
			
			switchesContainer = new Sprite();
			switchesContainer.x = swfWidth/2 - 38;
			switchesContainer.y = 450;
			switchesContainer.alpha = 0;
			addChild(switchesContainer);
			
			this.addEventListener(Event.ENTER_FRAME, onEnterFrame);
			
			initializeStage();
			
			loadXML();
			
			layer = new Sprite();
			layer.x = 0;
			layer.y = 0;
			layer.graphics.beginFill(0x000000, 0.9);
			layer.graphics.drawRect(0, 0, 1024, 768);
			layer.graphics.endFill();
			layer.alpha = 0;
			layer.visible = false;
			addChild(layer);
			var layerBg:SimpleImage = new SimpleImage("../images/layer_background.png");
			layerBg.x = (swfWidth - 828)/2;
			layerBg.y = 60;
			layer.addChild(layerBg);
			var layerX:SimpleImage = new SimpleImage("../images/layer_x.png");
			layerX.x = (swfWidth - 828)/2 + 828 - 42;
			layerX.y = 100;
			layerX.addEventListener(MouseEvent.MOUSE_DOWN, closeLayer);
			layerX.buttonMode = true;
			layer.addChild(layerX);
			layerContainer = new Sprite();
			layerContainer.x = (swfWidth - 828)/2 + 60;
			layerContainer.y = 110;
			layer.addChild(layerContainer);			
			
			overlayIcons();	
		}
		
		private function switchLang(e:MouseEvent):void
		{
			var flag:SimpleImage = e.currentTarget as SimpleImage;
			Tweener.addTween(flag, {alpha:0.5, time:0.8, transition:"easeOutQuad"});
			currentLang = flag.data;
			
			if(flag.data == "de")
			{
				Tweener.addTween(flagEN, {alpha:0.2, time:0.8, transition:"easeOutQuad"});
				Tweener.addTween(flagFR, {alpha:0.2, time:0.8, transition:"easeOutQuad"});
			}
			if(flag.data == "en")
			{
				Tweener.addTween(flagDE, {alpha:0.2, time:0.8, transition:"easeOutQuad"});
				Tweener.addTween(flagFR, {alpha:0.2, time:0.8, transition:"easeOutQuad"});
			}
			if(flag.data == "fr")
			{
				Tweener.addTween(flagEN, {alpha:0.2, time:0.8, transition:"easeOutQuad"});
				Tweener.addTween(flagDE, {alpha:0.2, time:0.8, transition:"easeOutQuad"});
			}
			
			Cleaner.removeChildren(headerContainer);
			Cleaner.removeChildren(container);
			Cleaner.removeChildren(boxContainer);
			Cleaner.removeChildren(disclaimer);
			Cleaner.removeChildren(footerNaviContainer);
			Cleaner.removeChildren(switchesContainer);
			
			//init();
			loadXML();
		}
		
		private function overlayIcons():void
		{
			var logo:SimpleImage = new SimpleImage("../images/logo.png");
			logo.y = 20;
			logo.x = 870;
			addChild(logo);
			
			var icoFb:SimpleImage = new SimpleImage("../images/ico_facebook.png", "http://facebook.com");
			icoFb.y = 700;
			icoFb.x = 0;
			addChild(icoFb);
			
			var icoShop:SimpleImage = new SimpleImage("../images/ico_shop.jpg", "http://shop.com");
			icoShop.y = 700;
			icoShop.x = 120;
			addChild(icoShop);
			
			var icoCh:SimpleImage = new SimpleImage("../images/ico_chemie.jpg");
			icoCh.y = 676;
			icoCh.x = swfWidth - 50;
			addChild(icoCh);
			
			var line:Sprite = new Sprite();
			line.graphics.beginFill(0x111111, 1);
			line.graphics.drawRect(0, 0, swfWidth, 1);
			line.graphics.endFill();
			line.y = 730;
			addChild(line);
			
			var copyright:TextFTEFF = new TextFTEFF("© 2009 ST.SIN ALL RIGHTS RESERVED", "stan0756", darkGrey, 7, 0, 250, true, "right");
			copyright.x = swfWidth - 254;
			copyright.y = 737;
			addChild(copyright);
			
			flagDE = new SimpleImage("../images/flag_de.jpg");
			flagDE.alpha = 0.5;
			flagDE.y = 736;
			flagDE.x = swfWidth - 260;
			flagDE.data = "de";
			flagDE.buttonMode = true;
			flagDE.addEventListener(MouseEvent.CLICK, switchLang);
			addChild(flagDE);
			
			flagEN = new SimpleImage("../images/flag_en.jpg");
			flagEN.alpha = 0.2;
			flagEN.y = 736;
			flagEN.x = swfWidth - 240;
			flagEN.data = "en";
			flagEN.buttonMode = true;
			flagEN.addEventListener(MouseEvent.CLICK, switchLang);
			addChild(flagEN);
			
			flagFR = new SimpleImage("../images/flag_fr.jpg");
			flagFR.alpha = 0.2;
			flagFR.y = 736;
			flagFR.x = swfWidth - 220;
			flagFR.data = "fr";
			flagFR.buttonMode = true;
			flagFR.addEventListener(MouseEvent.CLICK, switchLang);
			addChild(flagFR);
			
			footerNaviContainer = new Sprite();
			footerNaviContainer.x = 5;
			footerNaviContainer.y = 734;
			addChild(footerNaviContainer);
			
		}
		
		private function initializeStage():void {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP;
		}
		
		private function onProductMouseOver(e:MouseEvent):void
		{
			var moProductId:int = container.getChildIndex(e.currentTarget as MovieClip);
			//trace("moProductId: "+moProductId);
		}
		
		private function onProductClick(e:MouseEvent):void
		{
			var currentVideoContainer:MovieClip = e.currentTarget as MovieClip;
			var frontalVideoContainer:MovieClip = container.getChildAt(container.numChildren - 1) as MovieClip;
			var clickedProductId:int = container.getChildIndex(currentVideoContainer);
			var newPath:String;
			var newRotationY:Number = Math2.toDeg(e.currentTarget.angle + Math.PI/2);
			var itemRotationY:Number = 360 / container.numChildren;
			
			// product not in front is clicked
			if(clickedProductId != container.numChildren - 1)
			{
				Tweener.addTween(container, {rotationY:newRotationY, time:0.8, transition:"easeOut"});
				
				for(var i:int=0; i<container.numChildren; i++)
				{
					var oldRotationY:Number = container.getChildAt(i).rotationY;
					
					if((currentVideoContainer.id > frontalVideoContainer.id ) || (currentVideoContainer.id == 0 && frontalVideoContainer.id == container.numChildren - 1))
					{
						// Click to the right
						if(frontalVideoContainer.id + currentVideoContainer.id != container.numChildren - 1 || (currentVideoContainer.id == 0 && frontalVideoContainer.id == container.numChildren - 1))
						{
							Tweener.addTween(container.getChildAt(i), {rotationY:oldRotationY - itemRotationY, time:0.8, transition:"easeOut"});
						}
						// Click to the left
						else
						{
							Tweener.addTween(container.getChildAt(i), {rotationY:oldRotationY + itemRotationY, time:0.8, transition:"easeOut"});
						}
					}
					// Click to the left
					else
					{
						Tweener.addTween(container.getChildAt(i), {rotationY:oldRotationY + itemRotationY, time:0.8, transition:"easeOut"});
					}
				}
				
				createHeader(currentVideoContainer.id);
				createSwitches(currentVideoContainer.single);
				createBoxes(currentVideoContainer.id);
			}
			//product in front is clicked
			else
			{
				// play product video and switch to other video
				
				if(currentVideoContainer.single)
				{
					onMultiClick(null);
				}
				else
				{
					onSingleClick(null);
				}
				
				if(boxContainer.numChildren == 1)
				{
					createHeader(currentVideoContainer.id);
					createSwitches(currentVideoContainer.single);
					createBoxes(currentVideoContainer.id);
				}
				
				/*var videoContainer:MovieClip = container.getChildAt(clickedProductId) as MovieClip;
				
				var oldVideo:SimpleVideoPlayer = videoContainer.getChildAt(0) as SimpleVideoPlayer;
				oldVideo.addEventListener(SimpleVideoPlayerEvent.VIDEO_STOPPED, onVideoStopped);
				oldVideo.togglePause();
				
				function onVideoStopped(e:SimpleVideoPlayerEvent):void
				{
					
					if(videoContainer.single)
					{
						newPath = new String(xml.productCarousels.productCarousel.(@lang == currentLang).product.multi[videoContainer.id].text());
						videoContainer.single = false;
					}
					else
					{
						newPath = new String(xml.productCarousels.productCarousel.(@lang == currentLang).product.single[videoContainer.id].text());
						videoContainer.single = true;
					}
					
					var newVideo:SimpleVideoPlayer = new SimpleVideoPlayer(null, newPath, false, 0);
					
					videoContainer.addChild(newVideo);
					videoContainer.removeChildAt(0);
				}*/
			}
		}
		
		
		private function onEnterFrame(e:Event):void
		{
			SimpleZSorter.sortClips(container);
		}
		
		private function loadXML():void
		{
			loader = new URLLoader(new URLRequest("../contents.xml"));
			loader.addEventListener(Event.COMPLETE, onXMLLoaded);
		}
		
		private function onXMLLoaded(e:Event):void
		{
			createCarousel(e);
			createDisclaimer();
			createFooterNavi();
		}
		
		private function createHeader(id:int):void
		{
			var headline:String;
			var subheadline:String;
			
			if(id == -1)
			{
				headline = xml.productCarousels.productCarousel.(@lang == currentLang).start.header.headline.text();
				subheadline = xml.productCarousels.productCarousel.(@lang == currentLang).start.header.subheadline.text();
			}
			else
			{
				headline = xml.productCarousels.productCarousel.(@lang == currentLang).product[id].header.headline.text();
				subheadline = xml.productCarousels.productCarousel.(@lang == currentLang).product[id].header.subheadline.text(); 
			}
			
			Cleaner.removeChildren(headerContainer);
			
			var headlineTextPara:TextFTEFF = new TextFTEFF(headline, "AbadiMTCondensedExtraBold", white, 30, 0, swfWidth, true, "center");
			headlineTextPara.x = 0;
			headlineTextPara.y = 0;
			headlineTextPara.alpha = 0;
			headerContainer.addChild(headlineTextPara);
			Tweener.addTween(headlineTextPara, {alpha:1, time:0.8, transition:"easeOutQuad"});
			
			var subheadlineTextPara:TextFTEFF = new TextFTEFF(subheadline, "AbadiMTCondensedLight", lightGrey, 16, 0, 650, true, "center");
			subheadlineTextPara.x = (swfWidth - 650)/2;
			subheadlineTextPara.y = 34;
			subheadlineTextPara.alpha = 0;
			headerContainer.addChild(subheadlineTextPara);
			Tweener.addTween(subheadlineTextPara, {alpha:1, time:0.8, transition:"easeOutQuad"});
		}
		
		private function createCarousel(e:Event):void
		{
			container.rotationY = 0;
			carouselRotation = Math.PI/2;
			
			xml = new XML(e.target.data);
			var singleProducts:XMLList = xml.productCarousels.productCarousel.(@lang == currentLang).product.single;
			var lastI:int;
			anglePer = (Math.PI*2) / singleProducts.length();
			
			for(var i:int=0; i<singleProducts.length(); i++)
			{
				var videoContainer:MovieClip = new MovieClip();
				videoContainer.buttonMode = true;
				videoContainer.addEventListener(MouseEvent.CLICK, onProductClick);
				videoContainer.addEventListener(MouseEvent.MOUSE_OVER, onProductMouseOver);
				
				//var video:SimpleVideoPlayer = new SimpleVideoPlayer(null, singleProducts[i].text(), false, 0);
				//videoContainer.addChild(video);
				var mediaItemVO01:MediaItemVO = new MediaItemVO("video", singleProducts[i].text(), null, null, null, false);
				var mediaItemVO01:MediaItemVO = new MediaItemVO("video", singleProducts[i].text(), null, null, null, false);
				var playlist:Array = new Array(mediaItemVO);
				var mediaplayerVO:MediaplayerVO = new MediaplayerVO(playlist, true, false, false, false);
				var video:MediaPlayerFF = new MediaPlayerFF(mediaplayerVO);
				videoContainer.addChild(video);
				
				videoContainer.id = i;
				videoContainer.single = true;
				videoContainer.angle = (i*anglePer) - carouselRotation;
				videoContainer.x = Math.cos(videoContainer.angle) * radius;
				videoContainer.z = Math.sin(videoContainer.angle) * radius;
				
				//var test:TextFTEFF = new TextFTEFF("id="+i, "Arial", white, 22, 0, 100, true, "left");
				//videoContainer.addChild(test);
				
				container.addChild(videoContainer);
				
				lastI = i;
			}
			
			
			
			createHeader(-1);
			/*createSwitches(true);*/
			createBoxes(-1);
		}
		
		private function createSwitches(single:Boolean):void
		{
			switchesContainer.alpha = 0;
			Cleaner.removeChildren(switchesContainer);
			
			var singleIco:SimpleImage;
			var singlePath:String;
			var multiIco:SimpleImage;
			var multiPath:String;
			
			if(single)
			{
				singlePath = new String("../images/ico_flow_active.jpg");
				multiPath = new String("../images/ico_blister_inactive.jpg");
				
				singleIco = new SimpleImage(singlePath);
				switchesContainer.addChild(singleIco);
				
				multiIco = new SimpleImage(multiPath);
				multiIco.x = 20;
				switchesContainer.addChild(multiIco);
				multiIco.buttonMode = true;
				multiIco.addEventListener(MouseEvent.MOUSE_DOWN, onMultiClick);
			}
			else
			{
				singlePath = new String("../images/ico_flow_inactive.jpg");
				multiPath = new String("../images/ico_blister_active.jpg");
				
				singleIco = new SimpleImage(singlePath);
				switchesContainer.addChild(singleIco);
				singleIco.buttonMode = true
				singleIco.addEventListener(MouseEvent.MOUSE_DOWN, onSingleClick);
				
				multiIco = new SimpleImage(multiPath);
				multiIco.x = 20;
				switchesContainer.addChild(multiIco);
			}
			Tweener.addTween(switchesContainer, {alpha:1, time:0.8, transition:"easeOutQuad"});
		}
		
		private function onSingleClick(e:*):void
		{
			var videoContainer:MovieClip = container.getChildAt(container.numChildren-1) as MovieClip;
			
			var newPath:String = new String(xml.productCarousels.productCarousel.(@lang == currentLang).product.single[videoContainer.id].text());
			videoContainer.single = true;
			
			var newVideo:SimpleVideoPlayer = new SimpleVideoPlayer(null, newPath, false, 0);
			
			videoContainer.addChild(newVideo);
			videoContainer.removeChildAt(0);
			
			createSwitches(true);
		}
		
		private function onMultiClick(e:*):void
		{
			var videoContainer:MovieClip = container.getChildAt(container.numChildren-1) as MovieClip;
			
			var newPath:String = new String(xml.productCarousels.productCarousel.(@lang == currentLang).product.multi[videoContainer.id].text());
			videoContainer.single = false;
			
			var newVideo:SimpleVideoPlayer = new SimpleVideoPlayer(null, newPath, false, 0);
			
			videoContainer.addChild(newVideo);
			videoContainer.removeChildAt(0);
			
			createSwitches(false);
		}
		
		private function createBoxes(id:int):void
		{
			var boxes:XMLList;
			var margin:Number = 30;
			
			if(id == -1)
			{
				boxes = xml.productCarousels.productCarousel.(@lang == currentLang).start.box;
			}
			else
			{
				boxes = xml.productCarousels.productCarousel.(@lang == currentLang).product[id].box;
			}

			
			Cleaner.removeChildren(boxContainer);
						
			for(var i:int=0; i<boxes.length(); i++)
			{
				var box:Sprite = new Sprite();
				box.y = 60;
				var bgPath:String = new String(boxes[i].background.text());
				var bgWidth:Number = boxes[i].background.@width;
				var bgHeight:Number = boxes[i].background.@height;
				var headline:String = new String(boxes[i].headline.text());
				var text:String = new String(boxes[i].text.text());
				var boxBg:SimpleImage = new SimpleImage(bgPath);
				
				box.x = ((swfWidth - bgWidth * boxes.length())/2 - margin*(boxes.length()-1)) + (i*(bgWidth + margin));
				
				/*trace((swfWidth - bgX * boxes.length())/2);
				trace(margin*(boxes.length()-1));
				trace(i*(bgX + margin));*/
				
				box.addChild(boxBg);				
				
				
				var headlineTextPara:TextFTEFF = new TextFTEFF(headline, "stan0763", white, 8, 0, bgWidth - (margin), true, "left");
				headlineTextPara.x = margin/2;
				headlineTextPara.y = margin/2;
				box.addChild(headlineTextPara);
				
				var textPara:TextFTEFF = new TextFTEFF(text, "stan0756", lightGrey, 8, 0, bgWidth - (margin), true, "left", "13");
				textPara.x = margin/2;
				textPara.y = margin/2 + margin/2;
				box.addChild(textPara);
				box.alpha = 0;
				
				boxContainer.addChild(box);
				
				Tweener.addTween(box, {alpha:1, time:0.6, transition:"easeOutQuad", delay:i*0.15});
				Tweener.addTween(box, {y:0, time:0.8, transition:"easeOutElastic", delay:i*0.15});
			}
		}
		
		private function createDisclaimer():void
		{
			var disclaimerText:String = xml.disclaimers.disclaimer.(@lang == currentLang).text();
			
			disclaimer = new TextFTEFF(disclaimerText, "stan0756", lightGrey, 8, 0, 360, true, "right", "13");
			disclaimer.y = 694;
			disclaimer.x = 600;
			addChild(disclaimer);
		}
		
		private function createFooterNavi():void
		{
			var naviItems:XMLList = xml.tabelofcontents.items.(@lang == currentLang).item;
						
			var itemCount:int = naviItems.length();
			var padding:Number = 0;
			
			for(var i:int=0; i<naviItems.length(); i++)
			{
				var layer:String = naviItems[i].@layer;
				var url:String = naviItems[i].@url;
				var width:Number = naviItems[i].@width;
				var label:String = naviItems[i].@label;
				
				var fullLabel:String;
				if(i == naviItems.length() - 1)
				{
					fullLabel = new String(label.toUpperCase());
				}
				else
				{
					fullLabel = new String(label.toUpperCase() + "  |");
				}
				
				var naviItem:TextFTEFF = new TextFTEFF(fullLabel, "stan0756", darkGrey, 7, 0, width + 10, false);
				naviItem.y = 0;
				naviItem.x = padding;
				if(url != "")
				{
					naviItem.url = url;
				}
				if(layer != "")
				{
					naviItem.data = layer;
					naviItem.buttonMode = true;
					naviItem.addEventListener(MouseEvent.MOUSE_DOWN, onNaviItemClick);
				}
				footerNaviContainer.addChild(naviItem);
				
				padding += width + 10;
				
			}
		}
		
		private function onNaviItemClick(e:MouseEvent):void
		{
			Cleaner.removeChildren(layerContainer);
			
			var naviItem:TextFTEFF = e.currentTarget as TextFTEFF;
			var layer:String = naviItem.data;
			var item:XMLList = xml.tabelofcontents.items.(@lang == currentLang).item.(hasOwnProperty( "@layer" ) && @layer == layer);
			var label:String = item.@label;
			var headline:TextFTEFF = new TextFTEFF(label, "AbadiMTCondensedExtraBold", white, 30, 0, 500, false);
			headline.x = 0;
			headline.y = 0;
			layerContainer.addChild(headline);
			
			var contentContainer:Sprite = new Sprite();
			contentContainer.x = 20;
			layerContainer.addChild(contentContainer);
						
			var ccWidth:Number = 700;
			var ccHeight:Number = 400;
			var padding:Number = 50;
			var offsetX:Number = 0;
			var offsetY:Number = 0;
			var offsetLocalY:Number = 0;
			
			for(var i:int = 0; i < item.item.length(); i++)
			{
				var itemSprite:Sprite = new Sprite();
				var itemText:String = item.item[i].text();
				var url:String = item.item[i].@url;
				var thumb:String = item.item[i].@thumb;
				var width:Number = item.item[i].@width;
				var height:Number = item.item[i].@height;
				
				if(offsetX + width > ccWidth)
				{
					offsetX = 0;
					offsetY = offsetY + offsetLocalY;
					offsetLocalY = 0;
				}
				
				if(thumb != "")
				{
					var image:SimpleImage = new SimpleImage(thumb, url);
					image.graphics.lineStyle(2, 0xFFFFFF, 1);
					image.graphics.drawRect(0, 0, 50, 100);
					var title:TextFTEFF = new TextFTEFF(itemText.toUpperCase(), "stan0756", white, 6, 0, width + (padding - 4), true, "left", "11");
					title.y = height + 4;
					
					itemSprite.x = offsetX;
					itemSprite.y = offsetY;
					itemSprite.addChild(image);
					itemSprite.addChild(title);
					
					contentContainer.addChild(itemSprite);
					
				}
				else
				{
					var text:TextFTEFF = new TextFTEFF(itemText, "stan0756", lightGrey, 8, 0, width, true, "left", "13");
					itemSprite.x = offsetX;
					itemSprite.y = offsetY;
					itemSprite.addChild(text);
					contentContainer.addChild(itemSprite);
				}
				
				offsetX += width + padding;
				
				if(offsetLocalY < height + padding)
				{
					offsetLocalY = height + padding;
				}
				
			}
			
			if(ccHeight < offsetY + offsetLocalY)
			{
				var scrollbar:ScrollbarFF = new ScrollbarFF(contentContainer);
				scrollbar.y = 50;
				layerContainer.addChild(scrollbar);
				scrollbar.updateScrollbar(ccWidth, ccHeight, ccWidth, offsetY + offsetLocalY);
				
			}
			else
			{
				contentContainer.x = 0;
				contentContainer.y = 50;
			}
			
			openLayer();
		}
		
		/*private function test(e:MouseEvent):void
		{}*/
		
		private function openLayer():void
		{
			layer.visible = true;
			Tweener.addTween(layer, {alpha:1, time:0.4, transition:"easeOutQuad"});
		}
		
		private function closeLayer(e:MouseEvent):void
		{
			Tweener.addTween(layer, {alpha:0, time:0.4, transition:"easeInQuad"});
			Tweener.addTween(layer, {visible:false, time:0.4, transition:"easeInQuad"});
		}
		
	}
}
