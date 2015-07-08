package com.bridge.ui.style.ast.styleName.property
{
	import com.ei.as3Parser.ast.VarRefExpression;
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTreeNode;
	
	public class ColorExpression extends ExpressionTreeNode
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ColorExpression(buffer:String,table:LexemeTable,symboltable:SymbolTable)
		{
			super(buffer,table,symbolTable);
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
			
			if(char == "#")
			{
				char = table.scanner.nextChar();
				
				var buf:String = new String();
				
				while(VarRefExpression.isVar(char) && table.scanner.hasNext)
				{
					buf += char;
					
					char = table.scanner.nextChar();
				}
				
				table.scanner.pos--;
				
				return buf;
			}
			
			return null;
		}
		
		/**
		 */
		override public function evaluate():void
		{
			result = new Number("0x"+this.buffer);
		}

	}
}