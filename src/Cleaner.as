package
{
	import flash.display.Sprite;

	public class Cleaner
	{
		
		public static function removeChildren(anySprite:Sprite):void
		{
			var count:int = anySprite.numChildren;
			for(var i:int = 0; i < count; i++)
			{
				//trace("at i: "+i);
				anySprite.removeChildAt(0);
			}		
		}
	}
}