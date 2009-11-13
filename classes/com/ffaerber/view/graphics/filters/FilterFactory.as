package com.ffaerber.view.graphics.filters
{
	
	
	import flash.filters.*;
	

	
	
	public class FilterFactory extends BitmapFilter
	{
		
		
	    public static var BEVEL_FILTER:String = "BevelFilter";
	    private static var BevelFilterConstructor:Class = BevelFilter;
	    
	    public static var BLUR_FILTER:String = "BlurFilter";
	    private static var BlurFilterConstructor:Class = BlurFilter;
	    
	    public static var COLOR_MATRIX_FILTER:String = "ColorMatrixFilter";
	    private static var ColorMatrixFilterConstructor:Class = ColorMatrixFilter;
	    
	    public static var CONVOLUTION_FILTER:String = "ConvolutionFilter";
	    private static var ConvolutionFilterConstructor:Class = ConvolutionFilter;
	    
	    public static var DISPLACEMENT_MAP_FILTER:String = "DisplacementMapFilter";
		private static var DisplacementMapFilterConstructor:Class = DisplacementMapFilter;
	    
	    public static var DROP_SHADOW_FILTER:String = "DropShadowFilter";
	    private static var DropShadowFilterConstructor:Class = DropShadowFilter;
	    
	    public static var GLOW_FILTER:String = "GlowFilter";
	    private static var GlowFilterConstructor:Class = GlowFilter;
	    
	    public static var GRADIENT_BEVEL_FILTER:String = "GradientBevelFilter";
	    private static var GradientBevelFilterConstructor:Class = GradientBevelFilter;
	    
	    public static var GRADIENT_GLOW_FILTER:String = "GradientGlowFilter";
	    private static var GradientGlowFilterConstructor:Class = GradientGlowFilter;
	    
	    
	    
	    
	    public static function createFilter(type:String):BitmapFilter 
	    {
	        return new FilterFactory[type + "Constructor"]();   
	    }
	}
	
	
	
	
	
	

	
	
	
}