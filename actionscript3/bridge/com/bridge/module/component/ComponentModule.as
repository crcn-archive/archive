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
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.ComponentClassDefinition;
	import com.bridge.utils.NamespaceUtil;
	import com.ei.utils.*;
	import com.ei.utils.simpleObject.*;
	
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	/**
	 * The Component Module registers classes into the application so they can be used. It is used in a few ways. The first is importing classes:
	 * 
	 * <br /><br />
	 * 
	 * <code>
	 * &lt;[NAMESPACE]:classDefinition source="path.to.class"&gt;
	 * <br/>
	 * &nbsp;&nbsp;//optional
	 * <br/>
	 * &nbsp;&nbsp;&lt;process childHandler="method/property to handle (optional)" passRawChildren="true of false (optional)" /&gt;
	 * <br />
	 * &nbsp;&nbsp;&lt;constructor&gt;
	 * <br/>
	 * &nbsp;&nbsp;&nbsp;&lt;param name="param name(required)" value="default value (optional)" /&gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;/constructor&gt;
	 * <br/>
	 * &nbsp;&nbsp;//optional
	 * <br/>
	 * &nbsp;&nbsp;&lt;property name="property name=" value="default value (optional)" /&gt;
	 * <br />
	 * &lt;/[NAMESPACE]:classDefinition&gt;
	 * </code>
	 * 
	 * <br/><br/>
	 * 
	 * to instantiate any imported class, use the following syntax:
	 * 
	 * <br/><br/>
	 * 
	 * <code>
	 * &lt;[NAMESPACE]:[COMPONENT] [PROPERTY NAME]="value" [CONSTRUCTOR PARAM NAME]="value" /&gt;
	 * </code>
	 */
	
	public class ComponentModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        //instances can be shared across different Component Modules
        private var _instances:Dictionary; //WAS STATIC
        private var _instanceByObj:Dictionary;
        
        private var _currentInstance:SimpleObject;
        private var _componentBuilder:ComponentBuilder;
        
        
        //directions for classes instantiated so the componentModule
        //can handle the class properly
        private var _classDefinitions:Object; //WAS STATIC
        
        private var _routedInstances:Object; //WAS STATIC
        
        //used to removed nodes once they've been executed
        private var _garbageCollect:Boolean;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ComponentModule(ns:String = "")
		{
			
			
			super(ns);
			
			_garbageCollect = true;

			_instances		   = new Dictionary(true);
			_instanceByObj     = new Dictionary(true);
			_routedInstances   = new Object();
			_classDefinitions  = new Object();
				
			_componentBuilder = new ComponentBuilder();
			
			nodeEvaluator.addHandler("classDefinition",addClassDefinition);
			nodeEvaluator.addHandler("addRoute",addRouteNode);
			
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
		
		/**
		 */
		
		public function get classDefinitions():Object
		{
			return _classDefinitions;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function testNode(node:BridgeNode):Boolean
		{
			return Boolean(_classDefinitions[node.nodeName]) || Boolean(_routedInstances[node.nodeName]);	
		}
		
		
        /**
		 */
		
		public function getInstance(node:BridgeNode):*
		{
			
			var def:ClassDefinition = ClassDefinition(_classDefinitions[node.nodeName]);
			
			
			try
			{
				var inst:* = _instances[ node ].getInstance();
			}
			catch(e:*)
			{
				return null;
			}
			
			if(def && def.returnInstance)
			{
				return inst[def.returnInstance];
			}
			if(_instances[ node ])
				return inst;
				
			
		}
		
		
		/**
		 */
		
		public function setInstanceValue(node:BridgeNode,value:*):void
		{
			var so:SimpleObject = _instances[node];
			var def:ClassDefinition = _classDefinitions[node.nodeName];

			if(node)
			{

				if(!def.assignInstance)
				{
					
					_instances[node] = so = new SimpleObject(new ComponentClassDefinition(value));
					
				}
				
				so.setProperty(def.assignInstance,value);
			}
		}
		
		/**
		 */
		
		public function getSimpleObject(node:BridgeNode):SimpleObject
		{
			return _instances[ node ];
		}
		
		/**
		 */
		
		public function getNode(instance:Object):BridgeNode
		{
			for(var inst:Object in _instances)
			{
			
				if(_instances[inst].instance == instance)
				{
					return inst as BridgeNode;
				}
			}
			
			return null;
		}
		
		/**
		 * for the root node
		 */
		
		public function setRouterNode(name:String,instance:ClassDefinition):void
		{
			
			nodeEvaluator.addHandler(name,routeNode);
			
			_routedInstances[ NamespaceUtil.addNamespace(moduleNamespace,name) ] = new SimpleObject(instance);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        
        /**
         * registers a class to the FMLNode variable library when callDefiniton is
         *  found in a node name
		 */
		 
		private function addClassDefinition():void
		{
			
			//build the class definition
			_componentBuilder.build(evaluatedNode);
			
			
			//integrate the module namespace so we dont have to pull it out each time a new 
			//instance is called
			
			var className:String = NamespaceUtil.addNamespace(this.moduleNamespace,_componentBuilder.className);
			
			
			//register the class definition so we can grab it later when the instance is called
			_classDefinitions[ className ] = _componentBuilder.definition;
			
			//trace(className,_componentBuilder.definition.returnInstance);
			
			
			//tell the nodeevaluator to look for any node with the class name specified
			
			
			nodeEvaluator.addHandler(_componentBuilder.className,createNewInstance);
		}
		
		/**
		 * called when an instance of the registered class is instantiated
		 * 
		 * NOTE: used in editableComponentModule so it returns the instance
		 */
		 
		protected function createNewInstance():SimpleObject
		{
			//trace("ComponentModule::createNewInstance()",evaluatedNode.nodeName,ObjectUtils.getLength(_instanceByObj),ObjectUtils.getLength(_instances));
			
			//retrieve the class definition
			//retrieve the class definition
			var definition:ComponentClassDefinition = _classDefinitions[  NamespaceUtil.addNamespace(this.moduleNamespace,evaluatedNode.nodeName) ];
			
			
			
			var newInstance:SimpleObject = getSampleInstance(evaluatedNode);
			
			if(_garbageCollect)
			{
				//wait until it's complete to remove the instance (needed for adding children)
				evaluatedNode.addEventListener(Event.REMOVED,onRemoved);
			}
			//evaluatedNode.addEventListener(Event.REMOVED,onRemoved);
			
			
			if(evaluatedNode.parentNode /*&& evaluatedNode.parentNode.getUsedModule(ComponentModule)*/)
			{
				
				
				var parentNode:SimpleObject = getNearestComponent(evaluatedNode.parentNode);
				
				
				var prop:String = evaluatedNode.attributes["comp:parentProperty"];
				
				//allows for the child node to set the property of the parent node
				
				/*
				
				<SimpleButton>
					<Image comp:parentProperty="upState" source="{source}" />
				</SimpleButton>
				
				*/
				
				if(definition.gcWhen)
				{
					newInstance.instance.addEventListener(definition.gcWhen,onGC,false,0,true);
				}
					
				if(prop)
				{
					parentNode.setProperty(prop,newInstance.instance);
					
				}
				else
				{
					try{
						parentNode.setProperty(parentNode.targetDefinition.childHandler,newInstance.instance);
						
					}catch(e:*){
						//trace("COMPMOD "+evaluatedNode+" "+e);
					}
				}
			}
			
				
			if(definition.childHandler && definition.passRawChildren)
			{
				
				//trace("ComponentModule::pass raw children");
				if(newInstance.instance is TextField)
				//trace(newInstance.instance.textColor,definition.childHandler);
				evaluatedNode.pause();
				if(evaluatedNode.childNodes.length > 0)
					newInstance.setProperty(definition.childHandler,evaluatedNode.childNodes.join(""));
			}
			
			_instanceByObj[ newInstance.instance ] = evaluatedNode;
			return _instances[ evaluatedNode ] = newInstance;
			
		}
		
		/**
		 */
		
		
		public function getSampleInstance(node:BridgeNode):SimpleObject
		{
			
			
			//for the router node
			if(_routedInstances[node.nodeName])
				return _routedInstances[node.nodeName];
				
			//retrieve the class definition
			var definition:ComponentClassDefinition = _classDefinitions[  NamespaceUtil.addNamespace(this.moduleNamespace,node.nodeName) ];
			
			
			
			//trace(NamespaceUtil.addNamespace(this.moduleNamespace,evaluatedNode.nodeName));
			//var definition:ComponentClassDefinition = _classDefinitions[  evaluatedNode.nodeName ];
			
			//with the definition, create a new instance of the object
			var newInstance:SimpleObject = new SimpleObject(definition);
			
			
			
			//set the attributes of the node
			for(var attr:String in node.attributes)
			{
			
				newInstance.setProperty(attr,node.attributes[ attr ]);
			}
			
			
			return newInstance;
		}
		
		/**
		 * looks beyond the node for any parent that might be a display object
		 */
		
		
		private function getNearestComponent(node:BridgeNode):*
		{

			//grab a direct reference instead of searching in the node to save time
			if(_instances[node])
				return _instances[node];
				

			else
			if(node == null)
				return null;
			else
			{
				return getNearestComponent(node.parentNode);
			}
		}
		
		/**
		 * reroutes nodes to specific instances 
		 */
		 
		private function routeNode():void
		{
			
			_instances[ evaluatedNode ] = _routedInstances[ evaluatedNode.nodeName ];
		}
		
		/**
		 */
		
		private function addRouteNode():void
		{
			var target:Object = evaluatedNode.attributes.target;
			var name:String   = evaluatedNode.attributes.nodeName;
			
			this.setRouterNode(name,new ComponentClassDefinition(target));
		}
		
		/**
		 */
		private function onGC(event:*):void
		{
			event.target.removeEventListener(event.type,onGC);
			
			var node:Object = this._instanceByObj[event.target];
			
			
			
			delete this._instances[node];
			delete this._instanceByObj[event.target];
			node = undefined;
			
			
			
			trace("ComponentModule::garbageCollecting");
			
			
		}
		
		/**
		 */
		private function onRemoved(event:Event):void
		{
			trace("ComponentModule::onRemoved()");
			var so:SimpleObject = _instances[event.currentTarget];
			
			//trace(event.target,inst,this._instanceByObj[inst],this._instances[inst]);
			
			if(so)
				delete this._instanceByObj[so.instance];
				
			delete this._instances[event.currentTarget];
			
			so = undefined;
		}
		
		

	}
}