
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
	import flash.net.LocalConnection;
	
	public class Debugger
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Static Variables
        //
        //--------------------------------------------------------------------------
        
        private static var _ommit:Array;
        private static var _callback:Function;
        
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
        
        /**
         * sends a print to the call handler
         * 
         * @sinse 		 1.0
         * @param String the error message to place in the debugger
         * @param String the name of the object throwing the error. (used when outputing data)
         */
        
        public static function print(message:String,traceName:String):void
        {
        	
        	if(_ommit == null || _callback == null)
        		return;
        		
        	if(_ommit.indexOf(traceName) == -1)
        		_callback(message,traceName);
        }
        
        /**
         * handles any exceptions that might have occurred in the application that
         * are in a try-catch block
         * 
         * @sinse 		 1.0
         * @param String the error message to place in the debugger
         * @param String the name of the object throwing the error. (used when outputing data)
         */
         
		public static function throwException(message:String,traceName:String):void
		{
			print(message,traceName);
		}
		
		/**
         * sets the callback function for the trace methods
         * 
         * @sinse 		 1.0
         * @param Function the callback function
         * @param String   the ommitted keys not to send to the function
         */
        
        public static function setCallbackFunction(callback:Function,...ommit:Array):void
        {
        	_callback = callback;
        	_ommit 	  = ommit;
        }
        
       /**
		 */
        
        public static function gc():void
		{
			
		}
        

	}
}