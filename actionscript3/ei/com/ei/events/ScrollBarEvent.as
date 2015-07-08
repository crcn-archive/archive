package com.ei.events
{
	import flash.events.Event;
	
	public class ScrollBarEvent extends Event
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
		
		public static const SCROLLING:String   = "scrolling";
		public static const VISIBILITY:String  = "scrollVisibility";
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function ScrollBarEvent(event:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(event,bubbles,cancelable);

		}
	}
}