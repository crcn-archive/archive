package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.ei.parse.*;
	
	import flash.utils.getDefinitionByName;
	
	public class ParseModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ParseModule(ns:String = "")
		{
			super(ns);

			nodeEvaluator.addHandler("addParser",addParser);
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

		private function addParser():void
		{

			var source:String   = evaluatedNode.attributes.source;
			var funcName:String = evaluatedNode.attributes.pattern;
			
			var cls:Class = getDefinitionByName(source) as Class;
			
			var parseInst:IParser = new cls();
			
			if(funcName)
			{
				
			//	parseInst = new FunctionDefiner(parseInst,funcName);
			}

			//evaluatedNode.stringEvaluator.addParser(IParseFilterable(parseInst));
			
		}
	}
}