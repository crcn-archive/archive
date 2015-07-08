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
	public class StringUtils
	{
		public static function trim(text:String):String
		{
			
			var dest:Array = text.split("\t");
			text  		   = dest.join("");
			dest 		   = text.split("\r");
			text  		   = dest.join("");
			dest 		   = text.split(" ");
			text  		   = dest.join("");
			dest 		   = text.split("\n");
			text  		   = dest.join("");
				
			return text;
		}
		
		
		/**
		 */
		 
		public static function replaceSpecialCharacters(text:String):String
		{
			return new String();
		}
		
		
		public static function charCode(char:String):int
		{
			return char.charCodeAt(0);
		}
		
		/**
		 */
		
		public static function htmlSafeString(value:String):String
		{
			if(!value)
				return value;
				
			var build:String = new String();
			for(var i:int = 0; i < value.length; i++)
			{
				var char:String = value.charAt(i);
				
				if(isVar(char))
				{
					build+= char;	
				}
				else
				{
					build += "&#"+formatString(value.charCodeAt(i))+";";
				}
			}
			
			return build;
		}
		/**
		 */
		
		public static function isAZ(value:String):Boolean
		{
			var code:int;
			
			value = value.toUpperCase();
			
			for(var i:int = 0; i < value.length; i++)
			{
				code = value.charCodeAt(i);
				
				if(!(code > 64 && code < 91))
				{
					return false;
				}
			}
			
			return true;
		}
		
		public static function formatString(str:Object,minLength:int = 4):String
		{
			return ("000000000" + str.toString()).substr(-minLength);
		}
		
		/**
		 */
		
		public static function isVar(value:String):Boolean
		{
			var code:int;
			
			
			value = value.toUpperCase();
			
			for(var i:int = 0; i < value.length; i++)
			{
				code = value.charCodeAt(i);
				
				if(!(code > 64 && code < 91) && !(code > 47 && code < 58)  && code != 95 && code != 36  && code != 64)
				{
					//not A-Z 0-9 _ or $
					return false;
				}
			}
			
			return true;
		}
		

	}
}