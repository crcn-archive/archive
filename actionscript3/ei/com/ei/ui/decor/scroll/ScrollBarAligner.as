/******************************************************************
 * ScrollBarlAigner - aligns the scroll bars according to the content
 * width and position. A little more responsive than the Contraints
 * but implements the same functionality si it inherits it's 
 * functionality														
 *  
 * Author: Craig Condon
 * 
 * Purpose: to constrain the scroll bars while being more responsive
 * to content changes
 * 
 * Usage: use like the constraint class but for a ScrollBar
 *
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

package com.ei.ui.decor.scroll
{
	import com.ei.display.decor.AlignPolicy;
	import com.ei.display.decor.Constraints;
	import com.ei.events.ScrollBarEvent;
	
	import flash.events.Event;
	
	public class ScrollBarAligner extends Constraints
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		public function ScrollBarAligner(scrollBar:ScrollBar,alignment:String)
		{
			var right:Number;
			var bottom:Number;
			
			if(scrollBar.scrollPolicy == AlignPolicy.HORIZONTAL)
			{
				if(alignment == ScrollAlign.REGULAR)
				{
					bottom = 0;
				}
			}else
			{
				if(alignment == ScrollAlign.REGULAR)
				{
					right = 0;
				}
			}
			
			super(scrollBar,NaN,right,NaN,bottom);
			
			bar = scrollBar;
			scrollBar.target.addEventListener(Event.RESIZE,onTargetResize);
			scrollBar.addEventListener(ScrollBarEvent.VISIBILITY,onScrollVisibility);
		}
		
		private var bar;
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onTargetResize(event:Event):void
		{
			//trace("RESIZE");
			//trace(bar.visible);
			drawConstraints();
		}
		
		/**
		 */
		
		private function onScrollVisibility(event:ScrollBarEvent):void
		{
			//trace(event);
		}

	}
}