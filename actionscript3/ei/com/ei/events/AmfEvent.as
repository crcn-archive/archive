package com.ei.events
{
	import flash.events.Event;
	
	public class AmfEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
		public static const RESULT:String  = "result";
		public static const FAULT:String   = "fault";
		public static const CONNECT:String = "connect";
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function AmfEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
		
	}
}