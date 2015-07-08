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

//MESSY

package com.bridge.module.bind
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.module.component.ComponentModule;
	import com.bridge.node.BridgeNode;
	import com.ei.as3Parser.AS3Parser;
	import com.ei.eval.VariableProxy;
	import com.ei.eval.VariableProxyListener;
	import com.ei.eval.ast.ExpressionTree;
	import com.ei.utils.ArrayUtils;
	import com.ei.utils.simpleObject.SimpleObject;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	
	/**
	 * Binds variables so when they are used by other nodes, those nodes value change when the data-bound variable changes. Use it as such:
	 * 
	 * <br /><br />
	 * 
	 * <code>
	 * 		<br />
	 * 		&lt;[BOUND NAMESPACE]:target instance="boundInstance" /&gt;
	 * 		<br /><br />
	 * 		//note the following is now data bound
	 * 		<br />
	 * 		&lt;view:Canvas x="{boundInstance.x}" /&gt;
	 * </code>
	 * 
	 * <br /><br />
	 * 
	 * The bound variable is actually replaced with a proxy, and to listen for any changes without data-binding you can listen to that proxy.
	 * Here's an example:
	 * 
	 * <br /><br />
	 * 
	 * <code>
	 * 		&lt;observer:listen to="{boundInstance.proxylistener} for="change"&gt;
	 * 			<br />
	 * 			&nbsp;&nbsp;//access the changed variable
	 * 			<br />
	 * 		&lt;/observer:listen&gt;
	 * </code>
	 * 
	 */
	 
	public class BindableModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _bindedInstances:Array;
		private var _actionscript:AS3Parser;
		private var _listeners:Array;
		private var _binds:Dictionary;
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BindableModule(ns:String = "")
		{
			super(ns);
			this.nodeEvaluator.addHandler("target",bindTarget);
			
			//use a compiler so we can match the lexical values 
			_actionscript = new AS3Parser();
			
			_binds = new Dictionary();
			_listeners = new Array();
			
			_bindedInstances = new Array();
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
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function isBound(lexSample:Array):Boolean
		{
			var nextSibling:String;
			
			var breakCheck:Boolean;
			
			var currentNode:BridgeNode;
			
			for each(var binds:Array in _bindedInstances)
			{
				
				breakCheck = false;
				
				
				for each(var property:String in binds)
				{
					if(lexSample.indexOf(property) == -1)
					{
						breakCheck = true;
						break;
						
					}
					
				}
				
				if(!breakCheck)
				{
					
					currentNode = evaluatedNode.rootNode.currentNode;
					
					
					if(_binds[binds] == null)
					{
						_binds[binds] = new Array();
					}
					
					if(_binds[binds].indexOf(currentNode) == -1)
					{
						
						for(var prop:String in currentNode.originalAttributes)
						{
							
							//example: x="{loadManager.percentLoaded}%" NOT x="{instance.x = 50}" = infinite loop
							
							if(currentNode.originalAttributes[prop].indexOf(lexSample.join(".")) > -1)
							{
								_binds[binds].push({prop:prop,node:currentNode});
								
							}
						}
					}
				}
			}
			return false;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function bindTarget():void
		{
			var compiled:Array = evaluatedNode.attributes.instance.split(".");
			_bindedInstances.push(compiled);
			
			
			var instanceName:String = compiled[0];
			
			
			//add the module to the symbolTable
			var instance:Object = evaluatedNode.getVariable(instanceName);
			
			var listener:VariableProxyListener = new VariableProxyListener();
			listener.addEventListener(Event.CHANGE,onTargetChange);
			_listeners.push(listener);	
			evaluatedNode.addVariable(instanceName,new VariableProxy(instance,listener));
			
			if(!evaluatedNode.getVariable(Binder.BIND_MODULE))
			{
				
				evaluatedNode.addVariable(Binder.BIND_MODULE,this);
				
				//icky
				//trace(evaluatedNode.nodeLibrary.valueParser.lexemeTable.lexemes);
				evaluatedNode.nodeLibrary.valueParser.lexemeTable.registerLexeme(BindExpression,null,1);
				
				//trace(evaluatedNode.nodeLibrary.valueParser.lexemeTable.lexemes);
			}
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onTargetChange(event:Event):void
		{
			
			var index:int = _listeners.indexOf(event.target);
			
			
			var binded:Array = _binds[_bindedInstances[index]];
			
			var comp:ComponentModule;
			var expr:ExpressionTree;
			var inst:SimpleObject;
			
			for each(var info:Object in binded)
			{
				
				
				
				var seg = info.node.nodeLibrary.valueParser.getSegmentParser();
				
				seg.eval(info.node.originalAttributes[info.prop]);
			
				
				
				comp = info.node.getUsedModule(ComponentModule) as ComponentModule;
				
				
				//we grab the simple object because some binded properties MIGHT be methods
				inst = comp.getSimpleObject(info.node);
				
				if(inst)
				{
					inst.setProperty(info.prop,seg.result);
				}
				
			}
		}

	}
}