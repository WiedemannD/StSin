package com.ffaerber.view.text
{
	
	public class AssetManager 
	{
		
		[Embed(source="assets/fonts/Arial.otf", fontName="Arial", fontFamily='Arial', mimeType='application/x-font-truetype')]
		public static var Arial:String;
		public static const ARIAL :String = "Arial";
		
		
		/*
	 	[Embed(source="assets/fonts/DIN-Black.otf", fontName="DINBlack", fontFamily='DINBlack', mimeType='application/x-font-truetype')]
   		public static var DINBlack:String;
     	
		[Embed(source="assets/fonts/RotisSemSer.ttf", fontName="RotisSemSer", fontFamily='RotisSemSer', mimeType='application/x-font-truetype')]
		public static const RotisSemSer :Class;
		public static const ROTIS_SEM_SER :String = "RotisSemSer";
     	
   		[Embed(source="assets/fonts/RotisSemSerBol.ttf", fontName="RotisSemSerBol", fontFamily='RotisSemSerBol', mimeType='application/x-font-truetype')]
     	public static var RotisSemSerBol:String;*/
		
		[Embed(source="assets/fonts/AbadiMTCondensedExtraBold.ttf", fontName="AbadiMTCondensedExtraBold", fontFamily='AbadiMTCondensedExtraBold', mimeType='application/x-font-truetype')]
		public static var AbadiMTCondensedExtraBold:String;
		public static const ABADI_CND_EBOLD :String = "AbadiMTCondensedExtraBold";
		
		[Embed(source="assets/fonts/AbadiMTCondensedLight.ttf", fontName="AbadiMTCondensedLight", fontFamily='AbadiMTCondensedLight', mimeType='application/x-font-truetype')]
		public static var AbadiMTCondensedLight:String;
		public static const ABADI_CND_LGT :String = "AbadiMTCondensedLight";
		
		[Embed(source="assets/fonts/stan0763.ttf", fontName="stan0763", fontFamily='stan0763', mimeType='application/x-font-truetype')]
		public static var stan0763:String;
		public static const STAN_0763 :String = "stan0763";
		
		[Embed(source="assets/fonts/stan0756.ttf", fontName="stan0756", fontFamily='stan0756', mimeType='application/x-font-truetype')]
		public static var stan0756:String;
		public static const STAN_0756 :String = "stan0756";
	}
}