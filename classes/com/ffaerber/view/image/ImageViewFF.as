
/* AS3
	Copyright 2008 findsubstance;
*/
package com.ffaerber.view.image
{
	

	
	import caurina.transitions.Tweener;
	
	import com.ffaerber.view.graphics.RectangleFF;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	
	public class ImageViewFF extends Sprite 
	{
		
		
		
		
		
		//--------------------------------------
		//  CLASS VARIABLES
		//--------------------------------------
		
		// display items;
		private var container :Sprite;
		private var fadeimage : Bitmap;
		private var m_image : Bitmap;				// bitmap to contain loaded image;
		
		// vars;
		private var m_loader : Loader;
		private var m_isCentered : Boolean;				// determines whether image is centered or positioned @ top left;
		private var m_isShrinkEnabled : Boolean;		// determines whether image can be sized below 100% scale;
		
		
		private var m_isScale:Boolean;
		
		private var _position:String;
		
		private var _viewWidth:Number;
		private var _viewHeight:Number;
		private var _debug:Boolean;
		
		
		
		



		public function ImageViewFF ( 
									inImageURL : String = null, 
									position:String = "center",
									viewWidth:Number = 300,
									viewHeight:Number = 300,
									debug:Boolean = false
									
									) 
		{
			super();
			
			_position = position;
			
			_viewWidth = viewWidth;
			_viewHeight = viewHeight;
			
			_debug = debug
			
			
			
			
			
			
				
			container = new Sprite()
			container.width = _viewWidth
			container.height = _viewHeight
			addChild(container)
						
			m_image = new Bitmap()	
			container.addChild(m_image)
			
			
			if (_debug){
				var viewbg:RectangleFF = new RectangleFF(0, 0, _viewWidth, _viewHeight, 0, 0, 0x0000ff, 0.2)
				addChild(viewbg)	
			}else{
				var viewbg:RectangleFF = new RectangleFF(0, 0, _viewWidth, _viewHeight, 0, 0, 0x0000ff, 0)
				addChild(viewbg)
			}
			

			
			
			// set up loader;
			m_loader = new Loader();
			m_loader.contentLoaderInfo.addEventListener( Event.COMPLETE, onImageLoaded );
			
			// listen for stage addition ( since stage is currently null );
			this.addEventListener( Event.ADDED_TO_STAGE, onAdded );
			
			// load image if an initial url was passed in;
			if ( inImageURL != null ) this.load( inImageURL );
			
		}
		
		
		
		
		

		
		
		
		
		
		
		
		
		//--------------------------------------
		//  GETTER/SETTERS
		//--------------------------------------
		
		public function get shrinkable () : Boolean
		{
			return m_isShrinkEnabled;
		}
		
		public function set shrinkable ( inIsShrinkable : Boolean ) : void
		{
			m_isShrinkEnabled = inIsShrinkable;
		}
		
		public function get centered () : Boolean
		{
			return m_isCentered;
		}
		
		public function set centered ( inIsCentered : Boolean ) : void
		{
			m_isCentered = inIsCentered;
		}
		
		
		
		
		
		
		//--------------------------------------
		//  PUBLIC METHODS
		//--------------------------------------


		public function load ( inURL : String ) : void
		{
			if (inURL != "")
			{
				m_loader.load( new URLRequest( inURL )); 	// convert string to URLRequest & load url;
				if(_debug) trace("Loding:..........inURL"+ inURL)
			}
			else
			{
				Tweener.addTween(m_image, { alpha:0, time:1, delay:0.3, transition:"easeOutQuint"});
				if(_debug) trace("Hide:..........ImageViewFF")
			}
		}



		public function updateSize (viewWidth:int, viewHeight:int ) : void
		{
			_viewWidth = viewWidth
			_viewHeight	= viewHeight	
			onResize()
		}








		//--------------------------------------
		//  EVENT HANDLERS
		//--------------------------------------
		
		private function onAdded ( e : Event ) : void
		{
			// listen for stage resize;
			stage.addEventListener( Event.RESIZE, onResize );
		}
		
		
		
		
		
		private function onImageLoaded ( e : Event ) : void
		{
			// get bitmap from loader;
			
			var image : Bitmap = Bitmap( m_loader.content );
			var bmd : BitmapData = image.bitmapData;
			 
			fadeimage = new Bitmap(bmd);
			fadeimage.smoothing = true;
			container.addChild(fadeimage)
			
			Tweener.addTween(m_image, { alpha:1, time:.5, transition:"easeOutQuint"});
			// set bitmap size & position;
			onResize();
			
			
			
			// tween in
			fadeimage.alpha = 0;
			Tweener.addTween(fadeimage, { alpha:1, time:.5, transition:"easeOutQuint", onComplete:function():void { 
								 m_image.bitmapData = fadeimage.bitmapData
								 container.removeChild(fadeimage)
								}});
						



			
			bmd = null
			image = null
			
		}
		
		
		
		
		
		
		
		
		
		
		private function onResize ( e : Event = null ) : void
		{
			// make sure image is instantiated;
			if ( m_image != null )
			{
				
				
		
					// set image dimensions to match _viewWidth and _viewHeight
					container.width = _viewWidth;
					container.height = _viewHeight;							

					// adjust proportionally to fill stage;
					( container.scaleX > container.scaleY ) ? container.scaleY = container.scaleX : container.scaleX = container.scaleY;
	
					// control shrinkage;
					if ( !this.shrinkable ) if ( container.scaleX < 1 || container.scaleY < 1 ) container.scaleX = container.scaleY = 1;	
			

				


				// center image;
				if ( _position == "center" )
				{
					container.x = _viewWidth * .5 - container.width * .5;
					container.y = _viewHeight * .5 - container.height * .5;
				}
				else if ( _position == "left" )
				{
					container.x = 0
				}
				else if ( _position == "right" )
				{
					container.x = -(m_image.width - _viewWidth)
				}	
				
				
				
			}
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		//--------------------------------------
		//  PRIVATE & PROTECTED INSTANCE METHODS
		//--------------------------------------
		
		
		
		
		
		
		
	}
}
