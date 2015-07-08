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

package com.bridge.ui.utils.tween.handle
{

	public function colorTweenHandler(item:Object, property:String, currentTime:Number, start:Object, stop:Object, duration:Number, easingFunction:Function):void
	{
		var newColor:Object;

		if(start is Array)
		{
			newColor = new Array();
			
			for(var i:int = 0; i < start.length; i++)
			{
				newColor[ i ] = getNewColor(currentTime, start[i], stop[i], duration, easingFunction);
			}
		}
		else
		{
			newColor = getNewColor(currentTime,start[i],stop[i],duration,easingFunction);
		}
		//trace(nr.toString(16));
		item[ property ] = newColor;

		
		
	}
	
}


function getNewColor(currentTime:Number, start:Number, stop:Number, duration:Number, easingFunction:Function):Number
{
	
	function setChannel(start:Number, stop:Number):Number
	{
		var change:Number = stop - start;
			
		var e:Number     = easingFunction(currentTime, start, change, duration);
		
		return e;
	}
	
	var or:Number = ((start >> 16) & 0xff);
	var og:Number = ((start >> 8)  & 0xff);
	var ob:Number = (start         & 0xff);
	
	var sr:Number = ((stop >> 16) & 0xff);
	var sg:Number = ((stop >> 8)  & 0xff);
	var sb:Number = (stop         & 0xff);
	
	var nr:Number = setChannel(or,sr);
	var ng:Number = setChannel(og,sg);
	var nb:Number = setChannel(ob,sb);
		
	//0 & 255 is the max, and further and the color jumps to a totally different color, we don't want that.
	if(nr > 255) nr = 255;
	if(ng > 255) ng = 255;
	if(nb > 255) nb = 255;
	
	if(nr < 0) nr = 0;
	if(ng < 0) ng = 0;
	if(nb < 0) nb = 0;
	
	var newColor:Number = (nr << 16 | ng << 8 | nb) | nb;

	return newColor;
}


