package com.ei.events
{
	import flash.events.Event;
	
	public class LoaderListEvent extends Event
	{
		//-----------------------------------------------------------
		// 
		//Event Types
		//
		//-----------------------------------------------------------
		
		public static const COMPLETE:String = "loaderListComplete";
		public static const PROGRESS:String = "loaderListLoading";
		
		//-----------------------------------------------------------
		// 
		//Constructor
		//
		//-----------------------------------------------------------
		
		/**
		*/
		
		public function LoaderListEvent(type:String,bubbles:Boolean = false,cancelable:Boolean = false)
		{
			super(type,bubbles,cancelable);
		}
	}
}