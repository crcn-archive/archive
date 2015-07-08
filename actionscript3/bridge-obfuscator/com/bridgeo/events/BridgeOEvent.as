package com.bridgeo.events
{
	import com.adobe.cairngorm.control.CairngormEvent;
	
	import flash.events.Event;
	
	public class BridgeOEvent extends CairngormEvent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static var LOAD_CORE:String = "loadCore";
        public static var ADD_SCRIPT:String = "addScript";
		public static var OBFUSCATE:String  = "obfuscate";
		public static var SELECT_OUTPUT:String  = "selectOutput";
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BridgeOEvent(type:String)
		{
			super(type);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function clone():Event
		{
			return new BridgeOEvent(type);
		}
	}
}