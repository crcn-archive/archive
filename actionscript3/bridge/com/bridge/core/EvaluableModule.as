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
 
package com.bridge.core
{
	import com.bridge.node.BridgeNode;
	

	
	public class EvaluableModule extends BridgeModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        /*FIXME:
        
        
        change to an observer
        
        */
        
        //evaluates each node past in testNode and evalNode. if it passes true then
        //the evaluator 
        private var _evaluator:NodeEvaluator;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function EvaluableModule(ns:String = "")
		{
			
			super(ns);

			_evaluator = new NodeEvaluator(this);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

        /**
         * the node evaluator that executes module tasks according to the attributes / node names specified in the node
		 */
		 
		protected function get nodeEvaluator():NodeEvaluator
		{
			return _evaluator;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        override public function testNode(node:BridgeNode):Boolean
        {
        	return _evaluator.testNode(node);
        }
        
        /**
		 */
		
		override public function evalNode(node:BridgeNode,property:* = null):void
		{
			super.evalNode(node,property);
			
			
			_evaluator.evalNode(node,property);
		}
		
		/**
		 */
		
		public function hasHandler(name:String):Boolean
		{
			return nodeEvaluator.hasHandler(name);
		}
		
		
		

	}
}