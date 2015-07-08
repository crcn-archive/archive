package com.bridge.ui.controls
{
	import com.bridge.ui.controls.scroll.ScrollableContent;
	import com.bridge.ui.core.Container;
	import com.bridge.ui.core.ui_internal;
	
	import flash.display.DisplayObject;
	
	public class ContentWindow extends Container
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		/**
		 * the scrollable content can vary among the type of handling needed. the Data Grid
		 * for instance only renders what is seen, so the y only sets the visible index, not
		 * the actual y position
		 */
		
		private var _scrollableContent:ScrollableContent;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
         * Constructor
         * @param scrollableContentClazz the class to handle children of the scrollable content. Handling can vary since
         * some hidden children may not be immediately rendered, such as the List component.
		 */
		
		public function ContentWindow(scrollableContent:ScrollableContent)
		{
			super();
			
			//the scrollable content is accessed by the base skin
			_scrollableContent = scrollableContent;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		ui_internal function set mask(value:DisplayObject):void
		{
			//this.mask = value;
		}
		
		/**
		 */
		
		public function get scrollableContent():ScrollableContent
		{
			return _scrollableContent;
		}
		
		
		
		

	}
}