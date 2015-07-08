package com.bridge.events
{
	import com.bridge.ui.layout.LayoutManager;
	
	import flash.events.Event;
	
	public class LayoutManagerEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const CONSTRAINT_CHECK:String = "has?";
        public static const HAS_CONSTRAINT:String   = "has.";
        public static const REFRESH:String  	    = "refresh";
        
        public var layoutManager:LayoutManager;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function LayoutManagerEvent(type:String,layoutManager:LayoutManager = null)
		{
			super(type);
			
			this.layoutManager = layoutManager;
		}

	}
}