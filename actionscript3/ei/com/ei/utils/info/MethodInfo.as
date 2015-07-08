package com.ei.utils.info
{
	import flash.utils.getDefinitionByName;
	
	
	
	
	
	internal class MethodInfo
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _info:XML;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function MethodInfo(info:XML)
		{
			_info = info;
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function get paramLength():int
		{
			return _info..parameter.length();
		}
		
		
		/**
		 */
		 
		public function get type():String
		{
			return PropertyType.METHOD;
		}
		
		
		/**
		 */
		 
		public function get returnTypeClass():Class
		{
			var par:* = _info.@returnType;
			if(par == "void")
				return null;
			var def:Class = getDefinitionByName(par) as Class;
			return def;
		}
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function getParamTypeClass(param:int):Class
		{
			var par:* = _info..parameter[ param ].@type;
			var def:Class = getDefinitionByName(par) as Class;
			return def;
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