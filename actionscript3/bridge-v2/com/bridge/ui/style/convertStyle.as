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

package com.bridge.ui.style
{
	import com.ei.utils.ObjectUtils;
	
	public function convertStyle(template:Class,currentStyle:Object):*
	{
		
		var newStyle:* = new template(); 	
		
		
		
		if(template == ObjectUtils.getClass(currentStyle))
			return currentStyle;
			
		var newValue:*;
		
		if(template == Array)
		{
			newValue = [currentStyle];
		}
		else if(template == Number)
		{
			newValue = new Number(currentStyle);
		}
		else
		{
			newValue = currentStyle;
		}

		return newValue;
		
		
		return newStyle;
	}
}