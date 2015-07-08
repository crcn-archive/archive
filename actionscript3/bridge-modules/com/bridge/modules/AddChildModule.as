/******************************************************************
 * AddChildModule - adds a display object to any target specified													
 *  
 * Author: Craig Condon
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

package com.bridge.modules
{
	import com.bridge.node.IBridgeNode;
	import com.bridge.core.ModuleType;
	import flash.display.DisplayObject;
	import com.bridge.core.BridgeModule;
	import com.bridge.core.EvaluableModule;
	import com.bridge.modules.component.ComponentModule;
	
	
	
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
			
			
			nodeEvaluator.addHandler("addChild",addChild);
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
			var target:* = evaluatedNode.attributes["target"];
			
			
			
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
		
		private function getNearestDisplayObject(node:IBridgeNode):DisplayObject
		{
			
			
			for each(var module:BridgeModule in node.usedModules)
			{
				if(module is ComponentModule)
				{
					var inst:* = ComponentModule(module).getInstance(node);

					if(inst is DisplayObject)
					{
						return inst;
					}
					
					break;
				}
			}
			
			if(node.parentNode != null)
				return getNearestDisplayObject(node.parentNode);
				
			return null;
			
		}

	}
}
