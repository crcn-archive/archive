package com.ei.events
{
	import flash.events.Event;
	
	public class TweenEvent extends Event
	{
		//-----------------------------------------------------------
		// 
		// Events
		//
		//-----------------------------------------------------------
		
		public static const START:String	  = "tweenStart";
		public static const TWEENING:String 	  = "tweening";
		public static const COMPLETE:String = "tweenComplete";
		

		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function TweenEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
		
		
	}
}