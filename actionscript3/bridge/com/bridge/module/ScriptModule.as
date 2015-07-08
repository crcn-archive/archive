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
	import com.ei.eval.RootExpression;
	
	import flash.utils.Dictionary;

	/**
	 * compiles, and parse runtime actionscript code. Use it as such:
	 * <br/><br/>
	 * <code>
	 * &lt;[AS NAMESPACE]:script&gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;[CDATA[
	 * <br/>
	 * &nbsp;&nbsp;&nbsp;//code
	 * <br/>
	 * &nbsp;&nbsp;]]&gt;
	 * <br/>
	 * &lt;/[AS NAMESPACE]:script&gt;
	 * </code>
	 * 
	 * <br/><br/>
	 * 
	 * Example:
	 * 
	 * <br/><br/>
	 * <code>
	 * &nbsp;&nbsp;&lt;action:script&gt;
	 * <br/>
	 * &nbsp;&nbsp;&nbsp;&lt;[CDATA[
	 * <br/>
	 * &nbsp;&nbsp;&nbsp;&nbsp;trace('Hello World!');
	 * <br/>
	 * &nbsp;&nbsp;&nbsp;]]&gt;
	 * <br/>
	 * &nbsp;&nbsp;&lt;/action:script&gt;
	 * <br/>
	 */
	public class ScriptModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _compiled:Dictionary;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        
		public function ScriptModule(ns:String = "")
		{
			super(ns);
			
			nodeEvaluator.addHandler("script",addScript);
			_compiled = new Dictionary();
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
		
		private function addScript():void
		{
			var comp:RootExpression = _compiled[evaluatedNode];
			
			
			//if the script is already compiled, then just re-evaluate the code
			if(comp)
			{
				comp.evaluate();
				return;
			}
			
			

			if(evaluatedNode.hasChildNodes())
			{
				
				var script:String = evaluatedNode.firstChild.nodeValue;
			
				//scripts don't need functions to run so evaluate it
				
				var compiled:RootExpression = evaluatedNode.nodeLibrary.valueParser.compile(script);
				
				
				_compiled[evaluatedNode] = compiled;
				
				
				compiled.evaluate();
			}
			
		}

	}
}