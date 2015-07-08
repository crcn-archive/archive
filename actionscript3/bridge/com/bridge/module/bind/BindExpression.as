package com.bridge.module.bind
{
	import com.ei.as3Parser.ast.VarRefExpression;
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTree;
	
	
	/**
	 * the Lexeme injected into the runtime Actionscript parser that handles data-bound variables
	 */
	 
	public class BindExpression extends ExpressionTree
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BindExpression(buffer:String,scanner:LexemeTable,symbolTable:SymbolTable)
		{
			super(buffer,scanner,symbolTable);
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
			
			
			
			var module:BindableModule = scan.previousLexeme.symbolTable.getVariable(Binder.BIND_MODULE);
			
			var variableName:String = VarRefExpression.testName(scan);
			var testStack:Array = new Array();
			
			
			//trace(variableName);
			
			while(variableName)
			{
				testStack.push(variableName);
				
				if(scan.scanner.nextChar() != ".")
					break;
				variableName = VarRefExpression.testName(scan);
			}
			if(!variableName)
				return null;
				
			module.isBound(testStack);
			
			
			
			//never pass true, this lexical anylizer only checks if used
			//instances are bound
			return null;
		}

	}
}