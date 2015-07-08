/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/

package com.ei.utils
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class BitmapUtils
	{
		/**
		 */
		
		public static function trim(value:BitmapData):Bitmap
		{
			
			
			var newX:Number = 0;
			var newY:Number = 0;
			var newW:Number = 0;
			var newH:Number = 0;
			
			for(var x:int = 0; x < value.width; x++)
			{
				for(var y:int = 0; y < value.height; y++)
				{
					if(value.getPixel(x,y) != 0)
					{
						newW = x;
						break;
					}
				}	
			}
			
			for(y = 0; y < value.height; y++)
			{
				for(x = 0; x < value.width; x++)
				{
					if(value.getPixel(x,y) != 0)
					{
						newH = y;
						break;
					}
				}
			}
			
			
			for(x= value.width; x >= 0; x--)
			{
				for(y = value.height; y >= 0; y--)
				{
					if(value.getPixel(x,y) != 0)
					{
						newX = x;
						break;
					}
				}
			}
			
			for(y = value.height; y >= 0; y--)
			{
				for(x = value.width; x >= 0; x--)
				{
					if(value.getPixel(x,y) != 0)
					{
						newY = y
						break;
					}
				}
			}
			
			

			var nxw:Number = newW-newX+2;
			var nyh:Number = newH-newY+2;
			
			
			
			trace("BitmapUtils::trim nX nY nW nH",newX,newY,newW,newH);
			
			
			var newBitmap:BitmapData = new BitmapData(nxw,nyh,true,0);
			
			
			trace(new Rectangle(newX,newY,newW,newH));
			
			newBitmap.copyPixels(value,new Rectangle(newX,newY,newW+2,newH+2),new Point());
			
			/*for(x = newX; x < newW; x++)
			{
				for(y = newY; y < newH; y++)
				{
					newBitmap.setPixel32(x-newX,y-newY,value.getPixel32(x,y));
				}
			}*/
			
			var holder:Bitmap = new Bitmap(newBitmap);
			
			holder.x = newX;
			holder.y = newY;
			
			return holder;
		}

	}
}