/******************************************************************
 * Dummy Sprite - goes through each child to find information such
 * as width, and height
 *  
 * Author: Craig Condon
 * 
 * Purpose: children who return a different dimensions than what they
 * have will return their original dimensions when width or height
 * are referenced via the parent class. This class reads those virtual
 * dimensions and returns them to whatever object calls it.
 * (Scroll Bars for instance)
 * 
 * Usage: used just like a Sprite, but only use the class when it it known
 * that any child object returns a width or a height that isn't the real
 * dimensions of the object
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/




package com.ei.display
{
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer
	
	public class DummySprite extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Included Methods
        //
        //--------------------------------------------------------------------------
        
        include '../utils/furthestPoint.as';
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _strict:Boolean;
        
        //--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Creates a new DummySprite instance.
         * 
         * @param strict allows a recursive search of every child in the display object
		 */
        
        public function DummySprite(strict:Boolean = false)
        {
        	_strict = strict;
        }
        
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
         * Returns the point of the child that is furthest X
         * 
         * @return the furthest X point
		 */
		
		
		
		override public function get width():Number
		{
			return furthestPoint(this,_strict).x;
		}
		
		/**
		 * Returns the point of the child that is furthest Y
		 * 
		 * @return the furthest Y point
		 */
		
		
		
		override public function get height():Number
		{
			return furthestPoint(this,_strict).y;
		}

	}
}