


package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	public class VariableModule extends EvaluableModule
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 * Constructor for the Variable Module.
		 */
		 
		public function VariableModule(ns:String = "")
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("variable",addVariable);
			this.nodeEvaluator.addHandler("var",addVariable);
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
		
		private function addVariable():void
		{
			
			var varName:String = evaluatedNode.attributes.name;
			var varValue:String = evaluatedNode.attributes.value;
			
			
			evaluatedNode.addVariable(varName,varValue);
			
		}

	}
}