/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it
 * 
 ******************************************************************/

package com.ei.utils
{
	public function trimWhiteSpace(value:String):String
	{
		var pat:RegExp = /['"].*?['"]|[^\s\n\r]+/gx;
		
		return value.match(pat).join("");
	}
}