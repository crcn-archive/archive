package com.ei.psd2
{
	import flash.events.Event;
	
	public class PSDEvent extends Event
	{
		//-----------------------------------------------------------
		// 
		//Event Types
		//
		//-----------------------------------------------------------
		
		public static const COMPLETE:String = "psdComplete";
		
		//-----------------------------------------------------------
		// 
		//Constructor
		//
		//-----------------------------------------------------------
		
		/**
		*/
		
		public function PSDEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
	}
}