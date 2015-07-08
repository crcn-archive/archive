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
	import com.bridge.utils.*;
	import com.ei.events.*;
	import com.ei.loaders.*;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	
	/**
	 * loads in an external asset to be executed. Use it as such:
	 * <br/><br/>
	 * <code>
	 * &lt;[NAMESPACE]:asset source="asset source" type="asset type" /&gt;
	 * </code>
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * <code>
	 * &lt;external:asset source="myScript.xml" type="script"/&gt;//executes a script
	 * <br/>
	 * &lt;external:asset source="mySWF.swf" type="rsl" /&gt;//loads in a swf to be processed as an RSL (access the classes)
	 * <br/>
	 * </code>
	 */
	 
	public class ExternalAssetModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
       	private var _finished:Boolean;
       	
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ExternalAssetModule(ns:String = "")
		{
			super(ns);
			nodeEvaluator.addHandler("asset",loadScript);
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
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function loadScript():void
		{
			_finished = false;
			evaluatedNode.pauseAll();
			
			var source:String = evaluatedNode.attributes.source;
			var type:String   = evaluatedNode.attributes.type;
			var loader:*;
			
			trace("ExternalAsset::"+source+type);
			
			switch(type)
			{
				case "rsl":
					loader = new Loader();
				
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComponentComplete);
					var ldrContext:LoaderContext = new LoaderContext(false,ApplicationDomain.currentDomain); 
					loader.load(new URLRequest(source),ldrContext);
				break;
				case "swc":
					
					//loader = new SWCLoader();
					//loader.addEventListener(FileEvent.COMPLETE,onFileComplete);
					//loader.load(source);
				break;
				case "font":
					
					loader = new FontLoader();
					loader.addEventListener(FileEvent.COMPLETE,onFileComplete);
					loader.load(source);
					
				break;
				case "script":
					loader = new URLLoader();
					loader.addEventListener(Event.COMPLETE,onComplete);
					loader.load(new URLRequest(source));
				break;
			}
			
			
		}
		
		/**
		 */
		 
		private function onComplete(event:Event):void
		{
			_finished = true;
			
			//trace("\n\nLOADED SCRIPT\n\n");
			event.target.removeEventListener(Event.COMPLETE,onComplete);
			//trace(evaluatedNode.nodeName);
		
			evaluatedNode.removeAllChildren();
		
			evaluatedNode.appendChild(event.target.data);
			
			//trace(evaluatedNode.nodeName);
			//var node:FMLNode = new FMLNode();
			//node.parseAndExecute(event.target.data);
			
			//trace("\n\nFINISHED PARSING SCRIPT\n\n");
			
			if(_finished)
			{
				//trace("\n\nFINISHED NOW RESUMING FROM SCRIPT\n\n");
				evaluatedNode.resumeAll();
			}
			else
			{
				//trace("\n\nSTILL ASSETS TO LOAD\n\n");
			}
		}
		
		/**
		 */
		 
		private function onComponentComplete(event:Event):void
		{
			_finished = true;
			
			//trace("\n\n\nLOADED BRIDGE MODULE\n\n");
			event.target.removeEventListener(Event.COMPLETE,onComponentComplete);
			
			//trace("\n\nFINISHED NOW RESUMING FROM COMPONENT\n\n");
			evaluatedNode.resumeAll();
		}
		
		/**
		 */
		 
		private function onFileComplete(event:FileEvent):void
		{
			_finished = true;
			
			//trace("\n\n\nLOADED BRIDGE MODULE\n\n");
			event.target.removeEventListener(FileEvent.COMPLETE,onFileComplete);
			
			//trace("\n\nFINISHED NOW RESUMING FROM COMPONENT\n\n");
			evaluatedNode.resumeAll();
		}

	}
}