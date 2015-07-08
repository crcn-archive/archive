package com.ei.utils.info
{
	import flash.utils.describeType;
	
	internal class VariableInfo
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
		 
		public function VariableInfo(info:XML)
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
			return PropertyType.VARIABLE;
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