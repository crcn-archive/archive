package com.bridge.ui.style.ast
{
	import com.bridge.ui.style.Style;
	import com.bridge.ui.style.ast.styleName.EndBodyExpression;
	import com.bridge.ui.style.ast.styleName.StartBodyExpression;
	import com.ei.as3Parser.ast.VarRefExpression;
	import com.ei.eval.LexemeTable;
	import com.ei.eval.SymbolTable;
	import com.ei.eval.ast.ExpressionTree;
	import com.ei.eval.util.*;
	import com.ei.utils.ObjectUtils;
	
	public class StyleNameExpression extends ExpressionTree
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


       public var requiredParents:Array;
       
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function StyleNameExpression(buffer:String,lexemeTable:LexemeTable,symbolTable:SymbolTable)
		{
			super(buffer,lexemeTable,symbolTable);
			
			ExpressionUtil.scanAll(this,EndBodyExpression);
			
			
			requiredParents = new Array();
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
			hasResult = false;
			
			
			var newStyle:Style = new Style();
			
			var currentLex:ExpressionTree = this;
			
			
			var currentLex:ExpressionTree = this.firstNode as ExpressionTree;
			
			
			if(!(currentLex is StartBodyExpression))
			{
				if(currentLex.buffer == ",")
				{
					currentLex.firstNode.evaluate();
					
					
					currentLex = ExpressionTree(currentLex.firstNode).firstNode as ExpressionTree;
					
					
					
				}
				else
				if(currentLex.buffer = ">")
				{
					currentLex = currentLex.firstNode as StyleNameExpression;
					
					requiredParents.push(this.buffer);
					
					StyleNameExpression(currentLex).requiredParents = requiredParents;
					currentLex.evaluate();
					
					result = this.buffer;
					
					return;
				}
				
				//find the body
				while(!(currentLex is StartBodyExpression))
				{
					currentLex = currentLex.firstNode as ExpressionTree;	
				}
				
			}
			
			currentLex.evaluate();
			
			var properties:Object = new Object();
			
			currentLex.symbolTable.copy(properties);
			
			
			for(var key:String in properties)
			{
				newStyle.setProperty(key,properties[key]);
			}
			
			newStyle.requiredParents = requiredParents;
			
			var exStyle:Array = this.symbolTable.getVariable(this.buffer);
			
			var styleData:Array = [newStyle];
			
			if(exStyle)
			{
				styleData = styleData.concat(exStyle);
			}
			
			
			//don't merge since some styles may require parent types ex: Canvas > ContentWindow
			this.symbolTable.setVariable(this.buffer,styleData);
			
			
			result = this.buffer;
			
		}
		
        /**
		 */
		
		public static function test(table:LexemeTable):String
		{
			var firstChar:String = table.scanner.nextChar();
			
			var nextPart:String;
			
			
			if(VarRefExpression.isVar(firstChar) || firstChar == "#" || firstChar == ".")
			{
				nextPart = VarRefExpression.test(table);
				if(nextPart)
					firstChar += nextPart;
				else
					table.scanner.pos--;
					
				return firstChar;
			}
			
			return null;
		}

	}
}