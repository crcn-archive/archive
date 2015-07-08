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
	 * registers the node instance to be used throughout the application. Use as such:
	 * <br/><br/>
	 * <code>
	 * &lt;some:node [NAMESPACE]:id="myNodeId" /&gt;
	 * </code>
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * <code>
	 * &lt;component:Canvas node:id="canvasNode" /&gt;
	 * <br/>
	 * &lt;run script="{trace(canvasNode.nodeName);}" /&gt;
	 * <br/>
	 * </code>
	 */
	public class NodeInstanceModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function NodeInstanceModule(ns:String)
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("id",setID);
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
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function setID():void
		{
			
			var name:String = evaluatedNode.attributes[evaluatedProperty];
			
			evaluatedNode.nodeLibrary.valueParser.setVariable(name,evaluatedNode);
		}
		

	}
}