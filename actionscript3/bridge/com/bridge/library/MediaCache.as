package com.bridge.library
{
	import flash.utils.ByteArray;
	
	public class MediaCache
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private static var _cache:MediaCache;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var saveInfo:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function MediaCache()
		{
			this.saveInfo = new Array();
			
			if(_cache != null)
				throw new Error("only one instance of Media Cache can be instantiated.");
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		public function clear():void
		{
			this.saveInfo = new Array();	
		}
		
        /**
		 */
		 
		public static function getInstance():MediaCache
		{
			if(_cache == null)
				_cache = new MediaCache();
			
			return _cache;
		}
		
		/**
		 */
		
		
		public function addFile(name:String,data:ByteArray):void
		{
			//no duplicate entries are allowed
			for each(var item in saveInfo)
			{
				if(item.name == name)
				{
					item.data = data;
					return;
				}
			}
			
			saveInfo.push(new SafeInfo(name,data));
		}
		
		/**
		 */
		 
		public function concat(data:MediaCache):void
		{
			
			for each(var si:SafeInfo in data.saveInfo)
			{
				if(this.saveInfo.indexOf(si.name) == -1)
					this.saveInfo.push(si);
					
			}
		}
		
		/**
		 */
		public function hasFile(name:String):Boolean
		{
			for each(var item in saveInfo)
			{
				if(item.name == name)
				{
					
					return true;
				}
			}
			
			return false;
		}
		
		/**
		 */
		public function getFile(name:String):ByteArray
		{
			for each(var item in saveInfo)
			{
				if(item.name == name)
				{
					return item.data;
				}
			}
			
			return null;
		}
		
		
	}
}
	import flash.utils.ByteArray;
	

	class SafeInfo
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var name:String;
        public var data:ByteArray;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function SafeInfo(name:String,data:ByteArray):void
		{
			this.name = name;
			this.data = data;
		}
	}
