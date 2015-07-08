package com.ei.events
{
	import flash.events.Event;
	
	public class DragEvent extends Event
	{
		//-----------------------------------------------------------
		// 
		//Event Types
		//
		//-----------------------------------------------------------
		
		public static const DRAGGING:String = "dragging";
		public static const START:String    = "dragStart";
		public static const STOP:String     = "dragStop";
		
		//-----------------------------------------------------------
		// 
		//Constructor
		//
		//-----------------------------------------------------------
		
		/**
		*/
		
		public function DragEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
	}
}