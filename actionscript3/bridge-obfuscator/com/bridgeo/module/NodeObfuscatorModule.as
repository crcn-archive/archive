package com.bridgeo.module
{
	import com.bridge.core.BridgeModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.NamespaceUtil;
	import com.bridgeo.model.BridgeOModelLocator;
	
	public class NodeObfuscatorModule extends BridgeModule
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
		 
		
		public function NodeObfuscatorModule()
		{
			super("");
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
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function evalNode(node:BridgeNode, property:*=null):void
		{
			if(!node.nodeName)
				return;
				
			var ns:String = NamespaceUtil.getNamespaceIfPresent(node.nodeName);
			
			var nn:String = node.nodeName;
			
			if(ns)
			{
				
				nn = NamespaceUtil.removeNamespace(ns,nn);
				
				var rn1:String = _model.obfuscatedStrings.getNewName(ns);
				
				node.nodeName = rn1+":"+nn;
				
				/*var rn:String = _model.obfuscatedStrings.getNewName(nn);
				
				if(rn)
				{
					//node.nodeName
				}*/
			}
			else
			{
				var rn:String = _model.obfuscatedStrings.getNewName(nn);
				
				if(rn)
				{
					node.nodeName = rn;
				}
			}
			
			
		}

	}
}