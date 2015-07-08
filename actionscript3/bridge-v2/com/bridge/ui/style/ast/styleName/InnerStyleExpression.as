package com.bridge.ui.style.ast.styleName
{
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTree;
	import com.ei.eval.util.ExpressionUtil;
	
	public class InnerStyleExpression extends ExpressionTree
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function InnerStyleExpression(buffer:String,lexemeTable:LexemeTable,symbolTable:SymbolTable)
		{
			super(buffer,lexemeTable,symbolTable);
			
			ExpressionUtil.scanAll(this);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public static function test(lexemeTable:LexemeTable):String
		{
			var char:String = lexemeTable.scanner.nextChar();
			
			if(char == ">")
			{
				return char;
			}
			
			return null;
		}

	}
}