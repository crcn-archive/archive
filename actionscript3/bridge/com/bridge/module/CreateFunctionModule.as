package com.bridge.module
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.NamespaceUtil;
	
	import flash.events.Event;
	
	public class CreateFunctionModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CreateFunctionModule(ns:String)
		{
			super(ns);
			
			this.nodeEvaluator.addHandler("function",createFunction);
			this.nodeEvaluator.addHandler("return",stopFunction);
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
			return [ModuleType.NODE_NAME];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function createFunction():void
		{
			new CreateFunction(evaluatedNode);
		}
		
		/**
		 */
		private function stopFunction():void
		{
			var parent:BridgeNode = evaluatedNode.parentNode;
			
			
			while(parent)
			{
				parent.pause();
				
				
				if(NamespaceUtil.removeNamespaceIfPresent(this.moduleNamespace,parent.nodeName) == "function")
				{
					
					parent.dispatchEvent(new ReturnEvent(ReturnEvent.RETURN,evaluatedNode.attributes.value));
					return;
				}
				
				
				
				parent = parent.parentNode;
				
			}
			
		}

	}
}
	import com.bridge.node.BridgeNode;
	import com.bridge.module.CreateFunctionModule;
	import flash.events.Event;
	import com.ei.as3Parser.ast.IFunctionExpression;
	import com.ei.patterns.observer.Notifier;
	import com.ei.patterns.observer.Notification;
	import com.bridge.events.FMLEvent;
	
	//use as function expression so that it can pause the lex table
	class CreateFunction extends Notifier implements IFunctionExpression
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _id:String;
		private var _node:BridgeNode;
		private var _params:Array;
		private var _result:Object;
		private var _hasResult:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function CreateFunction(node:BridgeNode)
		{
			node.pause();
			node.parentDisabled = true;
			
			
			_id = node.attributes["id"];
			
			node.addVariable(_id,this);
			
			
			
			_node = node;
			_node.addEventListener(ReturnEvent.RETURN,onStopFunction);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get params():Array
		{
			return _params;
			
		}
		
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
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
		/**
		 */
		 
		public function callFunction(...params:Array):*
		{
			_params = params;
			_hasResult = false;
			
			
			_node.addEventListener(ReturnEvent.RETURN,onStopFunction);
			
			
			_node.restartChildren();
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
       
		
		/**
		 */
		 
		private function onStopFunction(event:ReturnEvent):void
		{
			event.target.removeEventListener(event.type,onStopFunction);
			_node.lastChild.removeEventListener(FMLEvent.COMPLETE,onLastNodeComplete);
			
			complete(event.value);
		}
		
		/**
		 */
		private function onLastNodeComplete(event:FMLEvent):void
		{
			event.target.removeEventListener(event.type,onLastNodeComplete);
			_node.removeEventListener(ReturnEvent.RETURN,onStopFunction);
			
			complete(null);
		}
		
		/**
		 */
		private function complete(value:Object):void
		{
			trace("COMPLETE");
			_result = value;
			_hasResult = true;
			this.notifyObservers(new Notification(Notification.COMPLETE));
		}
		
		
		
		
	}
	
	
	class ReturnEvent extends Event
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		public static const RETURN:String = "return";
		public var value:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ReturnEvent(type:String,value:Object):void
		{
			super(type);
			
			this.value = value;
		}
	}