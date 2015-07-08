package com.bridge.ui.core
{
	public class ObjectProxy
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _functions:Array;
		private var _properties:Object;
		private var _target:Object;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ObjectProxy()
		{
			_properties = new Object();
			_functions  = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function set target(value:Object):void
		{
			_target = value;
			
			for(var prop:String in _properties)
			{
				_target[prop] = _properties[prop];
				
				//delete _properties[prop];
			}
			
			for(var func:Object in _functions)
			{
				_target[func.name].apply(_target,func.rest);
			}
		}
		
		/**
		 */
		public function get target():Object
		{
			return _target;
		}
		
		
		/**
		 */
		public function setProperty(name:String,value:*):void
		{
			if(_target)
			{
				_target[name] = value;
			}
			else
			{
				_properties[name] = value;
			}
		}
		
		/**
		 */
		public function getProperty(name:String):*
		{
			if(_target)
			{
				return _target[name];
			}
			
			return _properties[name];
		}
		
		/**
		 */
		
		public function callProperty(name:String,...rest:Array):Object
		{
			if(_target)
			{
				return _target[name].apply(_target,rest);
			}
			
			_functions.push({name:name,rest:rest});
			
			
			return true;
		}

	}
}