/******************************************************************
 * UnresizeableSprite - when width and height changed, it does
 * not affect the child nodes but only the UnresizeableSprite													
 *  
 * Author: Craig Condon
 * 
 * Purpose: so children using the Constraint class can set their
 * position on the parent without being resized when the parent 
 * changes size. Even If children extend the sprite, the parent 
 * sprite does not change its size.
 * 
 * Usage: use just like a normal sprite but used mostly
 * for objects that need to restrain themselves to a position
 * on the parent without being altered
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

package com.ei.display
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class UnresizeableSprite extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _width:Number;
        private var _height:Number;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function UnresizeableSprite()
		{
			_width  = NaN;
			_height = NaN;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function set width(value:Number):void
		{
			_width = value;
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get width():Number
		{
			if(!isNaN(_width))
				return _width;
			
			return super.width;
		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			_height = value;
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number
		{
			if(!isNaN(_height))
				return _height;
			
			return super.height;
		}
		
		
		/**
		 */
		
		public function get actualWidth():Number
		{
			return super.width;
		}
		
		/**
		 */
		 
		public function get actualHeight():Number
		{
			return super.height;
		}

	}
}