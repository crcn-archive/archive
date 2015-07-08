package com.ei.ui.decor.scroll
{
	import com.ei.utils.SpriteUtils;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ScrollComponent extends Sprite
	{

		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		override public function set width(value:Number):void
		{

			this.getChildAt(0).width = value;

		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			this.getChildAt(0).height = value;
			
		}
		
		/**
		 */
		 
		public function set target(value:DisplayObject):void
		{
			SpriteUtils.clear(this);
			
			addChild(value);
		}
		
		public function get target():DisplayObject
		{
			if(this.numChildren == 1)
			{
				return this.getChildAt(0);
			}
			
			return this;
		}
	}
}