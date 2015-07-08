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
	
	public class TopBottomConstraintDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var left:Number;
		public var right:Number;
		public var top:Number;
		public var bottom:Number;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function TopBottomConstraintDecorator(priority:int = -1)
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
			return ["top","bottom"];
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
			

			trace(top,bottom);
			
			if(!isNaN(this.top))
			{
				currentTarget.y = this.top;
			}
			
			if(!isNaN(this.top) && !isNaN(this.bottom))
			{
				
				var newHeight:Number = ui_internal::layoutManager.parentHeight - this.bottom - currentTarget.y;
				
				if(newHeight < 0)
					newHeight = 0;
					
				currentTarget.height = newHeight;
			}
			else
			if(!isNaN(this.bottom))
			{
				currentTarget.y = ui_internal::layoutManager.parentHeight - this.bottom - currentTarget.height;
			}
			
			
			
		}
		
	}
}