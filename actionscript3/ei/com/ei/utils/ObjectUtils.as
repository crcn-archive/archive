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
	import flash.utils.*;

	public class ObjectUtils
	{
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public static function concat(... objects:Array):Object
		{
			var newObj:Object;
			
			for(var i:* in objects)
			{
				copy(objects[i],newObj);
			}
			
			return objects;
			
		}
		
		
		/**
		 */
		
		public static function getLength(obj:Object):int
		{
			var length:int = 0;
			for(var i in obj)
			{
				length++;
			}
			
			return length;
		}
		
		/**
		 */
		
		public static function getClass(obj:Object):Class
		{
			if(obj == null)
				return null;
				
			return getDefinitionByName(getQualifiedClassName(obj)) as Class;
		}
		
		/**
		 */
		 
		
		public static function copy(obj1:Object,obj2:Object):void
		{
			for(var i:* in obj1)
			{
				if(getLength(obj1[i]) > 0 && obj2 != null)
				{
					var cls:Class = getClass(obj1[i]);
					obj2[i] = new cls();
					copy(obj1[i],obj2[i]);
				}
				else
				{ 

					obj2[i] = obj1[i];
				}
			}
		}
		
		
		/**
		 */
		
		public static function traceRoute(obj:Object,message = "",tab:String = "\t"):String
		{
			
			var newMessage:String = message;
			
			if(getLength(obj) == 0)
			{
				newMessage = obj.toString();
				trace(newMessage);
			}
				
			for(var i:* in obj)
			{
				if(getLength(obj[i]) > 0)
				{
					trace(tab+i+":"+getLength(obj[i])+"\n");
					newMessage += traceRoute(obj[i],newMessage,tab+"\t");
				}
				else
				{
					
					newMessage = tab+i+":"+obj[i];
					
					trace(newMessage);
					
				}
			}
			
			
			
			return newMessage;
		}
		
		/**
		 */
		
		public static function hasValue(obj:Object,value:Object):Boolean
		{
			for each(var item:Object in obj)
			{
				if(value == item)
					return true;
			}
			
			return false;
		}
	}
}