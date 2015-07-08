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
 
package com.bridge.eval
{
	import com.bridge.eval.ast.ModuleExpression;
	import com.ei.as3Parser.AS3Parser;
	import com.ei.eval.IExpression;
	import com.ei.eval.ISymbolTable;
	import com.ei.eval.LexemeTable;
	import com.ei.eval.Parser;
	import com.ei.eval.RootExpression;
	import com.ei.eval.Scanner;
	import com.ei.eval.SymbolTable;
	
	import flash.events.EventDispatcher;
	
	public class CodeSegment extends EventDispatcher implements ISymbolTable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        //the pattern that searches a string for anything with curly brackets
        public static const STRING_PATTERN:RegExp = /{ ([^{}]+|(?R))+ }/gx;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _parser:Parser;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Constructor for the CodeSegment Class.
         */
		 
		public function CodeSegment()
		{	
			super();
			
			_parser = new AS3Parser();
			
			
			_parser.lexemeTable.registerLexeme(ModuleExpression);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		
		public function get scanner():Scanner
		{
			return _parser.lexemeTable.scanner;
		}
		
		/**
		 */
		public function get lexemeTable():LexemeTable
		{
			return _parser.lexemeTable;
		}
		
		/**
		 */
		
		public function get symbolTable():SymbolTable
		{
			return _parser.symbolTable;
		}
		
		/**
		 */
	
		public function set symbolTable(value:SymbolTable):void
		{
			_parser.symbolTable = value;
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 * isolates the current symbol table so that variables set are not global
		 */
		
		public function isolate():void
		{
			_parser.isolate();
		}
		/**
		 */
		
		public function getVariable(name:String):Object
		{
			
			return _parser.symbolTable.getVariable(name);
			
		}
		
		/**
		 */
		
		public function setVariable(name:String,value:Object = null,type:Class = null):void
		{
			_parser.symbolTable
			_parser.symbolTable.setVariable(name,value,type);
		}
		
		/**
         * Tests a value to see if it is a valid expression to parse.
         */
		public function test(value:*):Boolean
		{		
			
			if(value == null)
				return false;
			
			try
			{
				var match:Array = value.toString().match(STRING_PATTERN);
			}catch(e)
			{
				trace("CodeSegment:: ERROR="+e);
				return false;
			}

			if(!match)
				return false;
				
			
			return match.toString().length > 0;
		} 
		
		/**
		 */
		
		public function compile(value:String):RootExpression
		{
			return _parser.compile(value);
		}
		
		/**
		 */
		
		public function getSegmentParser():CodeEval
		{
			return new CodeEval(_parser);
		}
		
		
		


	}
}
	import com.bridge.eval.CodeSegment;
	import com.ei.as3Parser.AS3Parser;
	import com.ei.eval.IExpression;
	import com.bridge.eval.CodeBlock;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import com.ei.eval.Parser;
	import com.ei.utils.Cue;
	

	class CodeEval extends EventDispatcher implements IExpression
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _parser:Parser;
        private var _result:*;
        private var _rawCode:String;
        private var _hasResult:Boolean;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CodeEval(parser:Parser)
		{
			_parser = parser;
		}
		
		public function eval(value:*,bypass:Boolean = false):void
		{
			//_parser.dump();
			
			
			if(bypass)
			{
				_parser.compile(value).evaluate();
				return;
			}
			
			_rawCode = __result = value;
			
	
			var getMatch:Array = value.toString().match(CodeSegment.STRING_PATTERN);
			

			var newResult:* = value.toString();
			var parseResult:*;
			
			var newMatch:String;
			
			
			
			
			var queStack:Array = new Array();
			
			for each(var match:String in getMatch)
			{
				
				
				
				queStack.push( new CodeBlock(_parser,match) );
				
				
				/*newMatch = match.substr(1,match.length - 2);
				
				
	
				parseResult =  parseSyntax(newMatch);
				
				//return the value if the entire string has a bracket
				if(getMatch.toString().length == value.toString().length)
					return parseResult;
					
				newResult = newResult.replace(match,parseResult);	*/
				
			}
			
			if(queStack.length > 0)
			{
				var que:Cue = new Cue(Event.COMPLETE,onCue);
				que.addEventListener(Event.COMPLETE,onCueComplete);
				que.setStack(queStack);
				que.start();
				
			}
			else
			{
				__result = value;
			}
			
			
			
			
			//return newResult;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function get result():*
		{
			return _result;
		}
		
		/**
		 */
		
		public function get hasResult():Boolean
		{
			return _hasResult;
		}
		
		/**
		 */
		protected function set __result(value:*):void
		{
			_result    = value;
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function getVariable(name:String):Object
		{
			
			return _parser.symbolTable.getVariable(name);
			
		}
		
		/**
		 */
		
		public function setVariable(name:String,value:Object = null,type:Class = null):void
		{
			_parser.symbolTable.setVariable(name,value,type);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		private function onCue(current:CodeBlock):void
		{
			
			current.addEventListener(Event.COMPLETE,onBlockComplete,false,1);
			current.eval();
		}
		
		/**
		 */
		
		private function onBlockComplete(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE,onBlockComplete);

			var block:String  = event.target.block;
			var blockResult:* = event.target.result;
			
			
			if(block == _rawCode)
			{
				__result = blockResult;
			}
			else
			{
				try
				{
					__result = _result.toString().replace(block,blockResult);
					
				}catch(e:*)
				{
					trace("CodeSegment::onBlockComplete FIX THIS BANDAID!!!!");
				}
			}
			
		}
		
		/**
		 */
		
		private function onCueComplete(event:Event):void
		{
			
			_hasResult = true;
			
			event.target.removeEventListener(Event.COMPLETE,onCueComplete);
			
			
			dispatchEvent(new Event(Event.COMPLETE));
			
			
			
		}
	}