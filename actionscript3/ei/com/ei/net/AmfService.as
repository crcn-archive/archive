package com.ei.net
{
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.net.ObjectEncoding;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLStream;
	import flash.utils.ByteArray;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import mx.messaging.messages.RemotingMessage;
	import mx.rpc.Fault;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;

	public class AmfService extends EventDispatcher
	{
		public var gatewayUrl:String = "";
		public var traceMessages:Array;
		
		var loader:URLLoader;
		
		var time:Number;
		
		public var diagnostic:Object;
		public var profiling:Object;
		
		public var encoding = ObjectEncoding.AMF3;
		
		public function AmfService()
		{
			loader = new URLLoader();
			loader.addEventListener('complete', readData);
			
			loader.addEventListener(ProgressEvent.SOCKET_DATA,onSocketData);
			
		}
		
		private function onSocketData(event:ProgressEvent):void
		{
			
		}
		
		public function doCall(className, methodName, args)
		{

			diagnostic = {};
			traceMessages = new Array();
			//Create a new HTTP url service
			var urlRequest:URLRequest = new URLRequest();
			urlRequest.url = gatewayUrl;
			urlRequest.contentType = "application/x-amf";
			
			var encodeTime = getTimer();
			var data:ByteArray = createAmfRequest(className, methodName, args);
			diagnostic.encodeTime = getTimer() - encodeTime;
			time = getTimer();
			diagnostic.sentSize = data.position;
			urlRequest.data = data;
			urlRequest.method = URLRequestMethod.POST;
			var h1 = new URLRequestHeader("Content-Type", "application/x-amf");
			//var h2 = new URLRequestHeader("Content-Length", data.length.toString());
			urlRequest.requestHeaders = [h1];
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.load(urlRequest);
		}
		
		function createAmfRequest(className, methodName, args)
		{
			var data:ByteArray = new ByteArray();
			data.objectEncoding = encoding;
			
			//Write the AMF header
			data.writeByte(0x00);
			data.writeByte(0x03);
			
			//Write the service browser header
			data.writeByte(0x00);
			data.writeByte(0x01);
			
			//Write the name
			data.writeByte(0x00);
			data.writeByte(14);
			data.writeUTFBytes("serviceBrowser");
			
			//Write required
			data.writeByte(0x00);
			
			//Write length
			data.writeByte(0x00);
			data.writeByte(0x00);
			data.writeByte(0x00);
			data.writeByte(0x02);
			
			//Write true
			data.writeByte(0x01);
			data.writeByte(0x01);
			
			//Write one body
			data.writeByte(0x00);
			data.writeByte(0x01);
			
			//Write the target (null)
			data.writeByte(0x00);
			data.writeByte(0x04);
			data.writeUTFBytes("null");
			
			//Now write the response handler
			data.writeByte(0x00);
			data.writeByte(0x02);
			data.writeUTFBytes("/1");
			
			//Write the number of bytes in the body
			data.writeByte(0x00);
			data.writeByte(0x00);
			data.writeByte(0x00);
			data.writeByte(0x00); //amfphp doesn't read this, so no matter
			
			var a:RemotingMessage = new RemotingMessage();
			a.clientId = "";
			a.messageId = "";
			a.operation = methodName;
			a.source = className;
			a.body = args;
			
			//Write the AMF3 bytecode
			if(encoding == ObjectEncoding.AMF3)
			{
				data.writeByte(0x11);
			}
			//Then the object
			data.writeObject([a]);
			

			return data;
		}
		
		function readData(event)
		{

			diagnostic.pingTime = getTimer() - time;
			
			var rawData:ByteArray = loader.data;
			rawData.objectEncoding = ObjectEncoding.AMF0;
			
			//Determine if data is valid
			
			diagnostic.receivedSize = rawData.bytesAvailable;
			
			var decodeTime = getTimer();
			if(rawData[0] == 0x00)
			{
				var numHeaders = rawData[2]*256 + rawData[3];
				rawData.position = 4;
				for(var i:int = 0; i < numHeaders; i++)
				{
					var strlen:int = rawData.readUnsignedShort();
					var key:String = rawData.readUTFBytes(strlen);
					var required:Boolean = rawData.readByte() == 1;
					var len:int = rawData.readUnsignedInt();
					rawData.position += len; //Just skip for now
				}
				var numBodies = rawData.readUnsignedShort();
				for(var i:int = 0; i < numBodies; i++)
				{
					var strlen:int = rawData.readUnsignedShort();
					var target:String = rawData.readUTFBytes(strlen);
					
					strlen = rawData.readUnsignedShort();
					var response:String = rawData.readUTFBytes(strlen);
					
					var bodyLen = rawData.readUnsignedInt();
					
					//var key:String = rawData.readUTFBytes(strlen);
					//var required:Boolean = rawData.readByte() == 1;
					//var len:int = rawData.readUnsignedInt();
					
					if(encoding == ObjectEncoding.AMF3)
					{
						var amf3Byte = rawData.readUnsignedByte();
						rawData.objectEncoding = ObjectEncoding.AMF3;
					}
					var bodyVal = rawData.readObject();
					rawData.objectEncoding = ObjectEncoding.AMF0;

					if(target == '/1/onDebugEvents')
					{
						//Look at the bodyVal
						for(var j = 0; j < bodyVal[0].length; j++)
						{
							if(bodyVal[0][j].EventType == 'trace')
							{
								//Bingo, we got trace
								traceMessages = bodyVal[0][j].messages;
							}
							else if(bodyVal[0][j].EventType == 'profiling')
							{
								//Bingo, we got trace
								profiling = bodyVal[0][j];
							}
						}
					}
					else if(target == '/1/onResult')
					{

						//We have a result event
						var sendEvent = new ResultEvent(
							ResultEvent.RESULT,
							false,
							true,
							bodyVal.body);
							
						//dispatchEvent(re);
					}
					else if(target == '/1/onStatus')
					{
						//We have a fault event
						var fault:Fault = new Fault(bodyVal.faultCode, bodyVal.faultString, bodyVal.faultDetail);
						var sendEvent = new FaultEvent(FaultEvent.FAULT, false, true, fault);
						//dispatchEvent(fe);
					}
				}
			}
			else
			{

				//Create a new Fault event
				rawData.position = 0;
				var errorMessage = rawData.readUTFBytes(rawData.length);
				var fault:Fault = new Fault("INVALID_AMF_MESSAGE", "Invalid AMF message", errorMessage);
				var sendEvent = new FaultEvent(FaultEvent.FAULT, false, true, fault);
				//dispatchEvent(fe);
			}
			
			if(rawData.bytesAvailable == 2)
			{
				var totalTime = rawData.readUnsignedShort();
			}
			
			diagnostic.decodeTime = getTimer() - decodeTime;
			profiling.totalTime = totalTime;
			profiling.encodeTime = totalTime - (profiling.frameworkTime + 
									profiling.decodeTime + 
									profiling.includeTime + 
									profiling.callTime);
			dispatchEvent(sendEvent);
		}
	}
}