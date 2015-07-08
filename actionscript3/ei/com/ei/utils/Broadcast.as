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
	public class Broadcast
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
		private static var _list:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Static Methods
        //
        //--------------------------------------------------------------------------
        
		/**
		 * registers an object to a list so that it can be retrieved
		 * throughout the application
		 */
		 
		public static function register(name:String,obj:*):void
		{
			
			//if the list is null then start the Singleton
			if(_list == null)
			{
				_list = new Object();
			}
			
			//grab an instance of the value 
			var instance:String = _list[ name ];
			
			//if the instance exists then let the developer know the key is there, but allow the overwrite
			if(instance != null)
			{
				trace("WARNING: "+name+" has been overwritten in broadcast!");
			}
			
			//add the new instance to the list
			_list[ name ] = obj;
			
		}
		
		/**
		 * retrieves objects in the static list
		 */
		 
		public static function getValue(name:String):*
		{
			if(!_list)
				return null;
				
			return _list[ name ];
		}
	}
}