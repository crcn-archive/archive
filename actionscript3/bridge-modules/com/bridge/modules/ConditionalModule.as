
/******************************************************************
 * IfElseModule - allows conditionals to be used in the Bridge 
 * language	if, else, else if													
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
	
	public class ConditionalModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
		
		//the boolean test result for the condition
        private var _conditionResult:Boolean;

        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Constructor.
		 */
		 
		public function ConditionalModule(ns:String = "")
		{
			super(ns);
			
			//tells the node evaluator to check for any nodes with the node name "check" and the module name
			//proceding it
			nodeEvaluator.addHandler("check",checkCondition);
			
			//check for "else" node names
			nodeEvaluator.addHandler("else",elseCondition);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /*
         * the conditional module handles children only
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
         * called with a node with a node name "check" is found
		 */

		private function checkCondition():void
		{
			
			//pause the node so the children are not parsed
			evaluatedNode.pause();
			
			trace("GO");
			
			//retrieves the condition to be checked and throws it in the previous result
			//incase it does not pass
			_conditionResult = Boolean(evaluatedNode.attributes["if"]);
			
			
			//if the result passes then resume
			if(_conditionResult)
			{
				resume();	
			}
			
			
		}
		
		/**
		 * called when a node name "else" is encountered
		 */
		
		private function elseCondition():void
		{
			
			//pause the node children
			evaluatedNode.pause();
			
			//check to see if the else statement is else-if
			var ifExists:String = evaluatedNode.attributes["if"];
			
			
			
			//make sure that the first condition returns false and
			//the new else-if condition returns true
			if(ifExists != null)
			{
				
				//check if the previous condition is false, if it is
				//then repeat the checkCondition step process (recursive)
				if(!_conditionResult)
				{
					checkCondition();
				}	
				
				
				//since an else-if condition was encountered, we don't want
				//to continue to the else condition, otherwise this data may
				//be parsed
				return;
			}	
			
			//passed when if condition failes
			
			if(!_conditionResult)
			{
				resume();
			}
		}
		
		/**
		 * resumes the evaluated nodes
		 */
		
		private function resume():void
		{
			
			
			/*
			
			the nodes are not appended for a few reasons:
			
			1. if there is for instance a listener, and the condition
			appends children to the listener each time it's called, then
			the node length may become large and consume too much memory
			2. children that needs to access a specific node should get 
			the nearest parent. nodes are transparent.
			3. !!!!!!!children that pause the script cannot do so when 
			appended to the parent node!!!!!!!
			*/
			
			evaluatedNode.restartChildren();
			
			
			/*var prevChild:FMLNode = evaluatedNode;
			
			for each(var child:FMLNode in evaluatedNode.childNodes)
			{
				
				evaluatedNode.parentNode.insertAfter(child,prevChild);
				prevChild = child;
			}*/
		}
	}
}