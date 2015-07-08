package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.ei.eval.RootExpression;
	
	import flash.utils.Dictionary;

	
	public class ScriptModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _compiled:Dictionary;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        
		public function ScriptModule(ns:String = "")
		{
			super(ns);
			
			nodeEvaluator.addHandler("script",addScript);
			_compiled = new Dictionary();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
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
		
		private function addScript():void
		{
			var comp:RootExpression = _compiled[evaluatedNode];
			
			
			//if the script is already compiled, then just re-evaluate the code
			if(comp)
			{
				comp.evaluate();
				return;
			}
			
			

			if(evaluatedNode.hasChildNodes())
			{
				
				var script:String = evaluatedNode.firstChild.nodeValue;
			
				//scripts don't need functions to run so evaluate it
				
				var compiled:RootExpression = evaluatedNode.stringEvaluator.compile(script);
				
				
				_compiled[evaluatedNode] = compiled;
				
				
				compiled.evaluate();
			}
			
		}

	}
}