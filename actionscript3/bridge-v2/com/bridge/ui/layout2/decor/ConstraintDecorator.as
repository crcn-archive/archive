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

package com.bridge.ui.layout2.decor
{
	import com.addicted2flash.layout.LayoutEventType;
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.bridge.ui.core.UIComponent;
	
	import flash.geom.Rectangle;
	
	
	public class ConstraintDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		private var _left:Number;
		private var _right:Number;
		private var _top:Number;
		private var _bottom:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ConstraintDecorator()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		public function get left():Number
		{
			return _left;
		}
		
		/**
		 */
		public function set left(value:Number):void
		{
			
			_left = value;
			
			ready = true;
		}
		
		/**
		 */
		public function get right():Number
		{
			return _right;
		}
		
		/**
		 */
		public function set right(value:Number):void
		{
			_right = value;
			
			ready = true;
		}
		
		/**
		 */
		public function get top():Number
		{
			return _top;
		}
		
		/**
		 */
		public function set top(value:Number):void
		{
			_top = value;
			
			ready = true;
		}
		
		/**
		 */
		public function get bottom():Number
		{
			return _bottom;
		}
		
		/**
		 */
		public function set bottom(value:Number):void
		{
			_bottom = value;
			
			ready = true;
		}
		
		/**
		 */
		
		override public function get acceptedProperties():Array
		{
			return ["left","right","top","bottom"];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		
		override public function layoutComponent(c:ILayoutComponent):void
		{
			
			
			var layoutBounds:Rectangle = c.layoutBounds;
			
			
			if(!isNaN(this.left))
			{
				target.controlX = this.left;
			}
				
			//STRETCH if left and right are specified
			if(!isNaN(this.right) && !isNaN(this.left))
			{
				var newWidth:Number =  layoutBounds.width - this.right - target.x;
				
				if(newWidth < 0)
					newWidth = 0;
							
				target.width = newWidth;
			}
			else
			if(!isNaN(this.right))
			{	
				//controlX = faster because it doesn't refresh??
				target.controlX =  layoutBounds.width  - this.right - target.width;
				
			}
			
			if(!isNaN(this.top))
			{
				target.controlY = this.top;
			}
			
			if(!isNaN(this.top) && !isNaN(this.bottom))
			{
			
				var newHeight:Number = layoutBounds.height - this.bottom - target.y;
				
				//trace(UIComponent(target).parentContainer,newHeight,layoutBounds.height,this.bottom,target.y);
				
				if(newHeight < 0)
					newHeight = 0;
					
				target.height = newHeight;
			}
			else
			if(!isNaN(this.bottom))
			{
				target.controlY = layoutBounds.height - this.bottom - target.height;
			}
		}
		
	}
}