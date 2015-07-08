package com.bridge.libraries
{
	import com.ei.utils.*;
	
	public class ObjectLibrary
	{
		
		private static const CLASSDEF_NAMESPACE:String = "objectLibrary::";
		
		public static function register(name:String,value:*):void
		{
			Broadcast.register(CLASSDEF_NAMESPACE+name,value);
		}
		
		public static function getValue(name:String):*
		{
			return Broadcast.getValue(CLASSDEF_NAMESPACE+name);
		}
		
		

	}
}