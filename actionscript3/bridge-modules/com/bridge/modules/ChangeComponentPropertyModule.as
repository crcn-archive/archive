package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.IBridgeNode;
	import com.ei.utils.ClassDefinition;
	import com.ei.utils.simpleObject.SimpleObject;
	
	public class ChangeComponentPropertyModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ChangeComponentPropertyModule(ns:String = "")
		{
			super(ns);
			
			nodeEvaluator.addHandler("property",changeProperty);
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
		
		private function changeProperty():void
		{
			
			
			var target:Object   = evaluatedNode.attributes.target;
			
			trace("ComponentPropertyModule",target,evaluatedNode);
			
			if(target == null)
				return;
				
			
			var def:ClassDefinition = new ClassDefinition(target);
			var sim:SimpleObject    = new SimpleObject(def);
			
			for(var i:String in evaluatedNode.attributes)
			{
				if(i != "target")
				{
					sim.setProperty(i,evaluatedNode.attributes[i]);
				}
			}
			
			
			
			
		
			
		}
	}
}