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
	import com.bridge.module.component.ComponentModule;
	import com.bridge.node.BridgeNode;
	
	import flash.display.DisplayObject;
	
	
	
	public class AddChildModule extends EvaluableModule
	{
		
		//include '../utils/private.as';
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function AddChildModule(ns:String = "")
		{
			super(ns);
			
			
			nodeEvaluator.addHandler("child",addChild);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
         * addChild can only be accessed through the node name property
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
         * called when "addChild" is found in the node name
		 */
		
		private function addChild():void
		{
			
			
			//retrieves the child instance
			var child:*  = evaluatedNode.attributes["child"];
			
			//retrieve the target to apply the child to
			var target:* = evaluatedNode.attributes["parent"];
			
			
			
			//if the target does not exist then find the nearest
			//parent to add the child to
			if(!target)
			{
				
				/*if(evaluatedNode.parentNode.implementor != null)
				{
					evaluatedNode.parentNode.implementor.addChild(child);
				}
				else
				{*/
					target = getNearestDisplayObject(evaluatedNode);
					
					if(target)
					{
						target.addChild(child);
					}
				//}
				
			}
			else
			{
				target.addChild(child);
			}
		}
		
		/**
		 */
		
		private function getNearestDisplayObject(node:BridgeNode):DisplayObject
		{
			
			var mod:ComponentModule = node.getUsedModule(ComponentModule) as ComponentModule;
			
			var inst:* = mod.getInstance(node);
			
			if(inst is DisplayObject)
			{
				return inst;
			}
			
			if(node.parentNode != null)
				return getNearestDisplayObject(node.parentNode);
				
			return null;
			
		}

	}
}
