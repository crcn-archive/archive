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
	import com.ei.utils.ClassDefinition;
	import com.ei.utils.simpleObject.SimpleObject;
	
	
	/**
	 * changes a property of a particular instance. Use it as such:
	 * <br/><br/>
	 * <code>
	 * &lt;[NAMESPACE]:property target="{my target}" property="new value" property2="new value 2" />
	 * </code>
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * <code>
	 * &lt;change:property target="{sprite}" x="100" y="100" /&gt;
	 * </code>
	 */
	 
	public class ChangeComponentPropertyModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ChangeComponentPropertyModule(ns:String = "")
		{
			super(ns);
			
			nodeEvaluator.addHandler("property",changeProperty);
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
		
		private function changeProperty():void
		{
			
			trace("CHANGE");
			
			var target:Object   = evaluatedNode.attributes.target;
			
			if(target == null)
				return;
				
			
			var def:ClassDefinition = new ClassDefinition(target);
			var sim:SimpleObject    = new SimpleObject(def);
			
			for(var i:String in evaluatedNode.attributes)
			{
				if(i != "target")
				{
					
					sim.setProperty(i,evaluatedNode.attributes[i]);
				}
			}
			
			
			
			
		
			
		}
	}
}