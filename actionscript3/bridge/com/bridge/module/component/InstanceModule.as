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
 
package com.bridge.module.component
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.events.FMLEvent;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.*;
	import com.ei.utils.simpleObject.*;
	
	import flash.utils.Dictionary;
	
	/**
	 * assigns an instance name to a component so it may be used throughout the application. Here's how to use it
	 * 
	 * <br /><br />
	 * 
	 * <code>
	 * &lt;[COMPONENT NAMESPACE]:[COMPONENT] [INSTANCE NAMESPACE]:id="myInstanceID" /&lt;
	 * </code>
	 * 
	 * <br /><br />
	 * 
	 * Example:
	 * 
	 * <code>
	 * &lt;component:Canvas instance:id="myCanvas" /&lt;
	 * <br/>
	 * &lt;component:Tween instance:id="canvasTween" target="{myCanvas}" property="y" start="{myCanvas.y}" stop="1000" duration="100" /&lt;
	 * </code>
	 */
	 
	public class InstanceModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        private const INSTANCE_REGEX:RegExp = /(?<=\().*?(?=\))/xi;
        
        
        private var _nodeIDs:Dictionary;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		 
		public function InstanceModule(ns:String = "")
		{
			super(ns);

			nodeEvaluator.addHandler("id",setInstanceId);
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
        	return [ModuleType.PROPERTY_NAME];
        }
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        /**
         */
        
        //private function getInstance
        /**
		 */
		
		private function setInstanceId():void
		{
			
			evaluatedNode.addEventListener(FMLEvent.MODULES_EVALUATED,onNodeComplete);	
			
		}
		
		/**
		 */
		
		private function onNodeComplete(event:FMLEvent):void
		{
			
			var node:BridgeNode = event.target as BridgeNode;
			
			node.removeEventListener(FMLEvent.COMPLETE,onNodeComplete);
			
			new Instance(node,this);
			
			
		}
		
		

	}
}
	import com.bridge.node.BridgeNode;
	import flash.events.Event;
	import com.ei.utils.WeakReference;
	import com.bridge.module.component.ComponentModule;
	import com.bridge.utils.NamespaceUtil;
	import com.bridge.events.FMLEvent;
	import com.bridge.module.component.InstanceModule;
	

	class Instance
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _node:BridgeNode;
		private var _id:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function Instance(node:BridgeNode,mod:InstanceModule)
		{
			_node = node;
			
			
			

			var idAttr:String = NamespaceUtil.addNamespace(mod.moduleNamespace,"id");
			
			
			_id = node.originalAttributes[ idAttr ];

			
			var compModule:ComponentModule = node.getUsedModule(ComponentModule) as ComponentModule;
			
			
			
			
			if(!compModule)
				return;
				
			
			var nodeInstance:* = compModule.getInstance(BridgeNode(node));
									  
			node.addVariable(_id,new WeakReference(nodeInstance));
			
			
			//destroy the instance
			node.addEventListener(Event.REMOVED,onNodeRemoved);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		private function onNodeRemoved(event:Event):void
		{
			event.target.removeEventListener(event.type,onNodeRemoved);
			
			_node.addVariable(_id,null);
			
			
		}
	}