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

package com.ei.utils
{
	public class ClassDefinition
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------

		private var _instance:*;
		private var _constructor:Array;
		private var _childHandler:String;
		private var _propertyNames:Object;
		private var _functionParams:Object;
		private var _returnInstance:String;
		private var _assignInstance:String;
		private var _defaultProperties:Object;
		private var _hasReturnInstance:Boolean;
		private var _functionParamOwners:Object;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------

		/**
		*/
		
		public function ClassDefinition(obj:*)
		{
			_instance 		     = obj;
			_constructor  	     = new Array();
			_defaultProperties   = new Object();
			_propertyNames	     = new Object();
			_functionParams      = new Object();
			_functionParamOwners = new Object();
		}

		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */ 
		
		public function set constructorParams(construct:Array):void
		{
			_constructor = construct;
		}
		
		public function get constructorParams():Array
		{
			return _constructor;
		}
		
		/**
		 */
		
		public function get defaultProperties():Object
		{
			return _defaultProperties;
		}
		
		public function set defaultProperties(newProps:Object):void
		{
			_defaultProperties = newProps;
		}
		
		/**
		 */

		public function get propertyNames():Object
		{
			return _propertyNames;
		}
		
		/**
		 */

		public function get instance():*
		{
			return _instance;
		}
		
		/**
		 */

		public function get hasReturnInstance():Boolean
		{
			return _hasReturnInstance;
		}
		
		/**
		 */
		
		public function set assignInstance(value:String):void
		{
			_assignInstance = value;
		}
		
		public function get assignInstance():String
		{
			return _assignInstance;
		}
		
		/**
		 */
		 

		public function get returnInstance():String
		{
			//trace(_returnInstance,"OFFFDFD");
			
			return _returnInstance;
		}
		
		public function set returnInstance(newInst:String):void
		{
			//trace(newInst,"SETTING");
			
			_hasReturnInstance = true;
			_returnInstance = newInst;
		}
		
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------

		/**
		*/
		
		public function setProperty(name:String,value:*):void
		{
			_defaultProperties[ name ] = value;
		}
		
		/**
		 */
		
		public function setPropertyName(oldName:String,newName:String):void
		{
			_propertyNames[ newName ] = oldName;
		}
		
		
		/**
		 */
		
		public function setMethodParams(name:String,params:Array):void
		{
			for each(var i:String in params)
			{
				_functionParams[ i ] = name;
			}
			
		}
		
		

	}
}