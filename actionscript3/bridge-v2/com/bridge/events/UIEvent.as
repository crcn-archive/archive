package com.bridge.events
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const SKIN_CHANGE:String = "skinChange";
        
        //--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function UIEvent(type:String)
		{
			super(type);
		}

	}
}