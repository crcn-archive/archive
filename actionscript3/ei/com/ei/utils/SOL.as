
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
	import flash.net.SharedObject;
	
	import mx.utils.Base64Encoder;
	
	public class SOL
	{
		
		public static function destroyAll():void
		{
			//destroys all shared objects saved
		}
		
		public static function save(dir:String,args:Object):Boolean
		{
			
			//if an exception is caught then the shared object write access
			//has been denied	
			try
			{
				trace(getSafeDir(dir));
				
				//get the directory the shared object is saved in
				var data:SharedObject = SharedObject.getLocal(getSafeDir(dir),"/");
				
				//save the data to the shared object
				for(var i:String in args)
				{
					data.data[i] = args[i];
				}
				
				
				
				data.flush();
				
			}catch(e:*)
			{
				remove(dir,args);
				
				return false;
			}
			
			
			return true;
			
		}
		
		/**
		 */
		
		
		
		public static function remove(dir:String,...fileNames:Array):Boolean
		{
			
			try
			{
				
				//removes a shared object on the local machine
				var data:SharedObject = SharedObject.getLocal(getSafeDir(dir),"/");
				
				trace(data);
				
				//delete each key on the chared object
				for each(var i:String in fileNames)
				{
					delete data.data[i];
				}
				
				data.flush();
			}catch(e:*)
			{
				return false;
			}	
			
			return true;
		}
		
		/**
		 */

		public static function open(dir:String,args:String = null):Object
		{
			try{
				var data:SharedObject = SharedObject.getLocal(getSafeDir(dir),"/");
				var result:Object = new Object;
				
				if(ObjectUtils.getLength(data.data) == 0)
					return null;
				
				if(args != null)
					return data[args];
				else{
					for(var i:String in data.data)
						result[i] = data.data[i];
					
					return result;
				}
			}catch(e:*){}
			return null;
		}//func
		
		/**
		 */
		
		
		public static function openAsArray(dir:String,args:String = null):Array{
			try{
				var data:SharedObject = SharedObject.getLocal(getSafeDir(dir),"/");
				var result:Array = new Array;
				
				if(args != null)
					return data[args];
				else{
					var ct:uint = 0;
					for(var i:String in data.data){
						
						result[ct] = {file:i,data:data.data[i]};
						ct++;
					}
					
					return result;
				}
			}catch(e:*){}
			return new Array;
		}
		
		
		/**
		 */
		
		public static function getSafeDir(name:String):String
		{
			var enc:Base64Encoder = new Base64Encoder();
			enc.encode(name);
			
			
			return enc.flush();
		}
	}
}