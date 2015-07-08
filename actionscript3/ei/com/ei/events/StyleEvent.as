package com.ei.events
{
	import com.ei.utils.style.template.Style;
	import flash.events.Event;
	
	public class StyleEvent extends Event
	{
		//-----------------------------------------------------------
		// 
		// Public Variables
		//
		//-----------------------------------------------------------
		
		public static var CHANGE:String = "styleChange";
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function StyleEvent(event:String)
		{
			super(event);

		}
	}
}