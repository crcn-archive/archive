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
	import mx.containers.Canvas;
	
	public function convertType(knownType:Object,unknownType:Object):*
	{
		

		if(ObjectUtils.getClass(knownType) == ObjectUtils.getClass(unknownType))
			return unknownType;
			
		var newValue:*;
		
		if(knownType is Array)
		{
			newValue = [unknownType];
		}
		else if(knownType is Number)
		{
			newValue = new Number(unknownType);
		}
		else
		{
			newValue = unknownType;
		}

		return newValue;
	}
}