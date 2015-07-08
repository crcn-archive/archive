package com.bridgeo.model
{
	import com.adobe.cairngorm.model.IModelLocator;
	import com.bridge.node.BridgeNodeLibrary;
	import com.bridgeo.core.BridgeOutput;
	import com.bridgeo.core.ObfuscatedName;
	import com.bridgeo.module.*;
	
	
	[Bindable]
	public class BridgeOModelLocator implements IModelLocator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private static var _model:BridgeOModelLocator;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BridgeOModelLocator()
		{
			if(_model)
			{
				throw new Error("only one instance of BridgeOModel can be instantiated");
				
				
			}
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function getInstance():BridgeOModelLocator
		{
			if(!_model)
			{
				_model = new BridgeOModelLocator();
				
				_model.bridgeLibrary = new BridgeNodeLibrary();
				_model.bridgeLibrary.registerModule(new XMLNSOModule("xmlns"));
				_model.bridgeLibrary.registerModule(new NodeObfuscatorModule());
				_model.bridgeLibrary.registerModule(new ClassDefOModule());
			}
			return _model;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		public var outputDir:String;
        public var coreScript:String;
        public var coreScriptPath:String;
        public var scriptList:Array = new Array();
        public var bridgeLibrary:BridgeNodeLibrary;
        
        public var output:BridgeOutput = new BridgeOutput();
        
        public var obfuscatedStrings:ObfuscatedName = new ObfuscatedName();

	}
}