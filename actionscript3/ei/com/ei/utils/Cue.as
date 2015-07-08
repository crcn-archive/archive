/******************************************************************
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
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.FileReference;

	public class Cue extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _event:String;
        private var _stack:Array;
        private var _func:Function;
        private var _index:int;
        private var _max:int;
        private var _stop:Boolean;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		public function Cue(event:String,queFunc:Function,maxQues:int = 1)
		{
			
			stop();
			
			_event = event;
			_func  = queFunc;
			_max   = maxQues;

			_stack = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
 
 		/**
		 */
		
		public function get index():int
		{
			return _index;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function start():void
		{
			_stop = false;
			next();
		}
		
		/**
		 */
		
		public function get running():Boolean
		{
			return !_stop;
		}
		
		/**
		 */
		
		public function stop():void
		{
			_stop = true;
		}
		
		
		
		/**
		 */
		
		public function setStack(stack:Array):void
		{
			_stack = stack;
		}
		
		
		/**
		 */
		
		public function push(item:IEventDispatcher):void
		{
			_stack.push(item);
		}
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function next():void
		{
			if(_stop)
				return;
				
				
			
			var current:EventDispatcher = _stack[_index++];
			
			if(current == null)
			{
				_stack = new Array();
				_index = 0;
				dispatchEvent(new Event(Event.COMPLETE));
				return;
			}
	
			current.addEventListener(_event,onEvent);
			_func(current);
			
		}
		/**
		 */
		
		private function onEvent(event:*):void
		{
			event.target.removeEventListener(event.type,onEvent);
			
			
			next();
		}
	}
}