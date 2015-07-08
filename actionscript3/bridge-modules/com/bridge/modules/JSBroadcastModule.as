package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.IBridgeNode;
	
	import flash.external.ExternalInterface;
	
	public class JSBroadcastModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
		private var _catch:IBridgeNode;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function JSBroadcastModule(ns:String = "")
		{
			super(ns);
			
			
			if(ExternalInterface.available)
			{
				ExternalInterface.addCallback("execute",execute);
			}
			this.nodeEvaluator.addHandler("init",init);
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
		
		public function execute(value:String):*
		{
			return _catch.nodeLibrary.valueParser.eval(value,true);
		}
		
		/**
		 */
		
		private function init():void
		{
			_catch = evaluatedNode;
		}
		
		

	}
}