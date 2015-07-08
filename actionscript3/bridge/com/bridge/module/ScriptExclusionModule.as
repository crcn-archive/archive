/*

runs script separate from 

*/


package com.bridge.module
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	
	import flash.events.Event;
	
	/**
	 * Loads in a Bridge script and treats it as its own appliation. Use it as such:
	 * <br/><br/>
	 * <code>
	 * &lt;[NAMESPACE]:application script="script to run" flashVars="the flash variables to pass" root="the root display object" stage="the stage display object"&gt;
	 * </code>
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * <code>
	 * &lt;Object instance:id="gingerFlashVars" plugins="" skin="gingerSkin.xml"/&gt;
	 * <br/>
	 * &lt;Container instance:id="gingerContainer" width="500" height="500" />
	 * <br/>
	 * &lt;bridge:application script="gingerMediaPlayer.xml" flashVars="{gingerFlashVars}" root="{gingerContainer}" stage="{gingerContainer}" /&gt;
	 * </code>
	 */
	  
	public class ScriptExclusionModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ScriptExclusionModule(ns:String)
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("application",executeApp);
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
		
		private function executeApp():void
		{
			//new ScriptExclusion(evaluatedNode);
			
			new ScriptExclusion(evaluatedNode);
		}
		
		

	}
}
	import com.bridge.node.BridgeNode;
	import flash.events.Event;
	import com.bridge.events.FMLEvent;
	import com.bridge.BridgeCore;
	import com.bridge.node.BridgeDocument;
	import com.bridge.module.XMLNSModule;
	

	class ScriptExclusion2
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _evaluatedNode:BridgeNode;
		private var _stage:Sprite;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ScriptExclusion2(evaluatedNode:BridgeNode)
		{
			
			
			_evaluatedNode = evaluatedNode;
			
			evaluatedNode.pauseAll();
			
			
			var flashVars:String = new String();
			
			
			
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onSWFLoad);
			
			
			var request:URLRequest = new URLRequest(evaluatedNode.attributes.swf);
			
			var urlVars:URLVariables = new URLVariables();
			for(var attr:String in _evaluatedNode.attributes.flashVars)
			{
				urlVars[attr] = _evaluatedNode.attributes.flashVars[attr];
			}
			
			trace("load "+evaluatedNode.attributes.swf);
			
			_stage = _evaluatedNode.attributes.stage;
			request.data = urlVars;
			loader.load(request);	
			
			
		}
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		private function onSWFLoad(event:Event):void
		{
			trace("ScriptExclusionModule::onSwfLoad()");
			
			event.target.removeEventListener(event.type,onSWFLoad);	
			
			
			var flashVars:Object = event.target.loader.content.loaderInfo.parameters;
			
			flashVars.stage = _stage;
			
			
			_stage.addChild(event.target.loader.content);
		}
		
	}
	import com.bridge.node.BridgeNode;
	import flash.events.Event;
	import com.bridge.events.FMLEvent;
	import com.bridge.BridgeCore;
	import com.bridge.node.BridgeDocument;
	import com.bridge.module.XMLNSModule;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import com.ei.utils.Sleep;
	import flash.display.LoaderInfo;
	import flash.net.URLVariables;
	import flash.system.LoaderContext;
	import flash.system.ApplicationDomain;
	import flash.display.DisplayObject;
	import flash.utils.getDefinitionByName;
	import flash.display.Sprite;
	

	class ScriptExclusion
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _evaluatedNode:BridgeNode;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ScriptExclusion(evaluatedNode:BridgeNode)
		{
			
			var bridge:BridgeNode = new BridgeNode();
			bridge.addModule(new XMLNSModule("xmlns"));
			_evaluatedNode = evaluatedNode;
			
			evaluatedNode.pauseAll();
			
			
			
			//script, flashVars, root, stage
			for(var attr:String in evaluatedNode.attributes)
			{
				bridge.addVariable(attr,evaluatedNode.attributes[attr]);
			}
			
			bridge.addEventListener(FMLEvent.COMPLETE,onBridgeComplete);
			bridge.parseXML(BridgeCore.script);
			bridge.restart();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
		/**
		 */
		private function onBridgeComplete(event:FMLEvent):void
		{
			
			event.target.removeEventListener(event.type,onBridgeComplete);
			_evaluatedNode.resumeAll();
		}
	}