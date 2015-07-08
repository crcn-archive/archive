package com.bridgeo.core
{
	import com.hurlant.eval.ast.Void;
	
	public class ObfuscatedName
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _name:String;
		
		private var _names:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ObfuscatedName()
		{
			_name = "_";
			_names = new Object();
		}
		
		/**
		 */
		
		public function add(name:String):String
		{
			_name += "_";
			
			_names[name] = _name;
			
			return _name;
		}
		
		/**
		 */
		public function getNewName(name:String):String
		{
			var ns:* = _names[name];
			
			if(ns is String)
				return ns;
				
			return null;
		}
		
		

	}
}