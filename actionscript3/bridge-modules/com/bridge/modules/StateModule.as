	package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.node.IBridgeNode;
	import com.ei.utils.*;
	
	import flash.utils.Dictionary;
	
	public class StateModule extends EvaluableModule
	{
		
		/*
		
		<State name="home">
			<enter>
			</enter>
			<exit>
			</exit>
		</State>
		
		*/
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _pause:Boolean;
		private var _states:Dictionary;
		private var _previousState:StateInfo;
		private var _currentState:String;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function StateModule(ns:String = "")
		{
			super(ns);
			nodeEvaluator.addHandler("State",addState);
			nodeEvaluator.addHandler("currentState",setCurrentState);
			nodeEvaluator.addHandler("pause",pauseState);
			nodeEvaluator.addHandler("resume",resumeState);
			
			_states = new Dictionary();
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
			return [ModuleType.NODE_NAME,ModuleType.PROPERTY_NAME];
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function addState():void
		{
			//pause children from executing
			evaluatedNode.pause();

			var stateName:String = evaluatedNode.attributes.name;
			_states[ stateName ] = new StateInfo(evaluatedNode.firstChild,evaluatedNode.childNodes[1]);
			
	
		}
		
		/**
		 * returns or sets a current state
		 */
		
		private function setCurrentState():void
		{

			var nodeKey:String;
			var nodeVal:String;
			var stateNameRep:String = moduleNamespace+":currentState";
				
			
			for(var key:String in evaluatedNode.attributes)
			{
				if(evaluatedNode.attributes[ key ].toString().indexOf(stateNameRep) > -1)
				{
					nodeKey = key;
					nodeVal = evaluatedNode.attributes[ key ];
					evaluatedNode.attributes[ key ] = evaluatedNode.attributes[ key ].replace(stateNameRep,_currentState);
					
					return;
				}
					
			}
			
			var stateName:String = evaluatedNode.attributes[stateNameRep];
			var rootNode:IBridgeNode = traverseToParentState(evaluatedNode);
			
			var info:StateInfo = _states[ stateName ];
			
			
			if(!info)
				return;
			
			if(_previousState)
			{
				
				var exitNode:String = String(_previousState.exitNode);
				
				
				if(_previousState.exitNode)
					_previousState.exitNode.restart()
			}
			
			if(!_pause)
			{
				info.enterNode.restart();
				
				/*for each(var child:FMLNode in info.enterNode)
				{
					info.enterNode.parentNode.parentNode.add
				}
				trace(info.enterNode.parentNode.parentNode);*/
			}
			
			_previousState = info;
			_currentState  = stateName;
		}
		
		/**
		 */
		
		
		
		/**
		 */
		
		private function pauseState():void
		{
			_pause = true;
		}
		
		/**
		 */
		
		private function resumeState():void
		{
			_previousState.enterNode.restart();
			_pause = false;
		}
		
		/**
		 */
		
		private function traverseToParentState(node:IBridgeNode):IBridgeNode
		{
			if(node.parentNode == null)
			{
				return node;
			}
			else
			if(node.parentNode.nodeName != stateNodeName)
			{
				return traverseToParentState(node.parentNode);
			}
			else
				return node.parentNode;
			
		}
		
		/**
		 */
		
		private function get stateNodeName():String
		{
			return this.moduleNamespace+":State";
		}
		


	}
}
	import com.bridge.node.IBridgeNode;
	

internal class StateInfo
{
		
	//--------------------------------------------------------------------------
   	//
    //  Public Variables
    //
    //--------------------------------------------------------------------------

	public var enterNode:IBridgeNode;
	public var exitNode:IBridgeNode;
		
		
	//--------------------------------------------------------------------------
   	//
    //  Constructor
    //
    //--------------------------------------------------------------------------
        
    /**
	 */
		 
	public function StateInfo(enterNodes:IBridgeNode,exitNodes:IBridgeNode)
	{
		this.enterNode  = enterNodes;
		this.exitNode   = exitNodes;
	}
}