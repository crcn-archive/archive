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

package com.bridge.ui.controls.scroll
{
	import com.bridge.ui.core.ObjectProxy;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ScrollComponent extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _target:ObjectProxy;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ScrollComponent():void
		{
			
			_target = new ObjectProxy();
			super();
			
			//this.percentWidth = 100;
			//this.percentHeight = 100;
			
		}

		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		override public function set width(value:Number):void
		{

			_target.setProperty("width",value);

		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			_target.setProperty("height",value);
			
		}
		
		/**
		 */
		 
		public function set target(value:DisplayObject):void
		{
			trace(value,"ES");
			if(_target.target)
				removeChild(_target.target as DisplayObject);
				
			_target.target = value;
		}
		
		public function get target():DisplayObject
		{
			if(_target.target)
				return _target.target as DisplayObject;
			
			return this;
		}
	}
}