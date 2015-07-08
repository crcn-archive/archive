package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	public class NodeInstanceModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function NodeInstanceModule(ns:String)
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("id",setID);
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
			return [ModuleType.PROPERTY_NAME];
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function setID():void
		{
			
			var name:String = evaluatedNode.attributes[evaluatedProperty];
			
			evaluatedNode.nodeLibrary.valueParser.setVariable(name,evaluatedNode);
		}
		

	}
}