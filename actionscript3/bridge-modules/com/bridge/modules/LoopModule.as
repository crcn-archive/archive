package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.IBridgeNode;
	import com.ei.utils.*;
	import com.ei.utils.info.ClassInfo;
	
	import flash.utils.Dictionary;
	
	public class LoopModule extends EvaluableModule
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        private var _loopsRunning:Dictionary;

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
			
			//list used to keep track of nested loops
			_loopsRunning = new Dictionary();
			
			
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
			evaluatedNode.pause();
			
			var attrs:Array = trimWhiteSpace(evaluatedNode.attributes["for"]).split(";");
			
			//_variable			= attrs[0].match(/.*?(?==)/).toString();
			var preCond:String  = script(attrs[0]);
			var loopCond:String = script(attrs[1]);
			var change:String   = script(attrs[2]);
			
			evaluatedNode.stringEvaluator.eval(preCond);

			_loopsRunning[evalNode] = [loopCond,change];
			
			//get an instance of evalNode incase there is a nested loop and it changes
			var evalNode:IBridgeNode = evaluatedNode;
			
			while(evalNode.stringEvaluator.eval(loopCond))
			{
	
				//percaution taken incase of nested loops
				loopNodes(evalNode);
				evalNode.stringEvaluator.eval(change);
			}
			
			
			
		}
		
		/**
		 */
		
		private function loopNodes(evalNode:IBridgeNode):void
		{
			//trace(evalNode);
			
			var repVar:String;
			var newChild:IBridgeNode;
			var currChild:IBridgeNode;
			var nodeLength:int = evalNode.childNodes.length;
			
			var prevChild:IBridgeNode = evalNode;
			
			var nodeClass:Class = ClassInfo.getClass(evalNode);
			
			for(var i= 0; i < nodeLength; i++)
			{
				//trace(evalNode.getVariable("$i"));
				
				
				currChild = evalNode.childNodes[ i ];
				//currChild.resetAttributes();
				
				newChild 			= new nodeClass(currChild);
				
				
			//	trace(newChild);
				
				evalNode.parentNode.insertAfter(newChild,prevChild);
				
				
				prevChild = newChild;
				
			}


		}
		
		/**
		 */
		
		private function script(value:String):String
		{
			return "{"+value+"}";
		}
		
	}
}