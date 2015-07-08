package com.ei.display.decor
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	
	public function bitmapConvert(target:DisplayObject):Bitmap
	{
		var bd:BitmapData = new BitmapData(target.width,target.height,true,0xFFFFFF);
		bd.draw(target);
		return new Bitmap(bd);
	}
}