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

	import com.bridge.core.ModuleType;
	import com.bridge.core.OperationalModule;
	import com.bridge.library.MediaCache;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.BridgeUtils;
	import com.ei.utils.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
		
	/**
	 * The Load Manager module manages loads by scanning the entire document for any data containing its namespace, and pushes anything to the load stack.
	 * It then waits for all items to load, then replaces the string values with their loaded data. The file does still load if the execute command is not processed,
	 * however they will load separately. Use it as such:
	 * 
	 * <br/><br/>
	 * 
	 * <code>
	 * &lt;[NAMESPACE]:execute /&lt;//pause script here, and scan the document for files to load, then resume when all files are loaded
	 * <br/>
	 * &lt;Image source="{[NAMESPACE]:media('myImage.jpg')}&gt;//caught, throwing into load manager
	 * <br/>
	 * &lt;Image source="{[NAMESPACE]:media('myImage2.jpg')}&gt;//caught, throwing into load manager
	 * <br/>
	 * &lt;Image source="{[NAMESPACE]:media('myImage3.jpg')}&gt;//caught, throwing into load manager
	 * <br/>
	 * </code>
	 * 
	 * <br/><br/>
	 * 
	 * Example:
	 *
	 * <br/><br/>
	 * <code>
	 * &lt;Label instance:id="lmText" /&gt;
	 * <br/>
	 * &lt;observer:listen to="{loadManager}" for="progress" &gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;change:property target="{lmText}" text="loading {loadManager.bytesLoaded/loadManager.bytesTotal*100}%" /&gt;
	 * <br/>
	 * &lt;/observer:listen&gt;
	 * &lt;loadManager:execute /&gt;
	 * <br/>
	 * &lt;Image source="{loadManager:media('myImage.jpg')}" /&gt;
	 * <br/>
	 * &lt;Label text="{loadManager:text('myText.txt')}" /&gt;
	 * <br/>
	 * </code>
	 * 
	 * Note that the loaded files do not have a semi colon after the method call. Adding anything after the method will return an unwanted value.
	 * 
	 */
	public class LoadManagerModule extends OperationalModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        //public const FUNCTION_NAME:RegExp    = /\w+(?=\()/;
        //public const FUNCTION_PARAMS:RegExp  = /(?<=\().*?(?=\))/;
        //public const FUNCTION_PATTERN:RegExp = /^[\w:]+\(.*?\)$/x; //for anything method encased in whitespace
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

        private var _loadManager:LoadManager;
        private var _itemsToLoad:Boolean;
        private var _executing:Boolean;
        
        private var _currentNode:BridgeNode;
        private var _currentKey:String;
        
        //--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		/**
		 * the compilated bytes currently loaded by the load manager
		 */
		
		public var bytesLoaded:Number;
		
		/**
		 * the total compilated bytes to load
		 */
		
		public var bytesTotal:Number;
		
		/**
		 * the method to use when scanning through the current node for
		 * files to load. pause or pause all
		 */
		 
		public var pauseMethod:String = "pause";
		
		
		public var cache:MediaCache;
		
        
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
			
			cache = MediaCache.getInstance();
			
			_loadManager = new LoadManager();
			
			
			_loadManager.addEventListener(Event.COMPLETE,onLoaderComplete);
			_loadManager.addEventListener(ProgressEvent.PROGRESS,onLoadProgress);
			
			nodeEvaluator.addHandler("execute",execute);
			
			
			this.registerFunction("media",media);
			this.registerFunction("text",text);
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
        	return [ModuleType.NODE_NAME];
        }
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * loads any media data and returns a Loader instance if the Load Manager has not been executed.
         * If the load manager has been executed, the file being loaded is pushed to an array, and the script
         * is paused until the file is loaded.
		 */
		
		public function media(value:String):*
		{
			var loader:Loader = new Loader();
			
			
			
			if(cache.hasFile(value))
			{
				//trace"LoadManager::has file"+value+_executing);
				var bytes:ByteArray = cache.getFile(value);
				
				loader.loadBytes(bytes);
			}
			else
			{
				//trace"LoadManagerModule::laod("+value+")");
				loader.load(new URLRequest(value),new LoaderContext(true));
				
			}
			
			//for when no mod
			//_currentNode.attributes[_currentKey] = loader;
			var listener:LoadListener = new LoadListener(_currentNode,_currentKey,loader.contentLoaderInfo);
			listener.addEventListener(Event.COMPLETE,onLoadMediaComplete,false,1);
			
			
			if(_executing)
			{
				//trace"LoadManagerModule::executing");
				_loadManager.addLoader(listener);
				
				
			}
			
		}
		
		/**
         * loads any text data and returns a Loader instance if the Load Manager has not been executed.
         * If the load manager has been executed, the file being loaded is pushed to an array, and the script
         * is paused until the file is loaded.
		 */
		 
		public function text(value:String):void
		{
			var loader:URLLoader = new URLLoader();
			
			if(cache.hasFile(value))
			{
				
				var bytes:ByteArray = cache.getFile(value);
				var result:String   = bytes.readUTFBytes(bytes.length);
				
				_currentNode.attributes[_currentKey] = result;
			}
			else
			{
				loader.load(new URLRequest(value));
			}
			
			var listener:LoadListener = new LoadListener(_currentNode,_currentKey,loader);
			listener.addEventListener(Event.COMPLETE,onLoadTextComplete,false);	
			
			if(_executing)
			{
				//trace"LoadManagerModule::executing");
				_loadManager.addLoader(listener);
				
				
			}
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
			
			////trace"LoadManagerModule::EXECUTE");
			
			_executing    = true;
			//resume the node if there is nothing to load
			_itemsToLoad = false;
			
			BridgeUtils.everyNode(evaluatedNode,findLoads);
			
			
			
			if(_itemsToLoad)
			{
				//trace"LoadManagerModule::PAUSING"+pauseMethod);
				evaluatedNode.parentNode[pauseMethod]();
			}
			
			
		}
		
		/**
		 */
		 
		private function findLoads(currentNode:BridgeNode):void
		{
			var attrValue:String;
			
			
			//trace"LoadManagerModule::findLoads("+currentNode.nodeName+")");
			
			//LM ~ {#LM:media = VALID, {#LM2:media = INVALID 
			var checkNS:RegExp = new RegExp('(?<!\w)'+this.moduleNamespace+'(?!\w)',"i");
			
			for(var attr:String in currentNode.originalAttributes)
			{
				attrValue = currentNode.originalAttributes[attr];
				
				if(checkNS.test(attrValue))
				{
					_currentNode = currentNode;
					_currentKey  = attr;
					
					
					//trace"LoadManagerModule::EVAL="+attrValue);
					currentNode.nodeLibrary.valueParser.getSegmentParser().eval(attrValue);
					
					_itemsToLoad = true;
				}
			}
		}
		
		
		/**
		 */
		
		private function onLoaderComplete(event:Event):void
		{
			
			//trace"LOadManagerModule::onLoaderComplete");
			_executing = false;
			
			resumeNode();
		}
		
		
		/**
		 */
		
		private function resumeNode():void
		{
			
			//trace"LoadManagerModule::RESUME");
			
			var method:String;
			
			
			if(pauseMethod == "pause")
				method = "resume";
			else
				method = "resumeAll";
				
			evaluatedNode.parentNode[method]();
		}

		/**
		 */
		
		private function onLoadProgress(event:ProgressEvent):void
		{
			//trace"PROGRESS");
			
			bytesLoaded = _loadManager.bytesLoaded;
			bytesTotal  = _loadManager.bytesTotal;
			
			dispatchEvent(new Event(ProgressEvent.PROGRESS));
			
		}
		
		/**
		 */
		private function onLoadTextComplete(event:Event):void
		{
			event.target.removeEventListener(event.type,onLoadTextComplete);
			
			var node:BridgeNode = event.target.node;
			var attr:String     = event.target.attribute;
			
			if(this._executing)
				node.attributes[attr] = event.target.loader.data;
			else
				result = event.target.loader.data;
			
		}
		
		/**
		 */
		private function onLoadMediaComplete(event:Event):void
		{
			event.target.removeEventListener(event.type,onLoadMediaComplete);
			
			var node:BridgeNode = event.target.node;
			var attr:String     = event.target.attribute;
			
			//tracenode);
			
			if(this._executing)
				node.attributes[attr] = event.target.loader.loader;
			else
				result = event.target.loader.loader;
			
			
		}

	}
}
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import flash.display.Loader;
	import flash.events.ProgressEvent;
	import flash.utils.setInterval;
	import flash.utils.clearInterval;
	import com.bridge.node.BridgeNode;
	


	class LoadManager extends EventDispatcher
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _loaders:Array;
		
		private var _interval:Number = NaN;
		
		private static const PROGRESS_SPEED:int = 100;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var bytesTotal:Number;
        public var bytesLoaded:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function LoadManager()
		{
			_loaders = new Array();
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get complete():Boolean
		{
			for each(var loader:LoadListener in _loaders)
			{
				if(!loader.complete)
					return false;
			}
			
			return true;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        
        /**
		 */
		
		public function addLoader(listener:LoadListener):void
		{
			
			
			listener.addEventListener(Event.COMPLETE,onComplete,false,0,true);
			
			_loaders.push(listener);
			
			if(isNaN(_interval))
				_interval = flash.utils.setInterval(onProgress,PROGRESS_SPEED);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onComplete(event:Event):void
		{
			event.target.removeEventListener(event.type,onComplete);
			
			if(complete)
			{
				dispatchEvent(new Event(Event.COMPLETE));
				clearInterval(_interval);
				_interval = NaN;
				clearLoaders();
			
			}
				
			
			
		}
		
		/**
		 */
		 
		private function onProgress():void
		{
			bytesTotal  = 0;
			bytesLoaded = 0;
			
			for each(var loader:LoadListener in _loaders)
			{
				bytesTotal  += loader.bytesTotal;
				bytesLoaded += loader.bytesLoaded;
			}
			dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
			
		}
		
		/**
		 */
		 
		private function clearLoaders():void
		{
			for(var i in _loaders)
			{
				_loaders[i].removeEventListener(Event.COMPLETE,onComplete);
				delete _loaders[i];
			}
		}
		
		
		
		
	}
	
	class LoadListener extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var loader:EventDispatcher;
        
        public var bytesLoaded:Number;
        public var bytesTotal:Number;
        
        public var node:BridgeNode;
        public var attribute:String;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _complete:Boolean;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function LoadListener(node:BridgeNode,attribute:String,loader:EventDispatcher)
		{
			this.loader = loader;
			
			this.node = node;
			this.attribute = attribute;
			
			loader.addEventListener(Event.COMPLETE,onComplete);
			loader.addEventListener(ProgressEvent.PROGRESS,onProgress);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get complete():Boolean
		{
			return _complete;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onComplete(event:Event):void
		{
			//trace"LoadManagerModule::listener COMPLETE");
			event.target.removeEventListener(event.type,onComplete);
			
			_complete = true;
			
			dispatchEvent(event);
			
		}
		
		/**
		 */
		private function onProgress(event:ProgressEvent):void
		{
			
			this.bytesLoaded = event.bytesLoaded;
			this.bytesTotal  = event.bytesTotal;
		}
		
	}