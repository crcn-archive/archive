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
	import com.bridge.utils.NamespaceUtil;
	
	
	internal class NodeEvaluator implements IBridgeModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        public var _handlers:Object;
        private var _target:BridgeModule;
        private var _targetNS:String;
        
        //used so any modules don't have to loop through anything to find what was found
        private var _found:String;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * The Constructor
         * @param target the target Bridge Module
		 */
		 
		public function NodeEvaluator(target:BridgeModule)
		{
			_target   = target;
			_targetNS = target.moduleNamespace;
			_handlers = new Object();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 * returns the target Bridge Module
		 */
		
		public function set target(value:BridgeModule):void
		{
			_target = value;
		}
		
		public function get target():BridgeModule
		{
			return _target;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
         */
        
        public function get foundProperty():String
        {
        	return _found;
        }
        
        /**
         * adds a handler for the Bridge Module. This can be either an attribute node or a node name
		 */
		
		public function addHandler(handleName:String,handler:Function):void
		{
			
			_handlers[ NamespaceUtil.addNamespace(_targetNS,handleName) ] = handler;
		}
		
		
		/**
		 * returns true if a attribure/node name handler exists
		 */
		
		public function hasHandler(name:String):Boolean
		{
			return Boolean(_handlers[NamespaceUtil.addNamespace(_targetNS,name)]);
		}
		
		/**
		 * tests a node if it has a handleable component
		 */
		
		public function testNode(node:BridgeNode):Boolean
		{

			//if the node name is a handler
			if(_handlers[ node.nodeName ]) return true;
			
			
			
			
			//check the attribute names
			for(var key:String in node.attributes)
			{
				if(_handlers[ key ]) 
					return true;
					
				//check the attribute values
				for(var handler:String in _handlers)
				{
					if(node.attributes[ key ].toString().indexOf(handler) > -1)
						return true;
				}
			}
			
			return false;
		}
		
		/**
		 * evaluates a node, and sends any tested attributes / node names to their rightfull callback function
		 */
		
		public function evalNode(node:BridgeNode,property:* = null):void
		{
			
			evalIndNode(property);
			
			
			
			return;
			
			if(_target.moduleType.indexOf(ModuleType.NODE_NAME) > -1)
				evalIndNode(node.nodeName);
			
			for(var key:String in node.attributes)
			{
				if(_target.moduleType.indexOf(ModuleType.PROPERTY_NAME) > -1)
					evalIndNode(key);
					
				//if(_target.moduleType.indexOf(ModuleType.VALUE) > -1)
				//	evalPropertyValue(node.attributes[ key ]);
			}
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		 
        private function evalIndNode(node:String):void
        {
        	
        	
			//trace("GT",node);
        	
        	if(_handlers[ node ])
        	{
        		_found = node;
        		
        		
        		//the function is a string because the target can be dynamically changed
        		
        		//var func:Function = _target::evaluableMethod[_handlers[ node ] ];
        		_handlers[node]();
        	}
        }
		
		/**
		 */
		 
		private function evalPropertyValue(propertyValue:String):void
		{
			
			
			//check the attribute values
			for(var handler:String in _handlers)
			{
				if(propertyValue.indexOf(handler) > -1)
				{
					
					_found = handler;
					
					_handlers[ handler ]();
				}
			}

		
			
		}
		
	}
}