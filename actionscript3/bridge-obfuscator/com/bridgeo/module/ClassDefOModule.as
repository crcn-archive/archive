package com.bridgeo.module
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	import com.bridgeo.model.BridgeOModelLocator;
	
	public class ClassDefOModule extends EvaluableModule
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
		 
		
		public function ClassDefOModule()
		{
			super();
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
				
			var ns:Array = node.nodeName.split(":");
			
			var prop:String = ns[ns.length-1];
			
			if(prop == "classDefinition")
			{
				var nRegex:RegExp  = /\w+$/;
				
				var match:Array = node.originalAttributes.source.match(nRegex)
				
				if(!match)
					return;
					
				var clsName:String = match[0];
				
				
				if(node.originalAttributes.name)
					clsName = node.originalAttributes.name;
				
				
				node.originalAttributes.name = _model.obfuscatedStrings.add(clsName);
			}
		}

	}
}