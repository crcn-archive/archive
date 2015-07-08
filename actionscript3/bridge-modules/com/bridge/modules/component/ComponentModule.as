package com.bridge.modules.component
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.libraries.*;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.ComponentClassDefinition;
	import com.bridge.utils.NamespaceUtil;
	import com.ei.utils.*;
	import com.ei.utils.simpleObject.*;
	
	import flash.utils.Dictionary;
	
	
	
	public class ComponentModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        //instances can be shared across different Component Modules
        private var _instances:Dictionary; //WAS STATIC
        
        private var _currentInstance:SimpleObject;
        private var _componentBuilder:ComponentBuilder;
        
        
        //directions for classes instantiated so the componentModule
        //can handle the class properly
        private var _classDefinitions:Object; //WAS STATIC
        
        private var _routedInstances:Object; //WAS STATIC
        
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
			
			
			if(_instances == null)
			{
				_instances		  = new Dictionary();
				_routedInstances  = new Object();
				_classDefinitions  = new Object();
			
			}
				
			
			_componentBuilder = new ComponentBuilder();
			
			nodeEvaluator.addHandler("classDefinition",addClassDefinition);
			nodeEvaluator.addHandler("route",addRouteNode);
			
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
			
			
			//trace(NamespaceUtil.removeNamespace(moduleNamespace,node.nodeName));
			
			//trace(def,node,_classDefinitions[node.nodeName]);
			
			//trace(def.returnInstance,"GO");
			
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
			//retrieve the class definition
			//retrieve the class definition
			var definition:ComponentClassDefinition = _classDefinitions[  NamespaceUtil.addNamespace(this.moduleNamespace,evaluatedNode.nodeName) ];
			
			
			var newInstance:SimpleObject = getSampleInstance(evaluatedNode);
			
			
			
			trace("ComponentModule::createNewInstance("+evaluatedNode.nodeName+")"+newInstance.instance);
			
			//check if any of the children are properties of the component. this is mostly for photoshop
			
			
			
			//trace(evaluatedNode);
			
			
			/*if(evaluatedNode.implementor is DisplayObject && newInstance.instance is DisplayObject)
			{
				evaluatedNode.implementor.addChild(newInstance.instance);
			}
			else*/
			
			//trace(evaluatedNode.parentNode.getUsedModule(ComponentModule));
			
			
			
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
				
				if(prop)
				{
					parentNode.setProperty(prop,newInstance.instance);
				}
				else
				{
					try{
						parentNode.setProperty(definition.childHandler,newInstance.instance);
						
					}catch(e:*){
						//trace("COMPMOD "+evaluatedNode+" "+e);
					}
				}
			}
			
				
			if(definition.childHandler && definition.passRawChildren)
			{
				
				evaluatedNode.pause();
				if(evaluatedNode.childNodes.length > 0)
					newInstance.setProperty(definition.childHandler,evaluatedNode.childNodes.join(""));
			}
			
			
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
			trace("ComponentModule::route node");
			
			var target:Object = evaluatedNode.attributes.target;
			var name:String   = evaluatedNode.attributes.nodeName;
			
			this.setRouterNode(name,new ComponentClassDefinition(target));
		}
		
		

	}
}