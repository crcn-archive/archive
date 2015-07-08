package com.bridge.modules
{
	import com.adobe.serialization.json.JSON;
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class PHPServerModule extends EvaluableModule
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function PHPServerModule(ns:String = "")
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("callCommand",callCommand);
			
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
		 
		private function callCommand():void
		{
			//pause the parent script until we get a response
			this.evaluatedNode.pauseAll();
			
			var request:URLRequest = new URLRequest(this.evaluatedNode.attributes.handler);
			
			
			var vars:URLVariables = new URLVariables();
			vars["script"] = this.evaluatedNode.attributes.script;
			vars["return"] = this.evaluatedNode.attributes["return"];
			
			var sendVarsStr:String = this.evaluatedNode.attributes["sendVars"];
			
			if(sendVarsStr)
			{
				var sendVars:Array = JSON.decode(sendVarsStr);
				
				for each(var indVar:String in sendVars)
				{ 
					evaluatedNode.nodeLibrary.valueParser.eval("{"+indVar+"}");
					
					vars[indVar] = evaluatedNode.nodeLibrary.valueParser.result;
					
				}
			}
			
			request.method = URLRequestMethod.POST;
			
			request.data = vars;
			trace(vars["testerLabel.text"]);
			
			
			var shoutout:URLLoader = new URLLoader();
			shoutout.addEventListener(Event.COMPLETE,onResponse);
			shoutout.load(request);
			
			
		}
		
		private function onResponse(event:Event):void
		{
			trace(event.target.data);
			try
			{
				var results:Object = JSON.decode(event.target.data);
			}catch(e:*)
			{
				return;
			}
			for(var result in results)
			{
				
				if(result == "vars")
				{
					
					for(var varName in results[result])
					{
						this.evaluatedNode.addVariable("$"+varName,results[result][varName]);
					}
				}
			}
			
			this.evaluatedNode.resumeAll();
			
		}
		
		

	}
}