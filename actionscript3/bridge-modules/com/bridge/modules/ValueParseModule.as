package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	
	public class ValueParseModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var match:Array;
		public var evaluated:String;
		public var node:BridgeNode;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ValueParseModule(ns:String = "")
		{
			super(ns);
			
			
			this.nodeEvaluator.addHandler("add",addRule);
			this.nodeEvaluator.addHandler("changeNode",changeNode);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function get moduleType():Array
		{
			return [ModuleType.NODE_NAME,ModuleType.VALUE];
		}
		

		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function addRule():void
		{
			
			evaluatedNode.pause();
			
			var rule:String    = evaluatedNode.attributes.rule;
			var applyTo:String = evaluatedNode.attributes.applyTo;
			var flags:String   = evaluatedNode.attributes.flags;
			var type:Array     = evaluatedNode.attributes.type;
			
			
			new ParseModule(this,evaluatedNode,rule,flags,applyTo,type);
			
			//this.nodeEvaluator.addHandler(applyTo,
		}
		
		/**
		 */
		
		private function changeNode():void
		{
			
			var newValue:* = evaluatedNode.attributes.value;
			var newProperty:String = evaluatedNode.attributes.propertyName;
			
			
			
			if(newProperty)
			{
				delete this.node.originalAttributes[evaluated];
				
				this.node.originalAttributes[newProperty] = newValue;
			}
			else
			{
				this.node.originalAttributes[evaluated] = newValue;
			}
			
		}

	}
}
	import com.bridge.core.EvaluableModule;
	import com.bridge.node.BridgeNode;
	import com.bridge.core.BridgeModule;
	import com.bridge.modules.ValueParseModule;
	


	class ParseModule extends BridgeModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _parser:ValueParseModule;
		private var _target:BridgeNode;
		private var _type:Array;
		private var _rule:RegExp;
		private var _applyTo:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		public function ParseModule(rootParser:ValueParseModule,target:BridgeNode,rule:String,flags:String,applyTo:String,type:Array):void
		{
			super("*");
			
			_target = target;
			
			_rule = new RegExp(rule,flags);
			_applyTo = applyTo;
			_type = type;
			
			_parser =  rootParser;
			
			target.addModule(this);
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function get moduleType():Array
		{
			
			return _type;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		override public function evalNode(node:BridgeNode, property:* = null):void
		{
			
			if(_applyTo != "*")
			{
				if(node.nodeNamespace != _applyTo)
					return;
			}
			
			
		
			if(_rule.exec(property))
			{
				
				for(var attr:String in node.attributes)
				{
					if(node.attributes[attr] == property)
					{
						_parser.match = String(property).match(_rule);
						
						_parser.evaluated = attr;
						_parser.node  = node;
						
						_target.restartChildren();
						
						break;
					}
				}
			}
			
		}
	}
