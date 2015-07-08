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
 
package com.bridge.node
{
	import com.bridge.core.BridgeModule;
	import com.bridge.events.FMLEvent;
	import com.bridge.utils.NamespaceUtil;
	import com.ei.utils.*;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.xml.XMLDocument;
	import flash.xml.XMLNode;
	
	
	/**
	 * The Bridge Node is what is used when executing applications using XML.
	 */
	 
	public class BridgeNode extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        private const NAMESPACE_PATTERN:RegExp = /:[^\s=]+/;
        
        //--------------------------------------------------------------------------
   	    //
        //  Protected Variables
        //
        //--------------------------------------------------------------------------

		/*

		Note: the properties below have been changed from static to protected
		so the parent assigns the modules and Bridge can be instantiated multiple
		times without the worry of having instances still stored in memory
		
		
		FIXME: current solution is flush param in BridgeNode ~ better solution?
		
		*/

        private var _nodeLibrary:BridgeNodeLibrary;
        
        private var _currNode:BridgeNode;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		//true if the node has paused execution of itself and its children 
        private var _pause:Boolean;
        
        
        
        //the child index where the node has paused
        private var _pauseIndex:int;
        
        
        //true if node pauses the entire script.
        //parent nodes look at this boolean value
        //and resumes if it returns true
        private var _pauseAll:Boolean;
        
        
        
        //true if the script completes parsing the values
        //and passes all the modules to all children of the node
        private var _complete:Boolean;
        
        
        
        //array list of all the child nodes
        private var _childNodes:Array;
        
        
        private var _originalChildNodes:Array;
        
        
        
        //list of all the modules used in the node
        private var _usedModules:Array;
        
        
        
        //parent node of this node
        private var _parentNode:BridgeNode;
        
        
        
        //the implementor if specified, this is used for
        //modules that have control over a specific object
        private var _implementor:Object;
        
        
        
        //the original attributes right before the attributes
        //are parsed
        private var _orgAttributes:Object;
        
        private var _attributes:Object;
        private var _nodeName:String;
        
        
        
        //the document containing all the child nodes
        //this is the bridge class
        private var _document:XMLDocument;
        
        
        
        //if true, any child nodes cannot go past this node, parentNodes return null
        private var _parentDisabled:Boolean;
        
        
        //used for Que's when module makes an abrupt pause in the node
        private var _saveNodeFinished:Boolean;
        private var _moduleValueHandlerFinished:Boolean;
        private var _propertyValuesFinished:Boolean;
        private var _propertyNamesFinished:Boolean;
        private var _nodeNameFinished:Boolean;
        private var _childrenFinished:Boolean;
        
        
        //the class to use for every child node
        private var _childNodeClass:Class;
        
        
        
        //for when the node is paused and execution breaks because it cannot continue (for resume)
        private var _needsReExecution:Boolean;
        
        
        private var _parsingEnabled:Boolean;
        

		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * The Constructor for the Bridge Node
         * @param xml the xml source to execute
         * @param library the module library to use
         * @param childNodeClass the node class to use
		 */
		 
		public function BridgeNode(xml:Object = null,library:BridgeNodeLibrary = null,childNodeClass:Class = null)
		{
			//trace(this.nodePath+":BridgeNode()","BridgeNode")
			
			_parsingEnabled = true;
			
			//if(_nodeLibrary != null)
			if(library)
			{
				_nodeLibrary = library;
			}
			else
			{
				_nodeLibrary		 = new BridgeNodeLibrary();
			}
		
			_childNodes 		= new Array();
			//_originalChildNodes = new Array();
			//_orgAttributes	    = new Array();
			_attributes 		= new Object();
			
			//no modules have been executed yet so
			//initalize the used modules variable9
			_usedModules = new Array();
			
			_childNodeClass = BridgeNode;
			
			if(childNodeClass)
				_childNodeClass = childNodeClass;
			
			//if the xml does not equal null then parse it
			if(xml != null)
			{
				parseXML(xml);
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
        
		
		public function set childNodes(value:Array):void
		{
			_childNodes = value;
		}
		
		/**
         * the current nodes being used during execution
		 */
		 
		public function get childNodes():Array
		{
			return _childNodes;
		}
		
		/**
		 */
		
		
		 public function set originalChildNodes(value:Array):void
		 {
		 	this.remove(_originalChildNodes);
		 	
		 	this.appendChildren(value);
		 	
		 	
		 	
		 }
		 
		/**
		 * the nodes initially set before the node is executed
		 */ 
		 
		 public function get originalChildNodes():Array
		 {
			return _originalChildNodes;
		 }
		 
		
		/**
		 */
		
		public function set parentNode(child:BridgeNode):void
		{
			_parentNode = child;
			////trace(this.nodePath+":parentNode("+child+")","BridgeNode")
		}
		
		/**
		 */
		
		
		public function get parentNode():BridgeNode
		{
			if(!_parentDisabled)
				return _parentNode;
			
			return null;
		}
		
		/**
		 * returns the root node of the Bridge document
		 */
		
		public function get rootNode():BridgeNode
		{
			//if the parent node isn't equal to
			//null then it's not the root
			if(parentNode != null)
				return parentNode.rootNode;
			
			return this;
		}
		
		
		
		/**
		 */
		
		public function set firstChild(child:BridgeNode):void
		{
			_childNodes[ 0 ] = child;
			////trace(this.nodePath+":firstChild("+child+")","BridgeNode")
		}
		
		/**
		 * the first node at index 0 of the child nodes
		 */
		
		public function get firstChild():BridgeNode
		{
			return _childNodes[ 0 ];
		}
		
		/**
		 */
		
		public function set lastChild(child:BridgeNode):void
		{
			_childNodes[ _childNodes.length-1 ] = child;
			////trace(this.nodePath+":firstChild("+child+")","BridgeNode")
		}
		
		/**
		 * the first node at index 0 of the child nodes
		 */
		
		public function get lastChild():BridgeNode
		{
			return _childNodes[ _childNodes.length-1 ];
		}
		
		
		/**
		 */
		
		public function get nextSibling():BridgeNode
		{
			var siblingIndex:int = this.parentNode.childNodes.indexOf(this);
			
			return this.parentNode.childNodes[siblingIndex+1];
		}
		
		/**
		 */
		
		public function get previousSibling():BridgeNode
		{
			var siblingIndex:int = this.parentNode.childNodes.indexOf(this);
			
			return this.parentNode.childNodes[siblingIndex-1];
		}

		
		/**
		 */
		 
		public function set nodeValue(value:String):void
		{
			_document.firstChild.nodeValue = value;
			////trace(this.nodePath+":nodeValue("+value+")","BridgeNode")
		}
		
		/**
		 */
		
		public function get nodeValue():String
		{
			
			if(_document && _document.firstChild)
			return _document.firstChild.nodeValue;
			
			
			return null;
		}
		
		/**
		 */
		
		 
		public function set attributes(value:Object):void
		{
			_document.firstChild.attributes = value;
		}
		
		/**
		 * the attributes used during exececution of the Bridge Node
		 */
		
		public function get attributes():Object
		{
			return _document.firstChild.attributes;
		}
		
		/**
		 */
		
		
		public function set originalAttributes(value:Object):void
		{
			_orgAttributes = value;
		}
		
		/**
		 * the origional, non-executed attributes of the Bridge Node
		 */
		
		public function get originalAttributes():Object
		{
			return _orgAttributes;
		}

		
		/**
		 */
		
		public function set nodeName(value:String):void
		{
			_nodeName = value;
			////trace(this.nodePath+":nodeName("+value+")","BridgeNode")
			
		}
		
		/**
		 */
		
		
		public function get nodeName():String
		{
			return _nodeName;
		}
		
		
		/**
		 */
		
		public function get nodeNamespace():String
		{
			if(_nodeName == null)
				return _nodeName;
				
			return NamespaceUtil.getNamespaceIfPresent(_nodeName);
		}
		
		
		/**
		 * for viewing the heirarchy of Nodes. This acts like
		 * the rootNode method but returns a string
		 */
		
		public function get nodePath():String
		{
			//set the parentPath to blank
			var parentPath:String = "";
			
			//if the parentNode isn't null then 
			//rename the parentPath
			if(parentNode != null)
				parentPath = parentNode.nodePath+"::";
				
			return parentPath+nodeName;
		}
		
		/**
		 * returns the modules used in the Bridge document 
		 * as an array
		 */
		
		public function get usedModules():Array
		{
			return _usedModules;
		}
   		
		/**
		 * sets the parent node to null temporarilty
		 */
		
		public function set parentDisabled(value:Boolean):void
		{
			_parentDisabled = value;
		}
		
		/**
		 * enables / disables attribute parsing
		 */
		
		public function get parsingEnabled():Boolean
		{
			return _parsingEnabled;
		}
		
		public function set parsingEnabled(value:Boolean):void
		{
			_parsingEnabled = value;
			
			for each(var child:BridgeNode in this.originalChildNodes)
			{
				child.parsingEnabled = value;
			}
		}
		
		
		/**
		 */
		
		public function get parentDisabled():Boolean
		{
			return _parentDisabled;
		}
		
		
		/**
		 * the class to use when creating child nodes.
		 * @param clazz the BridgeNode class to use
		 */
		 
		public function set childNodeClass(clazz:Class):void
		{
			_childNodeClass = clazz;
		}
		
		/**
		 */
		
		public function get childNodeClass():Class
		{
			return _childNodeClass;
		}
		
		/**
		 * returns the current node being executed
		 */
		
		public function get currentNode():BridgeNode
		{
			return this._currNode;
		}
		
        //--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
         * removes all the original, and current children of the BridgeNode
		 */
		
        public function removeAllChildren():void
		{
			this.remove(this.childNodes);
			this.remove(this.originalChildNodes);
		}
		
        /**
         * adds a variable to the script to be used throughout the application
         * @param varName the variable name
         * @param value the value of the variable
		 */
		
		public function addVariable(varName:String,value:*):void
		{
			
			_nodeLibrary.valueParser.setVariable(varName,value);
			
			////trace(this.nodePath+":addVariable("+varName+","+value+")","BridgeNode")
		}
		
		/**
		 * returns a variable used in the application
		 * @param varName the variable name
		 */
		
		public function getVariable(varName:String):*
		{
			return _nodeLibrary.valueParser.getVariable(varName);
		}

		
        /**
         * returns true if the node has child nodes
		 */
		
		public function hasChildNodes():Boolean
		{
			return childNodes.length > 0;
		}
		
		/**
		 * returns a used module based on the data-type
		 */
		
		public function getUsedModule(moduleClass:Class):BridgeModule
		{
			for each(var mod:BridgeModule in usedModules)
			{
				if(mod is moduleClass)
				{
					return mod;
				}
			}
			
			return null;
		}
		
		/**
		 * clones the node into a new Bridge Node instance
		 */
		
		public function clone(isolate:Boolean = false):BridgeNode
		{
			var newNode:BridgeNode = new childNodeClass(this,nodeLibrary);
			
			newNode.nodeLibrary = this.nodeLibrary.clone(isolate);
		//	ObjectUtils.copy(_originalAttributes,newNode.originalAttributes);
		//	ObjectUtils.copy(_attributes.
		
			return newNode;
		}
		
        /**
         * adds a new module to the BridgeNode which can be used throughout
         * the entire BridgeDocument
         */
        
        public function addModule(module:BridgeModule):void
        {
        
        	_nodeLibrary.registerModule(module);
        	

        }
        
        /**
         * sets the bridge node library to be used throughout the script. This
         * changes all child node libraries as well.
		 */
		
		public function set nodeLibrary(value:BridgeNodeLibrary):void
		{
			
			for each(var child:BridgeNode in _childNodes)
			{
				child.nodeLibrary = value;
			}
			
			////trace(_nodeLibrary.propertyHandlers,value.propertyHandlers);
			
			_nodeLibrary = value;
		}
		
		/**
		 * the node library currently being used. this stores the modules, as
		 * well as all the variables being used
		 **/
		
		public function get nodeLibrary():BridgeNodeLibrary
		{
			////trace(_nodeLibrary.propertyHandlers,"GO");
			
			return _nodeLibrary;
		}
        
       
		
		public function copy(node:BridgeNode):void
		{
			ObjectUtils.copy(this.attributes,node.attributes);
			ObjectUtils.copy(this.originalAttributes,node.originalAttributes);
			ObjectUtils.copy(this.childNodes,node.childNodes);
			
			node.nodeLibrary    = this.nodeLibrary;
			node.parentNode     = this.parentNode;
			node.childNodeClass = this.childNodeClass;
		
			
		}
		
		/**
         * parses an XML document into the Bridge Node to be executed as a script
		 */

		public function parseXML(xml:Object):void
		{
			
			
			////trace(this.nodePath+":parseXML("+xml+")","BridgeNode")
			//set pause and pauseIndex totheir default values since the node
			//is being initialized or replaced with a different node
			_pause      = false;
			_pauseIndex = 0;
			
			//create a new XML document to parse the xml script
			_document 			  = new XMLDocument();
			
			//ignore white so there are no empty children
			_document.ignoreWhite = true;
			
			//parse the XML script
			
			//trace(xml);
			
			_document.parseXML(xml.toString());
			
			//for toString
			//_orgAttributes = attributes;

			//deepParse will take the properties of the first child
			//and use them in this BridgeNode

			saveNode(true);
			
			deepParse(_document.firstChild);
			
		}
		
		/**
		 * adds extra XML to a specific BridgeNode child
		 */
		
		public function appendChild(child:*):void
		{
			//////trace(this.nodePath+":appendChild("+child+")","BridgeNode")
			var newChild:BridgeNode;
			
			
			if(child is BridgeNode)
			{
				////trace(this.nodePath+":appendChild:child is BridgeNode","BridgeNode")
				newChild = child;
				linkChild(newChild);
				
			}
			else
			//could be byte array
			{
				////trace(this.nodePath+":appendChild:child is String","BridgeNode")
				
				//create a new XMLDocument to parse the nodes
				var doc:XMLDocument = new XMLDocument();
				doc.ignoreWhite     = true;
				
				//parse the child so that the original document can append it
				doc.parseXML(child);
				
				
				//add the new child to the first child of the node
				//it's only being appended so that the toString
				//method shows the child nodes
				_document.firstChild.appendChild(doc);
				
				//create a new BridgeNode for the new XMLNodes
				newChild = new childNodeClass(null,nodeLibrary);
				
				//the the new BridgeNode's parent to this node since this is the
				//new parent
				
				linkChild(newChild);

				//parse and execute the child modules since 
				//the root module may already be complete
				newChild.parseXML(child);
			}
			
			
			
			
			//push the child node to the child list so objects can refer to the new FML child
			_childNodes.push(newChild);
			
			
			newChild.dispatchEvent(new Event(Event.ADDED));
			
			
			////trace(this.nodePath+":new children:"+_childNodes,"BridgeNode")

		}
		
		/**
		 * adds the children from another document
		 */
		
		public function appendChildren(children:Array):void
		{
			
			
			for each(var child:BridgeNode in children)
			{
				appendChild(child);
				//child.restart();
			}
			
			
			
			//continue to traverse through the children
			//the index should start at the last child evaluated
			//_childrenFinished = false;
			
			//execute the new child modules
			//this.handleChildModules();
			
			
			
		}
		
		/**
		 * inserts a node in the beginning of the child nodes
		 */
		
		public function insertBeginning(node:BridgeNode):void
		{
			linkChild(node);
			
			var newStack:Array = [node];
			
			
			_childNodes = newStack.concat(_childNodes);
			
			node.dispatchEvent(new Event(Event.ADDED));
			
			
		}
		
		/**
		 * inserts a node before the given node
		 * @param node the new node to add
		 * @param before the node to insert before
		 */
		
		public function insertBefore(node:BridgeNode,before:BridgeNode):void
		{
			
			//1,2,3,4,5,6
			
			linkChild(node);
			
			//node.implementor = implementor;
			
			//get the node index
			var fNode:int = _childNodes.indexOf(before);
			
			var arp1:Array = new Array();
			var arp2:Array = new Array();
			
			for(var i:int = 0; i < _childNodes.length; i++)
			{
				if(i < fNode)
				{
					arp1.push(_childNodes[i]);

				}
				else
				{
					arp2.push(_childNodes[i]);
				}
			}
			
			arp1.push(node);
			
			_childNodes = arp1.concat(arp2);
			
			node.dispatchEvent(new Event(Event.ADDED));
			
			
			if(_childrenFinished)
			{
				BridgeNode(node).executeModules();
			}
			
		}
		
		/**
		 * inserts a node after the given node
		 * @param node the new node
		 * @param after the node to insert after
		 */
		
		public function insertAfter(node:BridgeNode,after:BridgeNode):void
		{
			
			//node.parentNode  = this;
			//node.implementor = implementor;
			linkChild(node);
			
			//get the node index
			var fNode:int = _childNodes.indexOf(after);
			
			var arp1:Array = new Array();
			var arp2:Array = new Array();
			
			for(var i:int = 0; i < _childNodes.length; i++)
			{
				if(i <= fNode)
				{
					arp1.push(_childNodes[i]);

				}
				else
				{
					arp2.push(_childNodes[i]);
				}
			}
			
			var nextChild:BridgeNode = arp2[0];
			var prevChild:BridgeNode = arp1[0];

			arp1.push(node);
			
			node.dispatchEvent(new Event(Event.ADDED));
			
			_childNodes = arp1.concat(arp2);
			
			
			if(nextChild == null || nextChild.complete)
			{
				BridgeNode(node).executeModules();
			}
			
			/*
			
			var nextChild:BridgeNode = arp2[0];
			
			
			
			_childNodes = arp1.concat(arp2);
			
			
			if(nextChild == null || nextChild.complete)
			{
				
				_pauseIndex++;
				
				node.restart();
			}
			
			*/
		}
		
		/**
		 * removes nodes from the Bridge Node
		 */
		
		public function remove(nodes:Array):void
		{
			
			//trace("BridgeNode::remove("+nodes.length);
			
			for each(var node in nodes)
			{
				node.delink();
			}
			_childNodes = ArrayUtils.truncateByValue(_childNodes,nodes);
			
			

		}
		
		/**
		 */
		 
		public function delink():void
		{
			
			this.parentNode = null;
			bubbleEvent(Event.REMOVED);
		}
		
		/**
		 */
		
		protected function bubbleEvent(type:String):void
		{
			var ev:Event = new Event(type);
			
			dispatchEvent(ev);
			
			for each(var child:BridgeNode in _childNodes)
			{
				child.bubbleEvent(type);
			}
		}
		
		

		
		/**
		 * pauses the current Bridge Node for execution
		 */
		
		public function pause():void
		{

			//set pause to true so the loop executing
			//the child modules halts
			_pause = true;
			
			////trace(this.nodePath+":pause()")
			
		}
		

		/**
		 * resumes the current Bridge node for execution
		 */
		
		public function resume():void
		{
			
			////trace(this.nodePath+":resume()")
			//set pause to false so that the loop executing the 
			//child module continues
			_pause = false;
			
			//execute the child modules since pause is false,
			//and there are no events listening for when pause resumes
			
			if(_needsReExecution)
			{
				
				_needsReExecution = false;
				this.executeModules();
			}
		}
		
		/**
		 * returns true if the node is paused
		 */
		
		public function paused():Boolean
		{
			return _pause || _pauseAll;
		}
		
		/**
		 * pauses the entire application from executing
		 */
		
		public function pauseAll():void
		{
			
			////trace(this.nodePath+":pauseAll()");
			
			_pauseAll = true;
			
			if(this.parentNode)
				this.parentNode.pauseAll();

		}
		

		/**
		 * resumes the entire application for execution
		 */
		
		public function resumeAll():void
		{
			
			////trace(this.nodePath+":resumeAll()");
			
			_pauseAll = false;
			
			//if the children aren't paused then continue
			if(!childrenPaused())
			{
				if(!paused())
					executeModules();
				
				//continue up the list until everything is resumed
				if(this.parentNode)
					this.parentNode.resumeAll();
			}
			
		}
		
		/**
		 * omits a node attribute from being handled by the parser
		 */
		
		
		public function omitParsing(name:String,property:String):void
		{

			if(!_nodeLibrary.parseOmissions[ name ])
			{
				_nodeLibrary.parseOmissions[ name ] = new Array();
			}
			
			_nodeLibrary.parseOmissions[ name ].push(property);
		}
		
		
		/**
		 * restarts the Bridge node to the state it was before
		 * executing the modules and values. 
		 */
		
		public function resetAttributes():void
		{
			_pause     					= false;
			_pauseIndex 				= 0;
			_saveNodeFinished 			= false;
       		_moduleValueHandlerFinished = false;
        	_propertyValuesFinished 	= false;
        	_propertyNamesFinished 		= false;
        	_nodeNameFinished 			= false;
        	_childrenFinished 			= false;
        	_complete					= false;
        	_needsReExecution    	    = false;
        	_propertiesHandled		    = new Array();
			
			
			
			//_usedModules = new Array();
			
			////trace(this.nodePath+":resetAttributes()")
			
			if(_orgAttributes != null)
				ObjectUtils.copy(_orgAttributes,attributes);
			
			
			
			resetChildAttributes();
		}
		
		/**
		 * resets the child attributes of the Bridge Node
		 */
		
		public function resetChildAttributes():void
		{
			_pause     					= false;
			_pauseIndex 				= 0;
        	_childrenFinished 			= false;
        	
			for each(var child:BridgeNode in this.childNodes)
			{
				child.resetAttributes();
			}
		}
		
		/**
		 * restarts execution of the Bridge Node
		 */
		 
		public function restart():void
		{
			
			resetAttributes();
			
			executeModules();

		}
		
		/**
		 * restarts execution of the Bridge Node children
		 * @param startIndex index to restart on
		 */
		
		public function restartChildren(startIndex:int = 0):void
		{
			
			resetChildAttributes();
			
			_pauseIndex = startIndex;
			
			_complete = false;
			
			this.handleChildModules();
			
		}
		
		/**
		 */
		
		public function restartAttributes():void
		{
			this.resetAttributes();
			
			this._childrenFinished = true;
			this._nodeNameFinished = true;
			
			this.executeModules();
		}
		
		/**
		 * returns true if any child nodes have paused
		 * the entire script
		 */
		
		public function childrenPaused():Boolean
		{
			var isAllPaused:Boolean = _pauseAll;
			
			for each(var child:BridgeNode in _childNodes)
			{
				//if the a child has called pauseAll then break the loop
				//and return true
				
				if(isAllPaused)
					break;
				
					
				isAllPaused = child.childrenPaused();
				
			}
			
			return isAllPaused;
		}
		
		/**
		 * returns true if the last step in the process has been executed and fullfilled
		 */
		
		public function get complete():Boolean
		{
			return _complete;
		}
		
		//for to String
		public var tabs:String = "";
		
		/**
		 * prints the this xml node
		 */
		
		override public function toString():String
		{
			return getNodeString(this,tabs);
		}
		
		/**
		 * uses the new attributes instead
		 */
		
		public function toStringFlatten():String
		{
			return getNodeString(this,tabs,true);
		}
		
		
		/**
		 */
		
		protected function getNodeString(node:BridgeNode,tab:String="",flatten:Boolean= false):String
		{
			
			if(node.nodeName == null)
			{
				var nv:String = node.nodeValue as String;
				
				//wrap as CDATA only when the node value is wrapped in the parent node
				if(tab.length > 0)
				{
					return wrapAsCDATA(nv);
				}
				
				return nv;
			}
			
			if(node.hasChildNodes())
			{
				return "\n"+tab+getNodeStringChildren(node,tab,flatten);
			}
			else
			{
				return "\n"+tab+getNodeStringNoChildren(node,flatten);
			}
		}
		
		protected function wrapAsCDATA(data:Object):String
		{
			return "<![CDATA["+data+"]]>";
		}
		/**
		 */
		
		protected function getNodeStringNoChildren(node:BridgeNode,flatten:Boolean = false):String
		{
			if(flatten)
				var attrs:Object = node.attributes;
			else
				var attrs:Object = node.originalAttributes;
			
			
			return getNodeProperties(node,attrs,flatten)+" />";
			
			
		}
		
		/**
		 */
		
		protected function getNodeStringChildren(node:BridgeNode,tab:String="",flatten:Boolean = false):String
		{
			
			if(flatten)
				var attrs:Object = node.attributes;
			else
				var attrs:Object = node.originalAttributes;
				
			var init:String = getNodeProperties(node,attrs,flatten)+">";
			
			
			for each(var child:BridgeNode in node.childNodes)
			{
				//init += getNodeString(child,"\t");
				child.tabs = tab+"\t";
				
				if(!flatten)
					init += child.toString();
				else
					init += child.toStringFlatten();
				
			}
			
			init += "\n"+tab+"</"+node.nodeName+">";
			
			return init;
		}
		
		/**
		 */
		
		protected function getNodeProperties(node:BridgeNode,attributes:Object,flatten:Boolean = false):String
		{
			var init:String = "<"+node.nodeName;
			
			var val:String;
			
			for(var prop:String in attributes)
			{
				if(flatten)
					val = StringUtils.htmlSafeString(attributes[prop]);
				else
					val = attributes[prop];
					
				init += " "+prop+"=\""+val+"\" ";
			}
			
			return init;
		}
		
		 
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 * assigns all the XMLNode properties to this node's properties
		 */
		
		protected function deepParse(xml:XMLNode):void
		{
			////trace(this.nodePath+":deepParse("+xml+")")
			
			
			//the new fmlChild
			var fmlChild:BridgeNode;

			//initiate childnodes since new children are being added
			_childNodes 	    = new Array();
			_originalChildNodes = new Array();
			_nodeName		    = xml.nodeName;
			_attributes		    = new Object();
			
			ObjectUtils.copy(xml.attributes,_attributes);
			
			
			//get the current children of the XMLNode
			var children:Array = xml.childNodes;
			
			////trace(_nodeLibrary.propertyHandlers,children.length);
			
			//go through each child node of the XMLNode
			//and create new instances of an BridgeNode
			for each(var child:XMLNode in children)
			{
				
				
			
				//create a new BridgeNode using the XMLNode 
				fmlChild 		 	 = new childNodeClass(null,nodeLibrary);

				//set the parent node of the new BridgeNode to this
				//fmlChild.parentNode  = this;
				
				//fmlChild.nodeLibrary = nodeLibrary;
				linkChild(fmlChild);
				
				fmlChild.parseXML(child);
				
				//set the implementor to this implementor, the root implementor
				//should reach all children of the FMLDocument
				//fmlChild.implementor = _implementor;

				//push the new children to childNodes
				_childNodes.push(fmlChild);
				_originalChildNodes.push(fmlChild);
			}
			
			
		}
		
		/**
		 * the modules must be executed when the BridgeNodes have been created
		 * so executeModules is executed by FMLDocument
		 */
		 
		protected function executeModules():void
		{
			
		/*	 ////trace(this,"SN  ",_saveNodeFinished);
        	 ////trace(this,"MVH ",_moduleValueHandlerFinished);
       	 	 ////trace(this,"PV  ",_propertyValuesFinished);
        	 ////trace(this,"PN  ",_propertyNamesFinished);
        	 ////trace(this,"NN  ",_nodeNameFinished);
        	 ////trace(this,"CH  ",_childrenFinished);*/
        	
        	 
			////trace(this.nodePath+":executeModules()")
			
			//handle this node's modules first so the children modules
			//can reference to it
			
			_currentNode = this;
			
			handleModules();
			
			
			//handle the children modules
			handleChildModules();
		}
		
		/**
		 */
		
		protected function set _currentNode(node:BridgeNode):void
		{
			this._currNode = node;
			
			if(this.parentNode != null)
			{
				BridgeNode(this.parentNode)._currentNode = node;
			}
			
			
				
		}

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 * handles this node's value with modules and parsers
		 */
		
		private function handleModules():void
        {
        	
        	////trace(this.nodePath+":handleModules()")
			
			//set the original node here since nothing should be able to change it
			//once it's been executed, thus reset will keep the state it's at
			//(parent nodes can change the properties)
			
			
			
			handleModuleValueHandlers();
			
			
			
			//handle the property values first before they are processed to the nodeName (which should be the object)
        	handlePropertyValues();
			
			
			//process the properties 
        	handlePropertyNames();
        	
        	
        		
        	//process the nodeName last so that any additional values can be parsed
        	handleNodeName();

        	dispatchEvent(new FMLEvent(FMLEvent.MODULES_EVALUATED));
    	}

        
		/**
		 * parses the child nodes
		 */
		
		private var _childRunning:Boolean;
		
		private function handleChildModules():void
		{
			
			if(_childrenFinished)
				return;
				
			
			if(_childNodes.length == 0)
			{
				completeNode();
				return;
			}
			
				
			////trace(this.nodePath+":handleChildModules()")
			
			//start on _pauseIndex initially since the node can be stopped at any time
			//when the node continues, it will continue where it left off
			
			var child:BridgeNode;
			
			
			for(var i:int = _pauseIndex; i < _childNodes.length; i++)
			{
				////trace(this.nodePath+":starting on "+_pauseIndex+", on "+i+"/"+_childNodes.length)
				//if pause, then don't continue and break the loop
				if(pausedBreak())
				{
					////trace(this.nodePath+":paused on "+_pauseIndex+"/"+_childNodes.length)
					
					_pauseIndex = i;
					
					break;
				}else
				{
					
					child = _childNodes[i];
					
					//execute the child modules
					child.executeModules();
					
		
					
				}
			}
			
			//if for some reason the last node executes a pause
			//make sure that it does not get executed again when it resumes
			
			
			if(i == _childNodes.length && !pausedBreak())
			{
				//set the pauseIndex to the length so it doesn't loop the last node again
				_pauseIndex = _childNodes.length;
				
					
				_childrenFinished = true;
				
				
				completeNode();
			}
			
		}
		
		/**
		 */
		
		private function completeNode():void
		{
						
			//set complete to true since all the children have been executed
			_complete = true;
			
			//dispatches an event listener. the root node will dispatch this
			//when all the children have been successfully traversed
			dispatchEvent(new FMLEvent(FMLEvent.COMPLETE));
		}
		
		/**
		 */
		
		private function handleModuleValueHandlers():void
		{
			if(pausedBreak() || _moduleValueHandlerFinished)
				return;
			
			////trace(this.nodePath+":handleModuleVlaueHandlers()")
			
			_moduleValueHandlerFinished = true;
				
			
			
			for each(var module:BridgeModule in _nodeLibrary.valueHandlers)
			{
				
				var value:String;
				
				for each(value in attributes)
				{
					
					var valueNamespace:String = NamespaceUtil.getNamespace(value);
					
					
					var testReg:RegExp = new RegExp();
					
					if(NamespaceUtil.hasNamespace(module.moduleNamespace,value)/* && module.testNode(this)*/ || module.moduleNamespace == "*")
					{
						if(nodeName != "Plugin")
						module.evalNode(this,value);
						
						_usedModules.push(module);
						
						break;	
					}
				}	
			}
			
		}
		
		/**
		 * goes through each value of the properties and parses them
		 * according to their datatype. Anything that handles the values
		 * must be an IParseFilterable object.
		 */
		
		private var _propertiesHandled:Array;
		
		private function handlePropertyValues():void
		{
			if(_propertiesHandled == null)
				_propertiesHandled = new Array();
			
			
			if(pausedBreak() || _propertyValuesFinished)
			{
				return;
			}
			
			
			var brk:Boolean;
			
			
			_propertyValuesFinished = true;
			
			
			if(!this.parsingEnabled)
				return;
			
			
			
			for(var key:String in this.attributes)
        	{
        		
        		if(_propertiesHandled.indexOf(key) > -1)
        			continue;
        		
        		//check to see if any text is wrapped in a code segment { }
        		////trace(this.attributes[key]);
        		
        		//check if the parser is omitted from this node
        		//////trace(_parseOmissions[ nodeName ],nodeName, key);
				if(_nodeLibrary.parseOmissions[ nodeName ] && _nodeLibrary.parseOmissions[nodeName].indexOf(key) > -1)
				{
					//brk = true;
				}
				
				if(_nodeLibrary.valueParser.test(attributes[ key ]) && !brk)
				{	
					
					_propertiesHandled.push(key);
					
					_propertyValuesFinished = false;
					//trace("BridgeNode::handlePropertyValues()");
					
					var handler:ValueHandler = new ValueHandler(this,key);
					
					if(handler.waiting)
					{
						return;
					}
					
				}
				
        	}
        	
        	_propertiesHandled = new Array();
			
			
        	
		}
		
		
		/**
		 * handles the property names of the node by evaluating each one
		 * according to the correct module
		 */
		
		private function handlePropertyNames():void
		{
			
			if(pausedBreak() || _propertyNamesFinished)
				return;
				
			
			var propertyNamespace:String;
			var testReg:RegExp;
			
			
			
			//go through each of the modules and test this node's properties to them
			for each(var module:BridgeModule in _nodeLibrary.propertyHandlers)
        	{
        		
				//go through the attributes
			    for(var key:String in attributes)
			    {
			    	
			    	//get the namespace of the property
			        propertyNamespace     = NamespaceUtil.getNamespace(key);
					
					testReg = new RegExp(module.moduleNamespace);
					
					//if the namespace is found in the module then evaluate it
					//if(!module.testNode(this))
					////trace("handlePropertyNames()");
			       	if(testReg.test(propertyNamespace) /*&& module.testNode(this)*/ || module.moduleNamespace == "*")
			       	{
			       		
			       		
			       		if(nodeName != "Plugin")
						//evaluate the node
			       		module.evalNode(this,key);
			       		
			       		//push the module to the used modules list
			        	_usedModules.push(module);
			        	
			        	//break the for loop since parsing two of the same property
			        	//could be a bad thing
			        	//break;
			        }
			        	
			    }//for
        	}
        	
        	_propertyNamesFinished = true;
		}
		
		/**
		 * goes through all the module nodeName handlers and passes this node
		 * to whichever test the nodeName true
		 */
		
		private function handleNodeName():void
		{
			if(pausedBreak() || _nodeNameFinished)
				return;
				
			
			//extract the namespace of the nodeName so the methods can be checked
        	var nodeNameNamespace:String = NamespaceUtil.getNamespace(nodeName);
	
			var testReg:RegExp;
			
			//go through each nodeName module and test them to the node name of this BridgeNode

			for each(var module:BridgeModule in _nodeLibrary.nodeNameHandlers)
        	{
        		
        		testReg = new RegExp(module.moduleNamespace,"x");
				
				//if the node name contains the modules module namespace then continue
	        	if(testReg.test(nodeNameNamespace) /* && module.testNode(this) */ || module.moduleNamespace == "*" )
	        	{
	        		if(nodeName != "Plugin")
	        		////trace(this.nodeName);
					//evaluate the nodes
	        		module.evalNode(this,nodeName);
	        		
	        		//push the module to the used list
	        		_usedModules.push(module);
	        		
	        		//do node break the loop since the other modules should be able to check
	        		//and perhaps add functionality to certain nodes
	        		
	        	}
	        }

	        _nodeNameFinished = true;
		}
		
		/**
		 * saves current attributes of the node so it can be restarted
		 * from a parse
		 */
		 
		private function saveNode(oride:Boolean = false):void
		{
			
			if(_orgAttributes == null || oride)
				_orgAttributes = new Object();
			else
				return;
			
			//copy the current attributes to the new attributes list
			ObjectUtils.copy(attributes,_orgAttributes);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		
		
        /**
		 */
		
		protected function pausedBreak():Boolean
		{
			if(paused())
			{
				return _needsReExecution = true;
			}
			
			return false;
		}
		
		/**
		 */
		
		protected function linkChild(node:BridgeNode):void
		{
			
			//node.dispatchEvent(new Event(Event.REMOVED));
			
			node.parsingEnabled  = parsingEnabled;
			node.parentNode      = this;
			node.nodeLibrary     = nodeLibrary;
			node.childNodeClass  = childNodeClass;
			
		}
        

	}
}
	import flash.events.Event;
	import com.bridge.node.BridgeNode;
	import com.bridge.eval.CodeSegment;
	import com.ei.utils.Sleep;
	


	class ValueHandler
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _node:BridgeNode;
		private var _key:String;
		private var _wasPaused:Boolean;
		private var _parser;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var waiting:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ValueHandler(node:BridgeNode,key:String)
		{
			
			
					
			_node = node;
			_key  = key;
			
			//trace("BridgeNode::ValueHandler::init()"+node.nodeName,key,node.attributes[key]);
			
			_parser = node.nodeLibrary.valueParser.getSegmentParser();
			
			
			_parser.eval( node.attributes[key] );
			
			
			if(_parser.hasResult)
			{
				setResult();
			}
			else
			{	
				//needs to pause all since objects can load in data. nodes after that
				//would reference a null object.
				node.pauseAll();
				_parser.addEventListener(Event.COMPLETE,onParserComplete);	
			}
			

		}

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		private function onParserComplete(event:Event):void
		{
			
			waiting = false;
			
			_node.rootNode.currentNode
		
			//trace("BridgeNode::onParseComplete()",_node.attributes[_key],_key,_node.nodeLibrary.valueParser.result);
				
			event.target.removeEventListener(Event.COMPLETE,onParserComplete);
			
			setResult();
			
			_node.resumeAll();
			
		}
		
		private function setResult():void
		{
			_node.attributes[_key] = _parser.result;
		}
		
		
	}