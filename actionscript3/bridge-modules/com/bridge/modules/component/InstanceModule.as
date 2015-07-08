package com.bridge.modules.component
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.events.FMLEvent;
	import com.bridge.node.IBridgeNode;
	import com.bridge.utils.*;
	import com.ei.utils.simpleObject.*;
	
	
	public class InstanceModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        private const INSTANCE_REGEX:RegExp = /(?<=\().*?(?=\))/xi;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		 
		public function InstanceModule(ns:String = "")
		{
			super(ns);

			nodeEvaluator.addHandler("id",setInstanceId);
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
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         */
        
        //private function getInstance
        /**
		 */
		
		private function setInstanceId():void
		{
			
			trace("GO");
			
			evaluatedNode.addEventListener(FMLEvent.MODULES_EVALUATED,onNodeComplete);	
		}
		
		/**
		 */
		
		private function onNodeComplete(event:FMLEvent):void
		{
			event.target.removeEventListener(FMLEvent.COMPLETE,onNodeComplete);

			
			
			var idAttr:String = NamespaceUtil.addNamespace(this.moduleNamespace,"id");
			
			
			var id:String = event.target.originalAttributes[ idAttr ];

			
			var compModule:ComponentModule = IBridgeNode(event.target).getUsedModule(ComponentModule) as ComponentModule;
			
			
			
			
			if(!compModule)
				return;
				
			
			var nodeInstance:* = compModule.getInstance(IBridgeNode(event.target));
			
			
			event.target.addVariable(id ,nodeInstance);

		}

	}
}