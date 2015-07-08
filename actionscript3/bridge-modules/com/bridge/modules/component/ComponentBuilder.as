package com.bridge.modules.component
{
	import com.bridge.node.IBridgeNode;
	import com.bridge.libraries.*;
	import com.bridge.utils.ComponentClassDefinition;
	import com.ei.utils.*;
	import com.ei.utils.info.*;
	
	import flash.utils.getDefinitionByName;
	
	internal class ComponentBuilder
	{
		
		//-----------------------------------------------------------
		// 
		// Private Constants
		//
		//-----------------------------------------------------------
		
		private const CONSTRUCTOR:String 	 = "constructor";
		private const PROPERTY:String		 = "property";
		private const HANDLE:String 		 = "process";
		private const EXECUTE:String		 = "execute";
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		//the class instance that's wanted
		private var _cls:Class; 
		
		private var _def:ComponentClassDefinition;
	
		//the params used in the constructor
		private var _params:Array;
		
		//the class info, name, params, super class etc
		private var _info:ClassInfo;
		
		//the class name to be used when registering the Class
		private var _className:String;
		
		//the fmlNode
		private var _node:IBridgeNode;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ComponentBuilder(node:IBridgeNode = null)
		{
			if(node != null)
			{
				build(node);
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 * returns the class name of the definition so the ComponentModule
		 * can use the definition specified when it finds a node name - class name
		 */
        
        
        public function get className():String
        {
        	return _className;
        }
        
        
        /**
		 * returns the class definition for the built component
		 */
		 
		public function get definition():ComponentClassDefinition
		{
			return _def;
		}
        
        //--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 * creates a new Component Class definition library for the ComponentModule
		 */
		 
		public function build(node:IBridgeNode):void
		{
			node.pause();
			
			_node = node;
			
			init();
		}

		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		private function init():void
		{

			source = _node.attributes["source"];
			
			var newName:String = _node.attributes["name"];

			if(newName)
			{
				_className = newName;
			}
			
			processChildren(_node.childNodes);
			
			//for each(var attr:O
		}
		
		/**
		 */
		
		private function set source(value:String):void
		{
			
			//get the actual class instance stored in the swc / class library
			_cls = getDefinitionByName(value) as Class;
			
			//get the info of the class

			_info 	   = new ClassInfo(_cls);  
			
			_def 	   = new ComponentClassDefinition(_cls);
			
			
			_className = _info.name;
			
		}
		
		
		/**
		 */
		
		private function processChildren(children:Array):void
		{
			var nodeName:String;
			
			for each(var child:IBridgeNode in children)
			{
				nodeName = child.nodeName;
				
				switch(nodeName)
				{
					case CONSTRUCTOR:
						handleConstructor(child);
					break;
					case PROPERTY:
						handleProperty(child);
					break;
					case HANDLE:
						handleHandler(child);
					break;
				}
			}
			
			
			_node.addVariable(_className,_cls);
			
			
		}
		
		/**
		 *syntax:
		 * 
		 * <constructor>
		 * 		<param name="stix" value="5" />
		 * 		<param name="name" value="testClass" />
		 * </constructor>
		 */
		
		private function handleConstructor(xml:IBridgeNode):void
		{
			var attr:Object;
			var params:Array = new Array();
			
			//go through each of the contructor parameters and assign the default params and values
			for each(var param:IBridgeNode in xml.childNodes)
			{
				
				attr = param.attributes;
				
				//assign the default params
				params.push(attr.name);
				
				//if a value exists then parse the data so it's correct 100 as a String to an int, {item} as a reference etc.
				if(attr.value)
				{
					_def.setProperty(attr.name,attr.value);
				}	
				
			}

			_def.constructorParams = params;
		}
		
		/**
		 * syntax:
		 * 
		 * <property newName="rel" name="load" value="http://google.com" type="URLRequest" />
		 * <property name="multiline" value="true" type="Boolean" />
		 * 
		 * filter creates a new instance for that param, so a string would turn into a URLRequest object
		 * 	
		 * 
		 */
		
		private function handleProperty(xml:IBridgeNode):void
		{
			var attr:Object = xml.attributes;
			
			if(attr.newName)
			{
				_def.setPropertyName(attr.name,attr.newName);
			}
			
			if(attr.value)
			{
				_def.setProperty(attr.name,attr.value);
			}
		}
		
		/**
		 * <handle childHandler="addNodes" passRawChildren="true" finishEvent="Finish" instanceVar="nextInt" />
		 */
		
		private function handleHandler(xml:IBridgeNode):void
		{
			var attr:Object = xml.attributes;
			
			if(attr.propertySetter)
			{
				_def.propertySetter = attr.propertySetter;
			}
			
			if(attr.parentHandler)
			{
				_def.parentHandler = attr.parentHandler;	
			}
			
			if(attr.childHandler)
			{
				_def.childHandler = attr.childHandler;
			}
			
			if(attr.passRawChildren)
			{
				_def.passRawChildren = Boolean( attr.passRawChildren );
			}
			
			if(attr.finishEvent)
			{
				_def.finishEvent = attr.finishEvent;
			}
			
			if(attr.returnInstance)
			{
				_def.returnInstance = attr.returnInstance;
			}
			
			if(attr.assignInstance)
			{
				_def.assignInstance = attr.assignInstance;
			}
		}
		
		

	}
}