package com.bridge.ui.style.ast.styleName.property
{
	import com.ei.as3Parser.ast.SemiColonExpression;
	import com.ei.as3Parser.ast.VarRefExpression;
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTree;
	import com.ei.eval.ast.ExpressionTreeNode;
	import com.ei.eval.util.ExpressionUtil;
	
	public class PropertyNameExpression extends ExpressionTree
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PropertyNameExpression(buffer:String,lexemeTable:LexemeTable,symbolTable:SymbolTable)
		{
			super(buffer,lexemeTable,symbolTable);
			
			
			ExpressionUtil.scanAll(this,SemiColonExpression);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
        override public function evaluate():void
		{
			this.hasResult = false;
			
			
			var currentLex:ExpressionTreeNode = this.firstNode;
			
			
			var data:Array = [];
			
			while(currentLex)
			{
				if(currentLex.buffer == "," || currentLex.buffer == ";" || currentLex.buffer == ":")
				{
					currentLex = currentLex.nextSibling as ExpressionTreeNode;
					continue;
				}
				currentLex.evaluate();
				
			
				data.push(currentLex.result);
				
				currentLex = currentLex.nextSibling as ExpressionTreeNode;
				
				
			}
			
			var newData:Object;
			
			//data is array: background-colors:#FF6600,#000000;
			if(data.length == 1)
			{
				newData = data[0];
			}
			else
			{
				newData = data;
			}
			this.symbolTable.setVariable(this.buffer,newData);
			
			result = newData;
			
		}
		
        /**
		 */
		
		public static function test(table:LexemeTable):String
		{
			return VarRefExpression.test(table);
			
		}

	}
}