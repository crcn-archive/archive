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
 
package com.bridge.module
{
	
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.bridge.module.component.ComponentModule;
	import com.bridge.node.BridgeNode;
	import com.bridge.utils.NamespaceUtil;
	
	import flash.events.IEventDispatcher;
	
	
	/**
	 * listens to a particular event dispatched by an instance. Use it as such:
	 * <br/><br/>
	 * <code>
	 * &lt;[NAMESPACE]:listen to="{my instance}" for="my event"&gt;
	 * <br/>
	 * &nbsp;&nbsp;//do stuff
	 * <br/>
	 * &lt;/[NAMESPACE]:listen&gt;
	 * </code>
	 * <br/><br/>
	 * Example:
	 * <br/><br/>
	 * <code>
	 * &lt;observer:listen to="{sprite}" for="enterFrame"&gt;
	 * <br/>
	 * &lt;change:property target="{sprite}" x="{sprite.x+1}" /&gt;
	 * </br>
	 * &lt;/observer:listen&gt;
	 * </code>
	 */
	 
	public class EventModule extends EvaluableModule
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Varaibles
        //
        //--------------------------------------------------------------------------
        
        
        //stores short events
        private var _shortEvents:Object;
        
        //used to store FMLNodes who have a short event assigned to them
        private var _eventsListened:Object;
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Constructor
		 */
		 
		 
		public function EventModule(ns:String = "")
		{
			super(ns);
			
			_shortEvents = new Object();
			_eventsListened = new Object();
			
			//set the module name to look for 
			nodeEvaluator.addHandler("listen",addEvent);
			nodeEvaluator.addHandler("remove",removeEvent);
			nodeEvaluator.addHandler("addShortEvent",addShortEvent);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /*
        * the event module can handle listen commands and short events for fast processing
        */
		
		override public function get moduleType():Array
		{
			return [ModuleType.NODE_NAME,ModuleType.PROPERTY_NAME];
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		override public function evalNode(node:BridgeNode, property:*=null):void
		{
			//short event
			if(NamespaceUtil.hasNamespace(this.moduleNamespace,property) && node.nodeName != property)
			{
				
				this.listenToShortEvent(node,property,NamespaceUtil.removeNamespace(this.moduleNamespace,property));
				return;
			}
			
			super.evalNode(node,property);
		}

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * instantiates EventHandler 
		 */

		private function addEvent():void
		{
			
			//pause the nodes since the children can be executed multiple times
			evaluatedNode.pause();
			
			//the Event Dispatcher 
			var listenTo:IEventDispatcher = evaluatedNode.attributes["to"];
			
			
			//used for the unique ID
			var listenTo2:String          = evaluatedNode.originalAttributes["to"];
			
			//event id
			var id:String        		  = evaluatedNode.attributes["id"];

			//the event to listen for
			var listenFor:String		  = evaluatedNode.attributes["for"];
			
			
			//the limit of events listened before calling removeEventDispatcher
			var limit:Number 		      = Number(evaluatedNode.attributes["limit"]);
			

			_eventsListened[listenTo2+listenFor] = new EventHandler(evaluatedNode);
		}
		
		/**
		 */
		
		private function removeEvent():void
		{
			var removeFrom:IEventDispatcher = evaluatedNode.attributes["from"];
			
			var removeFrom2:String			= evaluatedNode.originalAttributes["from"];
			
			var removeEvent:String          = evaluatedNode.attributes["event"];
			
			
			var eventHandler:EventHandler = _eventsListened[removeFrom2+removeEvent];
			
			if(eventHandler)
			{
				eventHandler.destroy();
			}
			
		}
		
		/**
		 */
		
		private function addShortEvent():void
		{
			
			
			var name:String  = evaluatedNode.attributes["name"];
			var id:String	 = evaluatedNode.attributes["id"];
			var event:String = evaluatedNode.attributes["event"];
			var limit:String = evaluatedNode.attributes["limit"];
			
			
			
			name = NamespaceUtil.addNamespace(moduleNamespace,name);
			
			_shortEvents[ name ] = new Object();
			
			_shortEvents[ name ].event = event;

			nodeEvaluator.addHandler(name,processEvent);
			
			
			
		}
		
		
		/**
		 */
		
		private function processEvent():void
		{
			
			var property:String = nodeEvaluator.foundProperty;
			
			listenToShortEvent(evaluatedNode,property,_shortEvents[ property ].event,_shortEvents[ property ].limit);
			//new ShortEventHandler(evaluatedNode,property,_shortEvents[ property ].event,_shortEvents[ property ].limit);

		}
		
		/**
		 */
		
		private function listenToShortEvent(node:BridgeNode,property:String,event:String,limit:Number = NaN)
		{
			new ShortEventHandler(node,property,event,limit);
		}
		
		
		
		
	}
}



import flash.events.IEventDispatcher;
import com.bridge.events.FMLEvent;
import com.bridge.module.component.ComponentModule;
import com.bridge.node.BridgeNode;
import com.bridge.eval.CodeSegment;
import flash.events.Event;
	
internal class EventHandler
{
		
	//--------------------------------------------------------------------------
   	//
    //  Private Variables
    //
    //--------------------------------------------------------------------------
        
    //the target event dispatcher
    private var _target:IEventDispatcher;
        
    //the event to listen for
    private var _event:String;
        
    //the node with the listener module
    private var _node:BridgeNode;
        
    //the limit of events before the event is removed
    private var _limit:Number;
        
        
    //once added, just restart the nodes
    private var _added:Boolean;
        
    //count the number of events called
    private var _count:Number;
    
    //the var name given to the result event
    private var _id:String;
    
    private var _eventInst:Event;
		
	//--------------------------------------------------------------------------
   	//
    //  Constructor
    //
    //--------------------------------------------------------------------------
		
	/**
	 * Constructor.
	 */
		 
	public function EventHandler(node:BridgeNode)
	{
		
		_node   = node//.clone(false);
		
		_target = node.attributes["to"];
		_id     = node.attributes["id"];
		_event  = node.attributes["for"];
		_limit  = Number(node.attributes["limit"]);
		
		var weak:Boolean = node.attributes["weak"];
		
		
		_count  = 0;
		//start the listener for the event
		
		
		_target.addEventListener(_event,onEvent);
		
		_node.addEventListener(Event.REMOVED,onNodeRemoved,false,0,weak);
	}
	
	
	
	//--------------------------------------------------------------------------
   	//
    //  Public Methods
    //
    //--------------------------------------------------------------------------
		
	/**
	 */
	 
	public function destroy():void
	{
		_target.removeEventListener(_event,onEvent);
	}
		
	/**
	 */
	
	public function get event():Event
	{
		return _eventInst;
	}
		
	//--------------------------------------------------------------------------
   	//
    //  Private Methods
    //
    //--------------------------------------------------------------------------
		
	/**
	 */
		
	private function onEvent(event:*):void
	{
		//initiate count before so if the limit is 1, the event listener is removed
		_count++;
			
		_eventInst = event;
		
		//limit is an optional parameter. If it has been set, then check to see if
		//count has surpassed the limit of the event
		if(!isNaN(_limit))
		{
				
			//if the count exceeds the limit, them remove the event listener
			if(_count >= _limit)
			{
				destroy();
			}	
		}
			
		
		//instead of appending the nodes, restart the children.
		//this will remove anything funny that might happen between
		//the parent if some nodes haven't been executed. Also, 
		//modules that need to access the parent before listener
		//can do so with parentNode.parentNode. the component module
		//for instance finds the next available parent display object
		
		if(_id)
			_node.addVariable(_id,this);
			
		/*
		 !!!!!!!!!!!!!!!!!!!!
		 changed since observers can be called faster than pause instances can resume, clone delinks the node from the modules
		 !!!!!!!!!!!!!!!!!!!!
		 */
		 
		_node.restartChildren();
		
			
	}
	
	/**
	 */
	
	private function onNodeRemoved(event:Event):void
	{
		event.target.removeEventListener(event.type,onNodeRemoved);
		
		this.destroy();
	}
}

internal class ShortEventHandler
{
	//--------------------------------------------------------------------------
   	//
    //  Private Variables
    //
    //--------------------------------------------------------------------------
        
    //the target event dispatcher
    private var _target:*; //could be proxy
        
    //the event to listen for
    private var _event:String;
        
    //the node with the listener module
    private var _node:BridgeNode;
        
    //the limit of events before the event is removed
    private var _limit:Number;
        
    //once added, just restart the nodes
    private var _added:Boolean;
        
    //count the number of events called
    private var _count:Number;
    
    //the property that has the data to parse
    private var _property:String;
    
    
  //  private var _parser:CodeSegment;
		
	//--------------------------------------------------------------------------
   	//
    //  Constructor
    //
    //--------------------------------------------------------------------------
		
	/**
	 * Constructor.
	 */
		 
	public function ShortEventHandler(node:BridgeNode,property:String,event:String,limit:Number)
	{
		
		
		_count  = 0;
		_node   = node;
		_event  = event;
		_limit  = limit;
		_property = property;
			
		
		node.addEventListener(FMLEvent.MODULES_EVALUATED,onNodeComplete);
		
		
		//_parser = new CodeSegment();
		
	}
		
		
	//--------------------------------------------------------------------------
   	//
    //  Private Methods
    //
    //--------------------------------------------------------------------------
		
	/**
	 */
	
	private function onNodeComplete(event:FMLEvent):void
	{
		
		_node.removeEventListener(FMLEvent.MODULES_EVALUATED,onNodeComplete);
			
			
		var comp:ComponentModule = _node.getUsedModule(ComponentModule) as ComponentModule;
		
		
		_target = comp.getInstance(_node);
			
		 
		//start the listener for the event
		_target.addEventListener(_event,onEvent);
		
		
	//	_node.stringEvaluator.compile(_node.originalAttributes[_property]);
		
	}
	
	
	
	
	/**
	 */
		
	private function onEvent(event:*):void
	{
		
		//initiate count before so if the limit is 1, the event listener is removed
		_count++;
			
		//limit is an optional parameter. If it has been set, then check to see if
		//count has surpassed the limit of the event
		if(!isNaN(_limit))
		{
				
			//if the count exceeds the limit, them remove the event listener
			if(_count >= _limit)
			{
				_target.removeEventListener(_event,onEvent);
			}	
		}
		
	//	trace(_node);
		
		
		
		var propertyData:String = _node.attributes[_property];
		//trace(propertyData);
		
		
		//since the evaluator is one long instance we want to parse only the data we need
		
		//_node.stringEvaluator.dump();
		
		var seg = _node.nodeLibrary.valueParser.getSegmentParser();
		seg.eval(propertyData,true);
		
	}
}