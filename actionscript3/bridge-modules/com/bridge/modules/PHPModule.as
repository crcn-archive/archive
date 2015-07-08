package com.bridge.modules
{
	import com.bridge.core.ModuleType;
	import com.bridge.core.OperationalModule;
	import com.bridge.utils.NamespaceUtil;
	import com.ei.events.*;
	import com.ei.net.*;
	
	import flash.utils.Dictionary;
	
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class PHPModule extends OperationalModule
	{
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
      
        private var _connection:AmfService2;
        private var _runningConnections:Dictionary;
        private var _results:Dictionary;
        private var _nsu:NamespaceUtil;
        
        //TEMPORARY
        private var PHP_METHOD_PATTERN:RegExp = /[\w:.]+\( ([^()]|(?R))* \)/gx;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function PHPModule(ns:String = "")
		{
			
			super(ns);

			nodeEvaluator.addHandler("service",setServices);
			
			
			_connection = new AmfService2();
			_connection.addEventListener(ResultEvent.RESULT,onResult);
			_connection.addEventListener(FaultEvent.FAULT,onFault);
			
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
		 * return true for any checks since we won't know unless we connect to the database
		 */
		
		override public function hasHandler(name:String):Boolean
		{
			return true;
		}
		
		/**
		 */
		
		override public function callFunction(name:String, parameters:Array):void
		{
			
			_connection.doCall(name,parameters);
		}
		

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */

		private function setServices():void
		{
			
			var gateway:String = evaluatedNode.attributes.gateway;
			
			if(gateway)
			{
				_connection.gateway = gateway;
			}
			
			
		}
	
		/**
		 */
		
		private function handleCommand():void
		{
			
			var hasNS:Boolean = NamespaceUtil.hasNamespace(this.moduleNamespace,evaluatedNode.nodeName);
			
			handleNodeCommand();
		}
		
		/**
		 */
		
		private function handleNodeCommand():void
		{
			var func:String = NamespaceUtil.removeNamespace(this.moduleNamespace,evaluatedNode.nodeName);
			
			
			
			var attrs:Object = evaluatedNode.attributes;
			
			var funcInst:Function;
			
			
			var dummyObject:Object = new Object();
			
			for(var method:String in attrs)
			{

				funcInst = _connection[func][method];
				funcInst.apply(null,attrs[method]);
				
			}	
		}
		
		
		
		/**
		 */
		 
		private function onResult(event:ResultEvent):void
		{
			_connection.removeEventListener(AmfEvent.RESULT,onResult);
			
			result = event.result;
		}
		
		/**
		 */
		
		private function onFault(event:FaultEvent):void
		{
			trace(event);
		}
	}
}