package com.bridge.libraries
{
	import com.ei.utils.*;
	
	public class ClassDefinitionLibrary
	{
		private static var _definitions:Object;
		
		
		public static function register(name:String,value:*):void
		{
			
			if(_definitions == null)
			{
				_definitions = new Object();
			}
			
			_definitions[ name ] = value;
		}
		
		public static function getValue(name:String):*
		{
			return _definitions[name];
		}
		
		

	}
}