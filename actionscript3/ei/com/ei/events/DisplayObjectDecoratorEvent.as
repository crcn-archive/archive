package com.ei.events
{
	import com.ei.display.decor2.DisplayObjectDecorator;
	
	import flash.events.Event;
	
	public class DisplayObjectDecoratorEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
		
		public static const DECORATOR_REQUEST:String  = "decoratorRequest";
		public static const DECORATOR_RESPONSE:String = "decoratorResponse";
		public static const REMOVE_RECORATOR:String   = "removeRecorator";
		public static const NEW_DECORATOR:String      = "newDecorator";
		//public static const CHILD_ADDED:String        = "childAdded";
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var callback:Function;
		public var decorator:DisplayObjectDecorator;
		public var index:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function DisplayObjectDecoratorEvent(name:String,decorator:DisplayObjectDecorator = null,index:int = -1)
		{
			this.callback  = callback;
			this.decorator = decorator;
			this.index     = index;
			
			super(name);
		}

	}
}