/******************************************************************
 * Sleep Module - pauses the script for a duration of time and then
 * resumes the script													
 *  
 * Author: Craig Condon
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	public class SleepModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		
		//pause can be outside of the node as well, so keep them stored
		private var _storedTimes:Dictionary;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 * Constructor
		 */
		 
		public function SleepModule(ns:String = "")
		{
			super(ns);
			_storedTimes = new Dictionary();
			nodeEvaluator.addHandler("sleep",timeoutScript);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override public function get moduleType():Array
		{
			return [ModuleType.NODE_NAME];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function timeoutScript():void
		{
			var time:String = evaluatedNode.attributes.time;
			
			evaluatedNode.parentNode.pause();
			
			
			var timer:Timer = new Timer(Number(time),1);
			
			_storedTimes[timer] = evaluatedNode;
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			timer.start();
		}
		
		/**
		 */
		
		private function onTimer(event:TimerEvent):void
		{

			event.target.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			
			_storedTimes[event.target].parentNode.resume();
			
			delete _storedTimes[ event.target ];
		}

	}
}