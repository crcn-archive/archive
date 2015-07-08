/******************************************************************
 * FunctionModule - defines a function for the Bridge language									
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
	import com.bridge.utils.NamespaceUtil;
	import com.ei.utils.info.ClassInfo;
	
	import flash.utils.Dictionary;
	
	public class FunctionModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _definedFunctions:Dictionary;
        private var _functionReturn:Dictionary;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 * Constructor
		 */
		 
		public function FunctionModule(ns:String = "")
		{
			super(ns);
			
			_definedFunctions = new Dictionary();
			_functionReturn   = new Dictionary();
		//	_parser = new SyntaxParser();
			
			nodeEvaluator.addHandler("Function",addFunction);
			nodeEvaluator.addHandler("return",addReturn);
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
		 
		private function addFunction():void
		{
			
			//prevent and child nodes from looking past this node
			evaluatedNode.parentDisabled = true;
			
			evaluatedNode.pause();
			
			//USE INST ID - TEMPORARY
			var funcName:String = evaluatedNode.attributes.name;
			var funcParams:String = evaluatedNode.attributes.params;
			
			var params:Array = new Array();
			
			
			
			if(funcParams)
			{
				//var tokenizedParams:Array = _parser.tokenize(funcParams);
				//params = getVariables(tokenizedParams);
				
			}
			
			var func:Function = 
			
			function(...subParams:Array):*
			{
				
				//get the node that defined the function so it can execute the children each time
				var funcNode:IBridgeNode = _definedFunctions[ this ];
				var returnValue:*;
				
				//parse the variables
				funcNode.stringEvaluator.eval("{"+funcParams+"}"); 


				//define the variables in the parameters
				for(var i:int = 0; i < subParams.length; i++)
				{
					funcNode.addVariable(params[i],subParams[i]);
				}
				
				var nodeClass:Class = ClassInfo.getClass(funcNode);
				for(var i:int = 0; i < funcNode.originalChildNodes.length; i++)
				{
					funcNode.originalChildNodes[i].resetAttributes();
					funcNode.originalChildNodes[i] = new nodeClass(funcNode.originalChildNodes[i]);
					funcNode.originalChildNodes[i].parentNode = funcNode;
					
					
				}
				
				//reset the child nodes so any additional children appended to the function
				//are back where they came from
				//if they aren't restarted, then the function will grow
				funcNode.childNodes = funcNode.originalChildNodes;

				funcNode.restartChildren();
				
				for each(var child:IBridgeNode in funcNode.originalChildNodes)
				{

					if(_functionReturn[ funcNode ])
					{
						returnValue = _functionReturn[ funcNode ];
						_functionReturn[ funcNode ] = null;
						
						break;
					}
				}
				
				

				return returnValue;
			}
			
			//put the function in the dictionary so it cna find the node that defined it
			_definedFunctions[ func ] = evaluatedNode;

			//add the function to the variable list
			evaluatedNode.addVariable(funcName,func);
			
		}
		
		/**
		 */
		
		private function getVariables(params:Array):Array
		{
			var newParams:Array = new Array();
			
			for(var i:int = 0; i < params.length; i++)
			{
				
				if(params[i] == "=")
				{
					//skip the next two params exe
					//$var = 5,$ses = 'test'
					//would truncate to $var,$ses
					//0 s1 s2 3 s4 s5 FINISH
					i+=2; 
				}
				
				if(i >= params.length)
					break;
				
				newParams.push(params[i]);
			}
			
			return newParams;
			
			
		}
		
		/**
		 */
		
		private function addReturn():void
		{
			var value:* = evaluatedNode.attributes.value;
			
			var funcDefined:IBridgeNode = traverseToFunction(evaluatedNode);

			_functionReturn[ funcDefined ] = value;
		}
		
		/**
		 */
		
		private function traverseToFunction(node:IBridgeNode):IBridgeNode
		{
			if(NamespaceUtil.getNamespace(node.nodeName).indexOf("Function") > -1)
			{	
				return node;
			}else
			{
				return traverseToFunction(node.parentNode);
			}
		}
		

	}
}