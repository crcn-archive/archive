package com.bridge.utils
{
	import com.bridge.node.IBridgeNode;
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
		private var _staticNodes:IBridgeNode;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------

		/**
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
		
		public function set staticNodes(xml:IBridgeNode):void
		{
			_hasStaticNodes = true;
			_staticNodes = xml;
		} 
		
		public function get staticNodes():IBridgeNode
		{
			return _staticNodes;
		}




	}
}