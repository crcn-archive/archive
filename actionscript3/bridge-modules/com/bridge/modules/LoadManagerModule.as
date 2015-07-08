package com.bridge.modules
{

	import com.bridge.core.BridgeModule;
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.IBridgeNode
	import com.bridge.modules.component.ComponentModule;
	import com.bridge.utils.NamespaceUtil;
	import com.ei.events.*;
	import com.ei.loaders.*;
	import com.ei.utils.*;
	import com.ei.utils.info.ClassInfo;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.utils.Dictionary;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
		
	public class LoadManagerModule extends EvaluableModule
	{
		
		/*
		
		to implement later
		
		
		<Canvas styleName=".preloader">
			<TextArea text="LM:execute" />
		</Canvas>
		
		<LM:execute />
		
		*/
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        private const FUNCTION_NAME:RegExp = /\w+(?=\()/;
        private const FUNCTION_PARAMS:RegExp = /(?<=\().*?(?=\))/;
        private const FUNCTION_PATTERN:RegExp = /^[\w:]+\(.*?\)$/x; //for anything method encased in whitespace
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

        private var _loaderList:LoaderList;
        private var _loaderNodes:Dictionary;
        private var _itemsToLoad:Boolean;
        
        private var _preloaders:Array;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function LoadManagerModule(ns:String = "")
		{
			super(ns);
			
			_loaderNodes = new Dictionary();
			_preloaders  = new Array();
			_loaderList = new LoaderList();
			
			_loaderList.addEventListener(LoaderListEvent.COMPLETE,onLoaderComplete);
			_loaderList.addEventListener(FileEvent.PROGRESS,onLoadProgress);
			
			
			nodeEvaluator.addHandler("execute",execute);
			nodeEvaluator.addHandler("bytesLoaded",bytesLoaded);
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

		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function execute():void
		{
			
			var searchNodes:Array = evaluatedNode.parentNode.childNodes;
			
			var nodesToParse:Array = new Array();
			
			var found:Boolean;
			
			for each(var node:IBridgeNode in searchNodes)
			{
				
				
				if(found)
				{
					nodesToParse.push(node);
				}
				
				if(evaluatedNode == node)
					found = true;
				
			}
		
			//resume the node if there is nothing to load
			_itemsToLoad = false;
			
			evaluateNodes(nodesToParse)
			
			if(_itemsToLoad)
				evaluatedNode.parentNode.pause();
			
			
			_loaderList.startLoader();
		}
		
		/**
		 */
		
		private function bytesLoaded():void
		{

			var nodeKey:String;
			var nodeVal:String;
			var bytesLoadedRep:String = moduleNamespace+":bytesLoaded";
				
			for(var key:String in evaluatedNode.attributes)
			{
				if(evaluatedNode.attributes[ key ].indexOf(bytesLoadedRep) > -1)
				{
					nodeKey = key;
					nodeVal = evaluatedNode.attributes[ key ];
					evaluatedNode.attributes[ key ] = evaluatedNode.attributes[ key ].replace(bytesLoadedRep,0);
					break;
				}
					
			}
			
			var info:Object = new Object();
			info.node  = evaluatedNode;
			info.key   = nodeKey;
			info.value = nodeVal;

			_preloaders.push(info);
		}
		
		/**
		 */
		
		private function evaluateNodes(searchNodes:Array):void
		{
			var nodeAttr:Object;
			
			var found:Boolean;

			for each(var node:IBridgeNode in searchNodes)
			{
				if(node.firstChild != null)
				{
					evaluateNodes(node.childNodes);
				}
				
				nodeAttr = node.attributes;
				
				for(var key:String in nodeAttr)
				{

					if(NamespaceUtil.getNamespaceIfPresent(nodeAttr[ key ]) == this.moduleNamespace)
					{
		
						getLoader(nodeAttr[ key ],node.attributes,key);
						found = true;
						_itemsToLoad = true;
					}
				}

				//break the script so the node is not evaluated again
				//(problems with pulling methoud out of params instead of just parsing the node)
				if(!found)
				{
					var match:String = trimWhiteSpace(Object(node).toString());
					
					if(NamespaceUtil.getNamespaceIfPresent(match) == this.moduleNamespace && FUNCTION_PATTERN.test(match))
					{
						getLoader(match,node,"firstChild");
						_itemsToLoad = true;
					}
					
				}
				
				found = false;
			}

		}
		
		/**
		 */
		
		private function getLoader(func:String,node:*,key:String):void
		{

			var funcName:String   = NamespaceUtil.removeNamespaceIfPresent(this.moduleNamespace,func);
			
			funcName              = funcName.match(FUNCTION_NAME).toString();
			
			//the URL might have data to parse in it such as {$root}url
			evaluatedNode.stringEvaluator.eval(func.match(FUNCTION_PARAMS).toString());
			
			var funcParams:String = evaluatedNode.stringEvaluator.result as String;
			
			var loader:*;
			switch(funcName)
			{
				case "media":
					loader = new MediaLoader();
				break;
				case "script":
				case "text":
					loader = new TextLoader();
				break;
			}
			loader.addEventListener(FileEvent.COMPLETE,onFileComplete);
			_loaderList.addLoader(loader);
			
			
			//trace(funcParams);
			loader.load(funcParams);
			
			
			_loaderNodes[ loader ] = [node,key,funcName];
			
			
		}
		
		/**
		 */
		
		private function onEvaluate(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE,onEvaluate);
		}
		
		/**
		 */
		
		private function onNetworkError(event:IOErrorEvent):void
		{
			event.target.removeEventListener(IOErrorEvent.IO_ERROR,onNetworkError);
			
		}
		
		/**
		 */
		
		private function onFileComplete(event:FileEvent):void
		{
			event.target.removeEventListener(FileEvent.COMPLETE,onFileComplete);
			
			var nodeInfo:Array = _loaderNodes[ event.target ];
		
			//trace(nodeInfo);
			switch(nodeInfo[2])
			{
				case "text":
				case "media":
					nodeInfo[0][nodeInfo[1]] = event.target.data;
				break;
				case "script":
					
					//TEMPORARY
					var targetNode:FMLNode = nodeInfo[0];
					
					var node:XMLDocument = new XMLDocument();
					node.ignoreWhite = true;
					node.parseXML(event.target.data);
					var newChild:FMLNode;
					
					var nodeClass:Class = ClassInfo.getClass(evaluatedNode);
					
					for each(var child:XMLNode in node.childNodes)
					{
						newChild = new nodeClass(child);
						
						//this will put the nodes in the correct order
						targetNode.parentNode.insertBefore(newChild,targetNode);
					}
					
					
					targetNode.parentNode.remove([targetNode]);
					
					
					
					

				break;
			}
			

			
		}
		
		/**
		 */
		
		private function onLoaderComplete(event:LoaderListEvent):void
		{

			//_loaderList.removeEventListener(LoaderListEvent.COMPLETE,onLoaderComplete);
			
			resumeNode();
		}
		
		/**
		 */
		
		private function resumeNode():void
		{
			
			evaluatedNode.parentNode.resume();
		}

		/**
		 */
		
		private function onLoadProgress(event:FileEvent):void
		{
			
			var bytesLoadedRep:String = moduleNamespace+":bytesLoaded";
			var found:Boolean;
			var newValue:*;
			
			for each(var preloader:Object in _preloaders)
			{
				
				newValue = String(_loaderList.bytesLoaded / _loaderList.bytesTotal);
				newValue = preloader.value.toString().replace(bytesLoadedRep,newValue);
				newValue = preloader.node.stringEvaluator.eval(newValue);
				
				for each(var module:BridgeModule in preloader.node.usedModules)
				{
					
					if(module is ComponentModule)
					{

						try
						{
							ComponentModule(module).getInstance(preloader.node)[preloader.key] = newValue;
							found = true;
							break;
						}catch(e:*)
						{
							
						}					
					}
				}
				
				if(!found)
				{
						
					preloader.node.originalAttributes[preloader.key] = newValue;
					preloader.node.restart();
				}
				
				found = false;
				
				newValue = 0;
			}
		}

	}
}