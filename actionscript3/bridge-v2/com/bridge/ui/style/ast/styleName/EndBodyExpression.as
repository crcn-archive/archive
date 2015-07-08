package com.bridge.ui.style.ast.styleName
{
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTreeNode;
	
	public class EndBodyExpression extends ExpressionTreeNode
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function EndBodyExpression(buffer:String,lexemeTable:LexemeTable,symbolTable:SymbolTable)
		{
			super(buffer,lexemeTable,symbolTable);
			
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
			
			if(char == "}")
			{
				return char;
			}
			
			return null;
		}

	}
}