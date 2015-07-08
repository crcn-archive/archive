package com.bridge.modules
{
	import com.bridge.core.BridgeModule;
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.NamespaceUtil;
	
	import flash.external.ExternalInterface;
	import flash.utils.getDefinitionByName;
	
	public class XMLNSModule extends EvaluableModule
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _namespace:String;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function XMLNSModule(ns:String = "")
		{
			super(ns);
		}
		
		//--------------------------------------------------------------------------
   	    //
        // Getters / Setters 
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
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		override public function evalNode(value:BridgeNode,property:* = null):void
		{
			
			var reg:RegExp = new RegExp(moduleNamespace+":(?=[^=]*)");
			
			var moduleNS:String;
			var module:BridgeModule;
			var moduleDef:Class;
			
			if(NamespaceUtil.hasNamespace(moduleNamespace,property))
			{
				moduleNS = NamespaceUtil.removeNamespace(moduleNamespace,property);
				
				
				moduleDef = getDefinitionByName(value.attributes[ property ]) as Class;
				module    = new moduleDef(moduleNS);
				value.addModule(module);
			}

			
		}
		
		
		
		

	}
}