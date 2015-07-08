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
	
	
	/**
	 * Sets a variable to be used throughout the application. Use it as such:
	 * <br/><br/>
	 * <code>
	 * &lt;[VARIABLE NAMESPACE]:set name="variableName" value="variableValue" /&gt;
	 * </code>
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * <code>
	 * &lt;variable:set name="someVar" value="{Math.random()*9000}" /&gt;
	 * </code>
	 */
	public class VariableModule extends EvaluableModule
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 * Constructor for the Variable Module.
		 */
		 
		public function VariableModule(ns:String = "")
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("set",addVariable);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
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
		
		private function addVariable():void
		{
			
			var varName:String  = evaluatedNode.attributes.name;
			var varValue:Object = evaluatedNode.attributes.value;
			
			evaluatedNode.addVariable(varName,varValue);
			
		}

	}
}