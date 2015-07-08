package com.bridge.ui.style.ast.styleName.property
{
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTreeNode;
	
	public class ColonExpression extends ExpressionTreeNode
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ColonExpression(buffer:String,lexemeTable:LexemeTable,symbolTable:SymbolTable)
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
			
			if(char == ":")
				return char;
			
			return null;
		}

	}
}