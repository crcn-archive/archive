/******************************************************************
 * CallFunctionModule - calls a function without needing to parse
 * a function using curly brackets {}. This is a faster solution.														
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
	import com.bridge.node.IBridgeNode;
	
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
        
        /*
         * callfunction is only accessible through the node name
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
			//disable transparency of the node so that the function can use
			//the children as its parameters
			evaluatedNode.parentDisabled = true;
			
			
			//get the function name wished to be called
			var functionName:String = evaluatedNode.attributes["name"];
			
			//get the function instance to be called
			var functionInstance:Function = evaluatedNode.getVariable(functionName);
			
			
			//prematurely execute the child nodes so they can be added
			//as parameters to the function
			evaluatedNode.restartChildren();
			
			
			//the function parameters
			var methodParameters:Array;
			
			for each(var child:IBridgeNode in evaluatedNode.childNodes)
			{
				
				//we are only interested in nodes that have been handled by the component
				//module so leave everything else alone and push anything handled as
				//an object to the funcParams array
				
				
				/*
				
				var childInstance:Object;
				
				var module:BridgeModule = child.getModule(ComponentModule);
				
				if(module != null)
				{
					childInstance = module.getInstance();
					
					methodParameters.push(childInstance);
				}
				
				
				
				*/
				//handle the child nodes
			}
			
			
			//call the function
			functionInstance.apply(null,methodParameters);
		}
	}
}