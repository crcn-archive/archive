package com.bridge.modules
{
	import com.bridge.core.ModuleType;
	import com.bridge.core.OperationalModule;
	import com.bridge.utils.*;

	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	
	public class JavascriptModule extends OperationalModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        private const JAVASCRIPT_FUNCTION:RegExp = / \w+\( [^()]* \)\s*(?=\{) /gx;
        private const REMOVE_WHITESPACE:RegExp   = / [\n\t\r]+ /gx;
        private const FUNCTION_NAME:RegExp       = /\w+(?=\()/x;
        private const FUNCTION_PARAMS:RegExp     = /\w+/gx;
        
        //TEMPORARY
        private var JS_METHOD_PATTERN:RegExp = /[\w:.]+\( ([^()]|(?R))* \)/gx;
        
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _filters:Array;
        private var _functions:Array;
        private var _javascripts:String;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function JavascriptModule(ns:String = "")
		{
			super(ns);
			
			_javascripts = new String();
			_functions   = new Array();
			_filters  	 = new Array();

			nodeEvaluator.addHandler("javascript",addJavascript);
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        // Getters / Setters 
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
        override public function get moduleType():Array
        {
        	return [ModuleType.NODE_NAME,ModuleType.VALUE];
        }
        
        /**
		 */
		
		public function set stringFilter(filt:*):void
		{
			_filters.push(filt);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function callFunction(functionName:String, params:Array):void
		{
			var newValues:Array = new Array();
				
			for each(var value:* in params)
			{
				newValues.push("\""+value+"\"");
			}
			
        	var call:String = "return "+functionName+"("+newValues.toString()+");";
        	var javascript:String = "function(){"+_javascripts+call+"}";
        	
        	result = ExternalInterface.call(javascript);
		}
		
		/**
		 * we don't exactly know what javascript functions are built in
		 * so call them all
		 */
		
		override public function hasHandler(name:String):Boolean
		{
			return true;
		}

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		 
        private function addJavascript():void
        {
			////trace(evaluatedNode.attributes);
        	if(evaluatedNode.attributes.source)
        	{
        		//trace("\n\nLOAIND JAVASCRIPT:"+evaluatedNode.attributes.source+"\n\n");
        		loadSource();
        		return;
        	}
        	
        	defineJavascriptFunction(evaluatedNode.firstChild.nodeValue);
        }
        
        /**
         */
        
        private function processFunction():void
        {

			var hasNS:Boolean = NamespaceUtil.hasNamespace(this.moduleNamespace,evaluatedNode.nodeName);
			
			
			if(hasNS)
				handleNodeCommand();
			//else
			//	handleValueCommand();
        	
        	
        	
        }
        
        private function handleNodeCommand():void
        {
        	var functionName:String  = NamespaceUtil.removeNamespaceIfPresent(this.moduleNamespace,evaluatedNode.nodeName);
        	
        	var functionParams:Array = _functions[ functionName ];
        	
        	//get the parameter values in the correct index
        	var paramValues:Array = new Array;
        	for(var i:int = 0; i < functionParams.length; i++)
        	{
        		paramValues[i] = evaluatedNode.attributes[ functionParams[ i ] ];
        	}
        	
        	var func:Function = makeFunction(functionName);
        	
        	func.apply(null,paramValues);
        }
        
        /**
         */
        
       /* private function handleValueCommand():void
        {
        	var attrs:Object = evaluatedNode.attributes;
			
			var phpMethods:Array;
			var parser:SyntaxParser = new SyntaxParser();
			var tokenizedMethod:Array;
			var phpCommand:String;
			var amfService:Function;
			
			for(var property:String in attrs)
			{
				if(NamespaceUtil.hasNamespace(this.moduleNamespace,attrs[property]))
				{
					phpMethods = attrs[property].match(JS_METHOD_PATTERN);
					
					for each(var value:String in phpMethods)
					{
						tokenizedMethod = parser.tokenize(value);
						
						tokenizedMethod = tokenizedMethod.slice(1,tokenizedMethod.length);
						
						phpCommand = tokenizedMethod[0];
						
						amfService = makeFunction(phpCommand);
						
					
						evaluatedNode.addVariable(phpCommand,amfService);
						
						var result:* = evaluatedNode.stringEvaluator.eval("{"+tokenizedMethod.join(".")+"}");
						
						
						evaluatedNode.attributes[property] = evaluatedNode.attributes[property].replace(value,result);
						
					}
				}
			}
        }*/
        
        
        
         /**
         */
        
        private function makeFunction(functionName:String):Function
        {
        
			var func:Function =
			
			function(...params:Array):*
			{
				var newValues:Array = new Array();
				
				for each(var value:* in params)
				{
					newValues.push("\""+value+"\"");
				}
				
        		var call:String = "return "+functionName+"("+newValues.toString()+");";
        		var javascript:String = "function(){"+_javascripts+call+"}";

        		return result = ExternalInterface.call(javascript);
        		
   			}
   			
   			
   			
   			return func;
        }
        
        /**
		 */
		
		private function loadSource():void
		{
			evaluatedNode.pauseAll();
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onSourceComplete);
			loader.load(new URLRequest(evaluatedNode.attributes.source));
		}
		
		/**
		 */
		
		private function onSourceComplete(event:Event):void
		{

			event.target.removeEventListener(Event.COMPLETE,onSourceComplete);

			defineJavascriptFunction(event.target.data);
			evaluatedNode.resumeAll();
		}
        
        
        /**nodeEvaluator\.addHandler\(.*?,"(.*?)"\)
         */
        
        private function defineJavascriptFunction(script:String):void
        {
        	var currentScript = script;
        	currentScript     = currentScript.replace(REMOVE_WHITESPACE,"");
			
			var functions:Array = currentScript.match(JAVASCRIPT_FUNCTION);
			var functionName:String;
			var functionParams:Array;
			var functionParams2:Array;
			//trace(functions);
			for each(var indFunction:String in functions)
			{
				
				functionName = indFunction.match(FUNCTION_NAME)[0];
				functionParams = indFunction.match(FUNCTION_PARAMS);
				functionParams2 = new Array();
				
				//FIX LATER
				for(var i:int = 1; i < functionParams.length; i++)
				{
					functionParams2.push(functionParams[i]);
				}
				
				//trace(functionName,functionParams2);
				_functions[ functionName ] = functionParams2;
				
				this.registerFunction(functionName,makeFunction(functionName));
				
				//add the function to the node evaluator
				
				nodeEvaluator.addHandler(functionName,processFunction);
			}
        	
        	
        	_javascripts += currentScript;
        	
        	
        	
        	//add this parser to the node
        	//if this parser exists it won't get added so there is no problem calling it more than one time
        	//evaluatedNode.stringEvaluator.addParser(this);
        }

	}
}