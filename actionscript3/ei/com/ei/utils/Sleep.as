/******************************************************************
 * Sleep - pauses the script for a duration of time														
 *  
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it
 * 
 ******************************************************************/
 

package com.ei.utils
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Sleep
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _callBack:Function;

		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------

		/**
		*/

		public static function timeout(time:int,callBackFunction:Function,...params:Array):void
		{
			var callBack:Function = callBackFunction;
			
			
			var timer:Timer = new Timer(time,1);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimerFinish);
			timer.start();
			
			function onTimerFinish(event:TimerEvent):void
			{
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimerFinish);
				callBack.apply(null,params);
			}
			
		}


	}
}