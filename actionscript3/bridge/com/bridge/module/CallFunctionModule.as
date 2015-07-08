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
	import com.bridge.events.FMLEvent;
	import com.bridge.node.BridgeNode;
	
	
	/**
	 * Calls a function of a particular object. Use as such:
	 * 
	 * <br /><br />
	 * <code>
	 * &lt;[NAMESPACE]:function target="the function"&gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;component /&gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;component /&gt;
	 * <br/>
	 * &lt;/[NAMESPACE]:function&gt;
	 * </code>
	 * <br /><br/>
	 * Example:
	 * <br/><b/>
	 * <code>
	 * &lt;XMLDocument instance:id="xmlNode" /&gt;
	 * <br/>
	 * &lt;call:function target="{xmlNode.parseXML}" /&gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;String value="{#LoadManager:text('script.xml')}" /&gt;
	 * <br/>
	 * &lt;/call:function&gt;
	 * </code>
	 */
	 
	public class CallFunctionModule extends EvaluableModule
	{
		

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CallFunctionModule(ns:String = "")
		{
			super(ns);
			
			
			//the method specific to this module
			nodeEvaluator.addHandler("function",callFunction);
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
         * called when "callFunction" is found in a node name
		 */

		private function callFunction():void
		{
			
			new CallFunction(evaluatedNode);
			trace("CALL");
			
		}
		
	}
}
	import com.bridge.node.BridgeNode;
	import com.bridge.events.FMLEvent;
	import com.bridge.module.component.ComponentModule;
	import com.ei.utils.ObjectUtils;
	


	class CallFunction
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _node:BridgeNode;
		private var _target:Function;
		private var _returnID:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CallFunction(evaluatedNode:BridgeNode)
		{
			_node = evaluatedNode;
			
			_node.addEventListener(FMLEvent.MODULES_EVALUATED,init);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function init(event:FMLEvent):void
		{
			event.target.removeEventListener(event.type,init);
			
			_node.parentNode.pause();
			
			//disable transparency of the node so that the function can use
			//the children as its parameters
			_node.parentDisabled = true;
			
			
			//get the function name wished to be called
			_target = _node.attributes["target"];
			
			//the value to set the return var to
			_returnID = _node.attributes["returnId"];
			
			var childNodes:Array = _node.childNodes;
			
			var lastChild:BridgeNode = childNodes[childNodes.length-1];
			
			_node.addEventListener(FMLEvent.COMPLETE,onLastChildComplete);
			
			//prematurely execute the child nodes so they can be added
			//as parameters to the function
			_node.restartChildren();
			
		}
        /**
		 */
		 
		private function onLastChildComplete(event:FMLEvent):void
		{
			event.target.removeEventListener(event.type,onLastChildComplete);
			
			
			
			//the function parameters
			var methodParameters:Array = new Array();
			
			
			for each(var child:BridgeNode in _node.childNodes)
			{
				
				
				//we are only interested in nodes that have been handled by the component
				//module so leave everything else alone and push anything handled as
				//an object to the funcParams array
				
				var childInstance:Object;
				
				var module:ComponentModule = child.getUsedModule(ComponentModule) as ComponentModule;
				
				
				if(module != null)
				{
					childInstance = module.getInstance(child);
				
					methodParameters.push(childInstance);
				}
				
				
				
				//handle the child nodes
			}
			
			
			
			//call the function
			var returnValue:Object = _target.apply(null,methodParameters);
			
			if(_returnID)
			{
				_node.addVariable(_returnID,returnValue);
			}
			
			_node.parentDisabled = false;
			
			_node.parentNode.resume();
			
			
		}
		
		
	}