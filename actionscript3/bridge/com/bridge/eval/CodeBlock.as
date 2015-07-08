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
 
package com.bridge.eval
{

	import com.ei.eval.Parser;
	import com.ei.eval.RootExpression;
	import com.ei.patterns.observer.Notification;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	
	
	public class CodeBlock extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _parser:Parser;
        private var _block:String;
        private var _result:*;
        private var _compiled:RootExpression;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CodeBlock(parser:Parser,block:String)
		{
			_parser = parser;
			_block  = block;
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function get block():String
		{
			return _block;
		}
		
		/**
		 */
		
		public function get result():*
		{
			return _result;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function eval():void
		{
			
			var parseable:String = _block.substr(1,_block.length - 2);
			
			
			_compiled = _parser.compile(parseable);
			
			_compiled.evaluate();
			
			if(_compiled.result == null)
			{
				_compiled.registerObserver(Notification.COMPLETE,onComplete);
				
			}
			else
			{
				complete();
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onComplete(event:Notification):void
		{
			event.target.registerObserver(Notification.COMPLETE,onComplete);
			
			complete();
			
		}
		
		/**
		 */
		
		private function complete():void
		{
			_result = _compiled.lastNode.result;
			
			dispatchEvent(new Event(Event.COMPLETE));
		}

	}
}