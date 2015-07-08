package com.bridge.events
{
	import flash.events.Event;
	
	public class FMLEvent extends Event
	{
		//-----------------------------------------------------------
		// 
		//Event Types
		//
		//-----------------------------------------------------------
		
		public static const COMPLETE:String 		 = "fmlComplete";
		public static const PROGRESS:String 		 = "fmlLoading";
		public static const MODULES_EVALUATED:String = "fmlModsEvaled";
		
		//-----------------------------------------------------------
		// 
		//Constructor
		//
		//-----------------------------------------------------------
		
		/**
		*/
		
		public function FMLEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
	}
}