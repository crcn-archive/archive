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
	import com.bridge.node.*;
	import com.ei.utils.*;
	
	import flash.events.Event;
	
	/**
	 * Loops through a series of nodes and executes them. Use as such:
	 * <br/><br/>
	 * <code>
	 * &lt;[NAMESPACE]:for name="loopName" start="start index" stop="stop index" &gt;
	 * <br/>
	 * &nbsp;&nbsp; //my code
	 * <br/>
	 * &lt;/[NAMESPACE]:for&t;
	 * </code>
	 * 
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * 
	 * <code>
	 * &lt;loop:for name="i" start="0" stop="10"&gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;Image instance:id="myCanvas{i}" source="{images[i]}" />
	 * <br/>
	 * &lt;/loop:for&gt;
	 * </code>
	 * <br/><br/>
	 * 
	 */
	 
	public class LoopModule extends EvaluableModule
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        private var _loopsRunning:Array;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function LoopModule(ns:String = "")
		{
			super(ns);
			
			_loopsRunning = new Array();
			
			nodeEvaluator.addHandler("loop",startLoop);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
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

		private function startLoop():void
		{
			
			if(_loopsRunning.indexOf(evaluatedNode) == -1)
			{
				evaluatedNode.parentNode.pause();
			
				var start:Number	  = Math.round(evaluatedNode.attributes.start);
				var stop:Number       = Math.round(evaluatedNode.attributes.stop);
				var name:String       = evaluatedNode.attributes.name;
			
				_loopsRunning.push(evaluatedNode);
			
				var loop:Loop = new Loop(name,start,stop,evaluatedNode);
				
				loop.addEventListener(Event.COMPLETE,onLoopComplete);
				loop.startLoop();
			}
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function onLoopComplete(event:Event):void
		{
			event.target.removeEventListener(event.type,onLoopComplete);
			
			var targetNode:BridgeNode = event.target.targetNode;
			
			_loopsRunning = ArrayUtils.truncate(_loopsRunning,[_loopsRunning.indexOf(targetNode)]);
			targetNode.parentNode.resume();
			
		}
		
		
		
		
	}
	
	
	
	
}
	import com.bridge.core.EvaluableModule;
	import com.bridge.node.BridgeNode;
	import com.ei.utils.info.ClassInfo;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import com.bridge.events.FMLEvent;
	


	class Loop extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var targetNode:BridgeNode;
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _i:int;
		private var _start:Number;
		private var _stop:Number;
		private var _name:String;
		
		private var _dummy:BridgeNode;
		
		private var _originalStack:Array;
		
		private var _startIndex:int;
		
		private var _end:Boolean;
		
		
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function Loop(name:String,start:Number,stop:Number,node:BridgeNode)
		{
			
			this.targetNode = node;
			this._start 	= start;
			this._stop  	= stop;
			this._name      = name;
			
			
			_originalStack = new Array();
			
			for each(var child:BridgeNode in targetNode.childNodes)
			{
				_originalStack.push(child.clone());
			}
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function startLoop():void
		{
			
			
			if(this._i - this._stop != 0)
			{
				
				//var st:Number = this._i - this._stop;
				
				
				
				//_end = ;
				
				targetNode.nodeLibrary.valueParser.setVariable( this._name , this._i );
				
				
				if( this._start < this._stop )
					this._i++;
				else
					this._i--;
					
					
				this.loopNodes();
				
				
				
			}
			else
			{
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function loopNodes():void
		{
			
			targetNode.addEventListener(FMLEvent.COMPLETE,onNodeComplete);
			
			
			targetNode.restartChildren();
			
			
		}
		
		/**
		 */
		private function onNodeComplete(event:FMLEvent):void
		{
			event.target.removeEventListener(event.type,onNodeComplete);
			
			targetNode.originalChildNodes = new Array();
			targetNode.childNodes 	      = new Array();
			
			
			for each(var child:BridgeNode in _originalStack)
			{
				targetNode.appendChild(child.clone());
			}
			
			startLoop();
		}
		
	}