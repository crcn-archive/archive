package com.bridgeo.module
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.NamespaceUtil;
	import com.bridgeo.model.BridgeOModelLocator;
	
	public class XMLNSOModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable]
		private var _model:BridgeOModelLocator = BridgeOModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function XMLNSOModule(ns:String)
		{
			super(ns);
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
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function evalNode(node:BridgeNode, property:*=null):void
		{
			if(NamespaceUtil.getNamespace(property) == this.moduleNamespace)
			{
				var ns:String = NamespaceUtil.removeNamespace(this.moduleNamespace,property);
				
				if(ns.length > 0)
				{
					var newName:String = _model.obfuscatedStrings.add(ns);
					
					node.originalAttributes[this.moduleNamespace+":"+newName] = node.originalAttributes[property];
					delete node.originalAttributes[property];
				}
			}
			
		}

	}
}