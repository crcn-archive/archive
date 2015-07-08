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
 
package com.bridge.utils
{
	import com.bridge.node.BridgeNode;
	import com.ei.utils.*;
	
	public class ComponentClassDefinition extends ClassDefinition
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _hasFinishEvent:Boolean;
		private var _hasParentHandler:Boolean;
		private var _passRawChildren:Boolean;
		private var _finishEvent:String;
		private var _parentHandler:String;
		private var _differentReturn:Boolean;
		private var _propertySetter:String;
		private var _hasPropertySetter:Boolean;
		private var _childHandler:String;
		private var _hasStaticNodes:Boolean;
		private var _staticNodes:BridgeNode;
		private var _gcWhen:String;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------

		/**
		 * Stores info on a class to be used with the ComponentModule, and SimpleObject class.
		 * @param cls the class instance to use
		 */
		
		public function ComponentClassDefinition(cls:*)
		{
			super(cls);
			
			
			_childHandler = "addChild";
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------

		/**
		 * handles child nodes of a component node
		 */

		public function set childHandler(newHandler:String):void
		{
			_childHandler = newHandler;
		}

		public function get childHandler():String
		{
			return _childHandler;
		}
		
		/**
		 */
		
		public function get hasFinishEvent():Boolean
		{
			return _hasFinishEvent;
		}
		
		/**
		 */

		public function get finishEvent():String
		{
			return _finishEvent;
		}
		
		public function set finishEvent(event:String):void
		{
			_hasFinishEvent = true;
			_finishEvent 	= event;
		}
		
		/**
		 * true if the child nodes are to be passed unprocessed to the component
		 */

		public function get passRawChildren():Boolean
		{
			return _passRawChildren;
		}
		
		public function set passRawChildren(raw:Boolean):void
		{
			_passRawChildren = raw;
		}
		
		/**
		 */
		
		public function get hasParentHandler():Boolean
		{
			return _hasParentHandler;
		}
		
		/**
		 */

		public function get parentHandler():String
		{
			return _parentHandler;	
		}
		
		public function set parentHandler(newHandler:String):void
		{
			_hasParentHandler = true;
			_parentHandler 	  = newHandler;
		}
		
		
		/**
		 */
		 
		public function get hasPropertySetter():Boolean
		{
			return _hasPropertySetter;
		}
		
		/**
		 */

		public function get propertySetter():String
		{
			return _propertySetter;
		}
		
		public function set propertySetter(newSetter:String):void
		{
			_hasPropertySetter = true;
			_propertySetter	   = newSetter;
		}
		
		
		/**
		 */
		
		public function get hasStaticNodes():Boolean
		{
			return _hasStaticNodes;
		}
		
		/**
		 */
		
		public function set staticNodes(xml:BridgeNode):void
		{
			_hasStaticNodes = true;
			_staticNodes = xml;
		} 
		
		public function get staticNodes():BridgeNode
		{
			return _staticNodes;
		}

		/**
		 * tells the component module to remove the instance when the specific event is dispatched
		 * @param value the event to listen to
		 */
		 
		public function set gcWhen(value:String):void
		{
			_gcWhen = value;
		}
		
		/**
		 */
		public function get gcWhen():String
		{
			return _gcWhen;
		}



	}
}