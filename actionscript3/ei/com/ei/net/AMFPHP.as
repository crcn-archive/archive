/*************************************************************
* The basic idea for this class is to implement methods     *
* as they would be in a regular class, hence, it's dynamic  *
* it's really only here to make the code more elligant  	*
*															*
* this particular class needs the Commands PHP file in the  *
* service folder for amfPHP, this will allow the script to  *
* pull all available methods in the script so the amount of *
* code used is minimal                                      *
*************************************************************/



package com.ei.net
{
	import com.ei.events.AmfEvent;
	import com.ei.utils.*;
	
	import flash.events.EventDispatcher;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.ObjectEncoding;
	import flash.net.Responder;
	
	dynamic public class AMFPHP extends EventDispatcher
	{
		public var _connection:NetConnection;
		public var _ns:NetStream;
		
		public var _method:Array = new Array;
		public var _argsPassed:Array;
		public var _responder:Responder;
		//the step keeps track of where the AMF protocol is when it initializes
		public var _step:uint;
		public var isConnected:Boolean;
		
		public function AMFPHP(url:String = null){
			
			if(url != null){
				//connects the script to the outside world and stays connected until the object has been deleted
				
				connect(url);
			}
		}
		
		public function connect(url:String):void{
			_connection = new NetConnection();
			
			_connection.objectEncoding = ObjectEncoding.AMF3;
			_connection.addEventListener(NetStatusEvent.NET_STATUS,onNetStatus);
			_connection.connect(url);
			_connection.addEventListener(ProgressEvent.SOCKET_DATA,onProgress);
			_responder = new Responder(onInitResult,onInitFault);
			initServices();
			
		}
		
		private function onProgress(event:ProgressEvent):void
		{
			trace("NET STATUS");
		}
		
		
		
		private function onNetStatus(event:NetStatusEvent):void
		{
			//trace(event);
		}
		
		private function initServices():void{
			
			
			if(_step == 0)
				_connection.call("amfphp.DiscoveryService.getServices",_responder);
			else if(_step <= _method.length)
			{
	
				_connection.call("amfphp.DiscoveryService.describeService",_responder,_method[_step-1]["info"]);
			}
			else{
				isConnected = true;
				
				dispatchEvent(new AmfEvent(AmfEvent.CONNECT));
				
				//trace(_connection.connected);
				//_connection.
				
			}
		}
		
		private function onInitResult(result:Object):void{

			if(_step == 0){
				addServices(result);
            	//once it's all done recall initService to find the methods
            	_step++;
				initServices();
			}else{
				
				for(var j:String in result[0])
				{
					addMethods(_method[_step-1],  j,  result[0][j]["arguments"]);
				}
				
				_step++;
				initServices();
			}
			
		}
		private function onInitFault(result:String):void{
		//	trace(result);
		}
		//the addMethod function is where the custom method is name
		//EXE      addMethod("MailLetter","Mail.send",["first name","email"]);
		//context: addMethod(class method name,amf command,amf arguments);
		private function addServices(services:Object):void
		{	
			var folders:String;
			var serv:Object;
			

			for(var i:uint = 0; i < services.length; i++){
				
					//this is for files in folders
				if(services[i]["children"])
					serv = services[i]["children"][0];
				else
					serv = services[i];
					
				
				if(serv["data"])
					folders 	= serv["data"].replace("/",".");
				else
					folders 	= "";

				this[serv["label"]] 			   = new AmfMethodService();
				this[serv["label"]]["command"]  = folders+serv["label"];
				this[serv["label"]]["info"]     = serv;
				
				_method[i] = this[serv["label"]];
            }
		}
		
		private function addMethods(method:AmfMethodService,func:String,args:Array):void
		{
			method[func] = function(){
				if(arguments.length != args.length)
					throw new Error("the method requires "+args.length+" arguments, you have supplied "+arguments.length+" arguments");
				else{
					var params:Array = new Array;
					params.push(method["command"]+"."+func);
					
					
					params.push(new Responder(method.onResult,method.onFault));
					
					for(var i:uint = 0; i < arguments.length; i++)
						params.push(arguments[i]);
					

					_connection.call.apply(null,params);
				}
			}
			
			
		}

	}
}


