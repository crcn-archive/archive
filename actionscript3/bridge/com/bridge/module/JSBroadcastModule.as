/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/
 
package com.bridge.module
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	
	import flash.external.ExternalInterface;
	
	
	/**
	 * broadcasts an "execute" function so that javascript can communicate with bridge
	 * 
	 */
	public class JSBroadcastModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
		private var _catch:BridgeNode;
		
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
			
			
			try
			{
				ExternalInterface.addCallback("execute",execute);
			}catch(e:*)
			{
				
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
		 * executes Actionscript code
		 * @param value the script
		 */
		
		public function execute(value:String):*
		{
			return _catch.nodeLibrary.valueParser.getSegmentParser().eval(value,true);
		}
		
		/**
		 */
		
		private function init():void
		{
			_catch = evaluatedNode;
		}
		
		

	}
}