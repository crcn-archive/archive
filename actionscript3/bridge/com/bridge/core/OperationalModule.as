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
 
package com.bridge.core
{
	import flash.events.Event;
	
	public class OperationalModule extends EvaluableModule
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        private var _functions:Object;
		private var _result:*;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function OperationalModule(ns:String = "")
		{
			super(ns);
			
			_functions = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * calls a function registered to the Actionscript parser
		 */
		
		public function callFunction(name:String,params:Array):void
		{
			_functions[ name ].apply(_functions[ name ],params);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
         * the result of the function called
		 */
		
		public function set result(value:*):void
		{
			_result = value;
			
			dispatchEvent(new Event(Event.COMPLETE));
			
		}
		
		public function get result():*
		{
			return _result;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * registers a function to be used by the Actionscript parser
		 */
		
		public function registerFunction(name:String,func:Function):void
		{
			_functions[name] = func;
		}
		
		/**
		 * returns true if the function name given is registered
		 */
		public function hasRegisteredFunction(name:String):Boolean
		{
			
			return _functions[name] != null;
		}

	}
}