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
 
package com.bridge.eval.ast
{
	import com.bridge.core.BridgeModule;
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.OperationalModule;
	import com.ei.as3Parser.ast.IFunctionExpression;
	import com.ei.as3Parser.ast.VarRefExpression;
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTree;
	import com.ei.eval.ast.ExpressionTreeNode;
	import com.ei.patterns.observer.Notification;
	
	import flash.events.Event;
	
	public class ModuleExpression extends ExpressionTree implements IFunctionExpression
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _namespace:String;
        private var _property:String;
        private var _parameters:ExpressionTree;
        private var _handler:EvaluableModule;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ModuleExpression(buffer:String,scanner:LexemeTable,table:SymbolTable)
		{
			super(buffer,scanner,table);
			
			init();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		/**
		 */
		
		public static function test(scan:LexemeTable):String
		{
			var char:String = scan.scanner.nextChar();
			
			var ns:String;
			var property:String;
			var params:String;
			
			if(char == "#")
			{
				return char;
			}
			
			return null;
		}
		
        /**
		 */
		 
		 public function callFunction(...params:Array):*
		 {
		 	return null;
		 }
		 
		 /**
		  */
		 
		 override public function evaluate():void
		 {
			
			hasResult = false;
			
			var modules:* = this.symbolTable.getVariable(_namespace);
			
			var handler:EvaluableModule;
			
			if(modules is Array)
				for each(var module:BridgeModule in modules)
				{
					if(handleModule(module))
						break;
				}
			else
				handleModule(modules)
			
			
			
		 	/*var modules:Array = BridgeNode.getRegisteredModule(_namespace);

		 	var handler:EvaluableModule;
		 	
		 	for each(var module:BridgeModule in modules)
		 	{
		 		if(module is EvaluableModule)
		 		{

		 			if(EvaluableModule(module).hasHandler(_property))
		 			{
		 				_handler = EvaluableModule(module);
		 				break;
		 				
		 			}
		 		}
		 	}
			*/
		 	
		 	_parameters.evaluate();
		 	
		 	
		 	if(!_parameters.hasResult)
		 	{
		 		_parameters.registerObserver(Notification.COMPLETE,onParametersComplete);
		 	}
		 	else
		 	{
		 		completeParameters();
		 	}
		 }
		 
		 
		 private function handleModule(module):Boolean
		 {
		 	if(module is EvaluableModule)
			{
				if(module is OperationalModule && OperationalModule(module).hasRegisteredFunction(_property))
				{
					_handler = EvaluableModule(module);
					return true;
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
		
		private function init():void
		{
			
			_namespace = getFullCommand();
			var next:String = lexemeTable.scanner.nextChar();
				
			if(next == ":")
			{
				_property   = getFullCommand();
				
			}
			else
			{
				lexemeTable.scanner.pos--;
				_property = _namespace;
				_namespace = "";
			}
			
			
			
			_parameters = ExpressionTree(lexemeTable.nextLexeme(symbolTable));
			
			
			
		}
		
		/**
		 */
		
		private function getFullCommand():String
		{
			var name:String = VarRefExpression.test(lexemeTable);
			
			var nex:String = lexemeTable.scanner.nextChar()
			
			if(nex == ".")
			{
				name += nex + getFullCommand();
			}
			else
			{
				lexemeTable.scanner.pos --;
			}
			
			
			
			return name;
		}
		
		/**
		 */
		
		private function onParametersComplete(event:Notification):void
		{
			event.target.removeObserver(event.type,onParametersComplete);
			
			completeParameters();
		}
		
		/**
		 */
		
		private function completeParameters():void
		{
			
			var params:Array = new Array();
			
			var node:ExpressionTreeNode = _parameters.firstNode;
			
			while(node != null)
			{

				if(node.buffer != ",")
					params.push(node.result);
		 	
				node = ExpressionTreeNode(node.nextSibling);
			}
			
			if(_handler is OperationalModule)
			{
				_handler.addEventListener(Event.COMPLETE,onNodeComplete);
				
				OperationalModule(_handler).callFunction(_property,params);
				
				//LISTEN FOR WHEN HANDLER IS COMPLETE
			}
		}
		
		/**
		 */
		
		private function onNodeComplete(event:Event):void
		{
			
			event.target.removeEventListener(Event.COMPLETE,onNodeComplete);

			result = event.target.result;
		}

	}
}