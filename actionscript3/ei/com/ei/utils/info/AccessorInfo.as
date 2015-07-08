package com.ei.utils.info
{
	import flash.utils.describeType;
	
	internal class AccessorInfo
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _instance:Object;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function AccessorInfo(info:XML)
		{
			//_instance = cls;
			//init();
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function get type():String
		{
			return PropertyType.ACCESSOR;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function init():void
		{
			
		}
	}
}