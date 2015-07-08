package com.bridge.ui.style
{
	import com.bridge.ui.style.ast.*;
	import com.bridge.ui.style.ast.styleName.*;
	import com.bridge.ui.style.ast.styleName.property.*;
	import com.ei.as3Parser.AS3Parser;
	import com.ei.as3Parser.ast.ComaExpression;
	import com.ei.as3Parser.ast.SemiColonExpression;
	import com.ei.eval.LexemeTable;
	import com.ei.utils.info.ClassInfo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	
	public class CSS extends AS3Parser
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _styles:Object;
		private var _randomIndexes:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CSS()
		{
			super();
			
			var as3Lex:LexemeTable = this.lexemeTable;
			
			this._lexemeTable = new LexemeTable(as3Lex.scanner);
			
			//property
			var propValueLex:LexemeTable = new LexemeTable(as3Lex.scanner);
			propValueLex.registerLexeme(ColonExpression);
			propValueLex.registerLexeme(ColorExpression);
			propValueLex.registerLexeme(ComaExpression);
			propValueLex.registerLexeme(SemiColonExpression);
			
			propValueLex.lexemes = propValueLex.lexemes.concat(as3Lex.lexemes);
			
			
			
			var propNameLex:LexemeTable = new LexemeTable(as3Lex.scanner);
			propNameLex.registerLexeme(PropertyNameExpression,propValueLex);
			
			
			//style name
			var styleLex:LexemeTable = new LexemeTable(as3Lex.scanner);
			styleLex.registerLexeme(StartBodyExpression,propNameLex);//body containing properties
			styleLex.registerLexeme(StyleNameExpression,styleLex);
			styleLex.registerLexeme(GroupExpression,styleLex);//loop back
			styleLex.registerLexeme(InnerStyleExpression,styleLex);
			
			
			
			//start the style
			lexemeTable.registerLexeme(StyleNameExpression,styleLex);
			
			//end the style
			lexemeTable.registerLexeme(EndBodyExpression,lexemeTable);
			
			_styles = new Object();
		}
		
		/**
		 */
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function parse(script:String):void
		{
			compile(script).evaluate();
			
			
			var styles:Object = new Object();
			
			//copy the symbol table objects to the
			//styles
			symbolTable.copy(styles);
			
			//go through each of the styles and get the properties
			for(var style:String in styles)
			{
				
				if(!(styles[style] is Array))
					continue;
					
				if(!_styles[style])
				{
					_styles[style] = new Array();
				}
				
				
				//set the style to this CSS doc
				_styles[ style ] = _styles[style].concat(styles[style]);
				
			}
		}
		
        /**
         * grabs a style based on the class instance.
		 */
		
		public function getStyleByInstance(target:Object,strict:Boolean = false):Style
		{
			
			var baseStyle:Style = new Style();
			
			
			
			
			var info:ClassInfo = new ClassInfo(target);
			
			
			var extendedInfo:Array = info.extendedBaseInfo;
			var currentStyle:Style;
			
			//do not inherit properties if they exist. Doing so
			//may require any additional classes to re-write unwanted functionality such as contraints
			
			
			if(!getStyle(info.name))
				for(var i = extendedInfo.length-1; i >= 0; i--)
				{
					baseStyle.digest(getStyle(extendedInfo[i].name));
				}
			
			//finally get the style of the instance if it's available
			
			baseStyle.digest(getStyle(info.name));
			
			
			if(strict)
			{
				//trace(name,style.requiredParents);
				var parent:DisplayObject = Sprite(target).parent;
				
				var req:Style = this.getStyleRequired(info.name);
				
				var pinfo:ClassInfo;
				
				var ci:int = 1;
				
				if(req)
				while(parent)
				{
					
					pinfo = new ClassInfo(parent);
					
					var index:int = req.requiredParents.indexOf(pinfo.name);
					
					if(ci == req.requiredParents.length)
					{
						
						baseStyle.digest(req);
						break;
					}
						
					if(index == ci)
						ci++;
						
					
					
					
					parent = parent.parent;
					
				}
			}
			
			return baseStyle;
		}
		

		
		/**
		 * parses a style, not the whole document
		 */
		
		public function parseStyleBody(style:String):Style
		{
			var name:String = this.getRandomStyleName();
			
			this.parse(wrapStyle(name,style));
			
			return _styles[name][0];
		}
		
		/**
		 */
		 
		public function getStyle(name:String):Style
		{
			
			if(!_styles[name])
				return null;
				
			var newStyle:Style = new Style();
			
			for each(var style:Style in _styles[name])
			{
				if(style.requiredParents.length > 0)
					continue;
					
				newStyle.digest(style);
			}
			
			return newStyle;
		}
		
		/**
		 */
		public function getStyleRequired(name:String):Style
		{
			for each(var style:Style in _styles[name])
			{
				if(style.requiredParents.length > 0)
					return style;
					
			}
			
			return null;
		}
		
		
		
		/**
		 */
		
		
		public function getRandomStyleName():String
		{
			_randomIndexes++;
			
			var name:String = "style"+_randomIndexes;
			
			if(_styles[name])
			{
				return getRandomStyleName();
			}
			
			return name;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function wrapStyle(name:String,style):String
		{
			return name+"{"+style+"}";
		}
		

	}
}