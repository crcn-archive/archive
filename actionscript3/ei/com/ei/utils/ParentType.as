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
	import flash.display.DisplayObject;
	
	public class ParentType
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _scope:DisplayObject;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		 public function ParentType(scope:DisplayObject)
		 {
		 	_scope = scope;
		 }
		 
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		
		/**
		 */
		 
		public function get parentIsRoot():Boolean
		{
			return _scope.parent == _scope.stage;
		}
		
		/**
		 */
		
		public function get resizeableObject():DisplayObject
		{
			if(parentIsRoot)
			{
				return _scope.stage;
			}
			else
			{
				return _scope.parent;
			}
		}
		
		/**
		 */
		
		public function get width():Number
		{
			if(parentIsRoot)
			{
				return resizeableObject["stageWidth"];
			}
			else
			{
				return resizeableObject["width"];
			}
		}
		
		/**
		 */
		
		public function get height():Number
		{
			if(parentIsRoot)
			{
				return resizeableObject["stageHeight"];
			}
			else
			{
				return resizeableObject["height"];
			}
		}
		
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		
		
	}
}