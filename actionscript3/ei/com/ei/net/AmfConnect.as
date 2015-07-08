package com.ei.net
{
	import com.ei.events.AmfEvent;
	import com.ei.net.amf.AmfService;
	import com.ei.utils.Que;
	
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	
	public class AmfConnect extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _step:int;       
        private var _url:String;
        private var _method:Array;
        private var _argsParssed:Array;
        private var _isConnected:Boolean;
        private var _responder:Responder;
        
        private var _connection:AmfService
        
        private var _que:Que;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function AmfConnect()
		{
			_method = new Array();
			
			_connection = new AmfService();
			_connection.addEventListener(ResultEvent.RESULT,onResult);
			_connection.addEventListener(FaultEvent.FAULT,onFault);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function connect(url:String):void
		{
			
			_que = new Que(ResultEvent.RESULT,onQue);
			
			_connection.gatewayUrl = url;
			
			_que.setStack([ _connection, _connection ]);
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		/**
		 */
		
		private function onQue(current:AmfService):void
		{
			if(_que.index == 1)
			{
				_connection.doCall("amfphp.DiscoveryService.getServices");
			}
			else
			{
				trace("COMPLETE");
			}
		}
		
		
		/**
		 */
		private function initServices():void
		{
			if(_step == 0)
			{
				this.call("amfphp.DiscoveryService.getServices",_responder);
			}else 
			if(_step <= _method.length)
			{
				this.call("amfphp.DiscoveryService.describeService",_responder,_method[_step-1]["info"]);
			}else
			{
				_isConnected = true;
				dispatchEvent(new AmfEvent(AmfEvent.CONNECT));
			}
		}
		
		/**
		 */
		 
		private function onInitResult(result:Object):void{
			trace("CONNECTED SUCCESFULLY");
			if(_step == 0){
				addServices(result);
            	//once it's all done recall initService to find the methods
            	_step++;
				initServices();
			}else{
				
				for(var j:String in result[0])
					addMethods(_method[_step-1],  j,  result[0][j]["arguments"]);
				
				_step++;
				initServices();
			}
			
		}
		
		//the addMethod function is where the custom method is name
		//EXE      addMethod("MailLetter","Mail.send",["first name","email"]);
		//context: addMethod(class method name,amf command,amf arguments);
		private function addServices(services:Object):void{
			
			var folders:String;
			var serv:Object;
			
			for(var i:uint = 0; i < services.length; i++){
					//this is for files in folders
				if(services[i]["children"])
					serv = services[i]["children"][0];
				else
					serv = services[i];
					
				
			
				if(services["data"])
					folders 	= serv["data"].replace("\\",".");
				else
					folders 	= "";
				
				this[serv["label"]] 			   = new AmfMethodService();
				this[serv["label"]]["command"]  = folders+serv["label"];
				this[serv["label"]]["info"]     = serv;
				
				_method[i] = this[serv["label"]];
            }
		}
		
		/**
		 */
		
		private function addMethods(method:AmfMethodService,func:String,args:Array):void{

			method[func] = function(){
				if(arguments.length != args.length)
					throw new Error("the method requires "+args.length+" arguments, you have supplied "+arguments.length+" arguments");
				else{
					var params:Array = new Array;
					params.push(method["command"]+"."+func);
					params.push(new Responder(method.onResult,method.onFault));
					
					for(var i:uint = 0; i < arguments.length; i++)
						params.push(arguments[i]);

					this.call.apply(null,params);
				}
			}
			
			
		}
		private function onInitFault(result:String):void{
			trace("RES"+result);
		}

	}
}