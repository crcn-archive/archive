package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	import flash.display.DisplayObject;
	
	public class RemoveChildModule extends EvaluableModule
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function RemoveChildModule(ns:String = "")
		{
			super(ns);
			nodeEvaluator.addHandler("removeChild",removeChild);
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
        // Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function removeChild():void
		{
			var target:DisplayObject = evaluatedNode.attributes.target;
			
			target.parent.removeChild(target);
		}

	}
}