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
	
	import flash.events.EventDispatcher;
	
	public class BridgeModule extends EventDispatcher implements IBridgeModule
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
       	
       	//the namespace is what's needed in order for ht ebridge document to
       	//pass the values to the correct module. This is mainly for speed so
       	//if a node has a namespace inst: assigned to inst. no loops will be
       	//needed to search for the correct module. modules without namespaces
       	//however will be thrown in a loop
        private var _namespace:String;
        
        //the node evaluated once something has been validated for a specific
        //module
        private var _nodeEvaluated:BridgeNode;
        
        private var _propertyEvaluated:String;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * The Constructor
         * 
         * @param moduleNamespace The namespace assigned to the module to be used 
         * throughout an XML document
		 */
		 
		public function BridgeModule(moduleNamespace:String)
		{
			_namespace = moduleNamespace;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
         * Each module has its own namespace and the FMLNode directs each node
         * according to the namespace given to each of the modules
		 */
		
		
        public function get moduleNamespace():String
        {
        	return _namespace;	
        }
        
        /**
         * reduces the number of processes per module. this returns what the module
         * can accept
		 */
		
		public function get moduleType():Array
		{
			//throw new Error("please specify the module type");
			return [];
		}
		
		/**
		 * returns the node passed in evalNode
		 */
		
		public function get evaluatedNode():BridgeNode
		{
			return _nodeEvaluated;
		}
		
		/**
		 */
		
		public function get evaluatedProperty():String
		{
			return _propertyEvaluated;
		}
		

		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
         * tests if the node is compatible with the module
		 */
		 
        public function testNode(node:BridgeNode):Boolean
      	{
      		return false;
      	}
      	
      	/**
      	 * evaluates the node
      	 * @param node the node being evaluated
      	 * @param property the current attribute being evaluated 
		 */
		
		public function evalNode(node:BridgeNode,property:* = null):void
		{
			_propertyEvaluated  = property;
			_nodeEvaluated 		= node;
			
		}

	}
}