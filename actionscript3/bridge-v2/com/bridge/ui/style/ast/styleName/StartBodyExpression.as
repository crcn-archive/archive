package com.bridge.ui.style.ast.styleName
{
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTree;
	import com.ei.eval.util.ExpressionUtil;
	
	public class StartBodyExpression extends ExpressionTree
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function StartBodyExpression(buffer:String,lexemeTable:LexemeTable,symbolTable:SymbolTable)
		{
			super(buffer,lexemeTable,new SymbolTable(symbolTable));
			
			ExpressionUtil.scanAll(this);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
        /**
		 */
		
		public static function test(table:LexemeTable):String
		{
			var char:String = table.scanner.nextChar();
			
			if(char == "{")
			{
				return char;
			}
			
			return null;
		}

	}
}