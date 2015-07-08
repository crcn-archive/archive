package com.ei.events
{
	import flash.events.Event;
	
	public class SimplifyEvent extends Event
	{
		//-----------------------------------------------------------
		// 
		//Event Types
		//
		//-----------------------------------------------------------
		
		public static const FUNCTION_EXECUTED:String = "function_executed";
		public static const CLASS_EXECUTED:String    = "class_executed";
		
		//-----------------------------------------------------------
		// 
		//Constructor
		//
		//-----------------------------------------------------------
		
		/**
		*/
		
		public function SimplifyEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
	}
}