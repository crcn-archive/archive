package com.ei.ui3.scroll
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ScrollComponent extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _target:DisplayObject;

		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		override public function set width(value:Number):void
		{

			_target.width = value;

		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			_target.height = value;
			
		}
		
		/**
		 */
		 
		public function set target(value:DisplayObject):void
		{
			if(_target)
				removeChild(_target);
				
			_target = addChild(value);
		}
		
		public function get target():DisplayObject
		{
			if(_target)
				return _target;
			
			return this;
		}
	}
}