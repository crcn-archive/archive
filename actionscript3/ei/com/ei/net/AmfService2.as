package com.ei.net
{
	import com.ei.utils.ObjectUtils;
	
	import flash.events.EventDispatcher;
	import flash.net.NetConnection;
	import flash.net.Responder;
	
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class AmfService2 extends EventDispatcher 
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _connection:NetConnection;
        private var _gateway:String;
        private var _responders:Responder;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function AmfService2()
		{
			_connection = new NetConnection();
			
			_responders = new Responder(onResult,onFault);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function set gateway(value:String):void
		{
			_gateway = value;

			_connection.connect(_gateway);
		}
		
		public function get gateway():String
		{
			return _gateway;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------

		/**
		 */
		
		public function doCall(method:String,params:Array):void
		{
			var parms:Array = new Array();
			parms.push(method);
			parms.push(_responders);
			//if(params.length > 0)
			parms = parms.concat(params);
			
			_connection.call.apply(_connection.call,parms);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onResult(data:Object):void
		{
			dispatchEvent(new ResultEvent(ResultEvent.RESULT,false,false,data));
		}
		
		/**
		 */
		
		private function onFault(info:Object):void
		{
			
			var fault:Fault = new Fault(info.code,info.level,info.description);
			
			dispatchEvent(new FaultEvent(FaultEvent.FAULT,false,true,fault));
			
		}
	}
}