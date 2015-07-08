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
	import com.bridge.core.BridgeModule;
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.NamespaceUtil;
	
	import flash.external.ExternalInterface;
	import flash.utils.getDefinitionByName;
	
	
	/**
	 * registers modules to be used in the bridge application. Use it as such:
	 * 
	 * <br/><br/>
	 * <code>
	 * &lt;someNode [XMLNS NAMESPACE]:[NEW COMPONENT NAMESPACE]="path.to.module" /&gt;
	 * </code>
	 * <br/><br/>
	 * Example:
	 * &lt;Bridge xmlns:view="com.bridge.module.component.ComponentModule" xmlns:node="com.bridge.module.NodeModule" /&gt;
	 * <br/><br/>
	 */
	 
	public class XMLNSModule extends EvaluableModule
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _namespace:String;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function XMLNSModule(ns:String = "")
		{
			super(ns);
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
        	return [ModuleType.PROPERTY_NAME];
        }
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		override public function evalNode(value:BridgeNode,property:* = null):void
		{
			
			var reg:RegExp = new RegExp(moduleNamespace+":(?=[^=]*)");
			
			var moduleNS:String;
			var module:BridgeModule;
			var moduleDef:Class;
			
			if(NamespaceUtil.hasNamespace(moduleNamespace,property))
			{
				moduleNS = NamespaceUtil.removeNamespace(moduleNamespace,property);
				
				
				moduleDef = getDefinitionByName(value.attributes[ property ]) as Class;
				module    = new moduleDef(moduleNS);
				value.addModule(module);
			}

			
		}
		
		
		
		

	}
}