package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.ContentWindow;
	import com.bridge.ui.controls.scroll.HorizontalScrollBar;
	import com.bridge.ui.controls.scroll.ScrollMask;
	import com.bridge.ui.controls.scroll.ScrollableContent;
	import com.bridge.ui.controls.scroll.VerticalScrollBar;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.style.Style;
	
	public class SimpleContentWindowSkin extends SimpleContainerSkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function SimpleContentWindowSkin(controller:ContentWindow,style:Style)
		{
			super(controller,style);
			
			
			var content:ScrollableContent = controller.scrollableContent;
			var mask:ScrollMask    		  = new ScrollMask();
			
			controller.ui_internal::content = content;
			
			content.mask = mask;
			
			var horizontalScrollBar:HorizontalScrollBar = new HorizontalScrollBar();
			var verticalScrollBar:VerticalScrollBar 	= new VerticalScrollBar();
			
			
			horizontalScrollBar.target = controller;
			verticalScrollBar.target   = controller;
			
			
			addChild(content);
			addChild(verticalScrollBar);
			addChild(horizontalScrollBar);
			addChild(mask);
			
			
			//controller.ui_internal::mask = mask;
			
			/*
			
			
			ui_internal::
			
			
			var contentWindow = new ScrollableContent();
			
			var vScrollBar = new VerticalScrollBar();
			var hScrollBar = new HScrollBar();
			
			vScrollBar.content = contentWindow;
			
			
			ui_internal::verticalScrollBar = new VerticalScrollBar();
			ui_internal::horizontalScrollBar = new HorizontalScrollBar();
			
			*/
		}

	}
}