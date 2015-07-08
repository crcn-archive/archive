/******************************************************************
 * ObjectWrapper - wraps an objects and handles any data coming it.
 * the overall controller however is the Bridge builder itself, and
 * it can atach decorators, pause the object etc.												
 *  
 * Author: Craig Condon
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

package com.bBuilder.control
{
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	
	public class ObjectController extends Proxy
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _target:*;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ObjectController(target:*)
		{
			_target = target;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override flash_proxy function callProperty(name:*,...params:Array):*
		{
			return _target[name].apply(_target,params);
		}
		
		/**
		 */
		
		override flash_proxy function deleteProperty(name:*):Boolean
		{
			return delete _target[name];
		}
		
		/**
		 */
		 
		override flash_proxy function getDescendants(value:*):*
		{
			return value;
		}
		
		/**
		 */
		
		override flash_proxy function getProperty(value:*):*
		{
			return _target[value];
		}
		
		/**
		 */
		
		override flash_proxy function hasProperty(name:*):Boolean
		{
			return _target.hasOwnProperty(name);
		}
		
		/**
		 */
		
		override flash_proxy function isAttribute(value:*):Boolean
		{
			return _target is value;
		}
		
		/**
		 */
		
		override flash_proxy function nextName(index:int):String
		{
			return _target[index];
		}
		
		/**
		 */
		
		override flash_proxy function nextNameIndex(index:int):int
		{
			return index;
		}
		
		/**
		 */
		
		override flash_proxy function  nextValue(index:int):*
		{
			return _target[index];
		}
		/**
		 */
		
		override flash_proxy function setProperty(name:*,value:*):void
		{
			_target[name]=value;
		}

	}
}