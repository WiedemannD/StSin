package com.ffaerber.view.graphics
{
	import com.ffaerber.view.text.TextFF;
	
	import flash.display.GradientType;
	import flash.display.InterpolationMethod;
	import flash.display.Loader;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.net.URLRequest;
	
	
	
	public class ShapeFF extends Sprite
	{
		
		private var _id:int;
		private var _title:String;
		private var _color:Number;
		private var _logo:String
		
		private var _textlabel:TextFF;
		
		public function ShapeFF(color:Number = 0x000000)
		{
			
			_color = color

			addBackground()
			

		}
		

	
		
		
		
		
		private function addBackground():void
		{
			var type:String = GradientType.LINEAR;
			var ratios:Array = [0, 255];
			var spreadMethod:String = SpreadMethod.PAD;
			var interp:String = InterpolationMethod.LINEAR_RGB;
			var focalPtRatio:Number = 0;
			
			
			var colors1:Array = [0xffffff, 0xffffff];
			var alphas1:Array = [0.4, 0];
			
			var colors2:Array = [_color, _color];
			var alphas2:Array = [1, 1];

			
			var matrix:Matrix = new Matrix();
			var boxWidth:Number = 200;
			var boxHeight:Number = 200;
			var boxRotation:Number = Math.PI/2; // 90˚
			var tx:Number = 25;
			var ty:Number = 0;
			
			matrix.createGradientBox(boxWidth, boxHeight, boxRotation, tx, ty);
			
			
			
			
			
			
			var verlauf:Shape = new Shape;
			verlauf.graphics.beginGradientFill(type, 
			                            colors1,
			                            alphas1,
			                            ratios, 
			                            matrix, 
			                            spreadMethod, 
			                            interp, 
			                            focalPtRatio);
			                            
			verlauf.graphics.drawEllipse(0, 0, 200, 200);
			
			
			
			
			
			


			var farbe:Shape = new Shape;
			farbe.graphics.beginGradientFill(type, 
			                            colors2,
			                            alphas2,
			                            ratios, 
			                            matrix, 
			                            spreadMethod, 
			                            interp, 
			                            focalPtRatio);
			                            
			farbe.graphics.drawEllipse(0, 0, 200, 200);
			
			
			
			
			
			
			
			
			addChild(farbe);
			addChild(verlauf);
			




		}
		
		



		
		
		

	}
}