package com.bridge.events
{
	import flash.events.Event;
	
	public class StyleEvent extends Event
	{
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public static const CHANGE:String 	 = "change";
        
        
        
        public var property:String;
        public var value:Object;
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * for listening to specific styles
		 */
		
		public static function wrapAsEvent(style:String):String
		{
			return "STYLE::"+style;
		}
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function StyleEvent(type:String,property:String,value:Object)
		{
			super(type);
			
			this.property = property;
			this.value    = value;
		}

	}
}