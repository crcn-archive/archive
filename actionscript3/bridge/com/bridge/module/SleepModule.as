/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/
 
package com.bridge.module
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	
	/**
	 * Pauses the current node for a duration of time duriing execution. Use it as such:
	 * 
	 * <br/><br/>
	 * 
	 * <code>
	 * &lt;[SLEEP NAMESPACE]:sleep time="1000" /&gt;
	 * </code>
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * <code>
	 * &lt;do:sleep time="1000" /&gt;
	 * </code>
	 */
	 
	public class SleepModule extends EvaluableModule
	{
		
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
			new SleepInst(evaluatedNode);
			
		}
		
		

	}
}
	import com.bridge.node.BridgeNode;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	

	class SleepInst
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _node:BridgeNode;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SleepInst(node:BridgeNode)
		{
			_node = node;
			
			_node.parentNode.pause();
			
			
			var time:String = node.attributes.time;
			
			var timer:Timer = new Timer(Number(time),1);
			
			
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			timer.start();
			
			
		
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		private function onTimer(event:TimerEvent):void
		{
			event.target.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			
			_node.parentNode.resume();
			
		}
	}