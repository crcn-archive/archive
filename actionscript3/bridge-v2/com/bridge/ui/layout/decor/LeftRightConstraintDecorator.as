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

package com.bridge.ui.layout.decor
{
	import com.bridge.ui.core.ui_internal;
	
	public class LeftRightConstraintDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var left:Number;
		public var right:Number;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function LeftRightConstraintDecorator(priority:int = -1)
		{
			super(priority);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get properties():Array
		{
			return ["left","right"];
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function draw2():void
		{
			
			if(!currentTarget.parent)
				return;
			
			
			if(!isNaN(this.left))
			{
				currentTarget.x = this.left;
			}
				
			//STRETCH if left and right are specified
			if(!isNaN(this.right) && !isNaN(this.left))
			{
				var newWidth:Number =  ui_internal::layoutManager.parentWidth - this.right - currentTarget.x;
				
				if(newWidth < 0)
					newWidth = 0;
							
				currentTarget.width = newWidth;
			}
			else
			if(!isNaN(this.right))
			{	
				//trace(ui_internal::layoutManager.parentWidth);
				currentTarget.x = ui_internal::layoutManager.parentWidth - this.right - currentTarget.width;
			}

		}
		
	}
}