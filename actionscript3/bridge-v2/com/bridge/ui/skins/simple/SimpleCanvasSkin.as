package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.Canvas;
	import com.bridge.ui.controls.ContentWindow;
	import com.bridge.ui.controls.scroll.ScrollableContent;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.style.Style;
	
	public class SimpleCanvasSkin extends SimpleContainerSkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function SimpleCanvasSkin(controller:Canvas,skinStyle:Style,scrollableContent:ScrollableContent = null)
		{
			super(controller,skinStyle);
			
			
			var sc:ScrollableContent = scrollableContent;
			if(sc == null)
				sc = new ScrollableContent();
				
			controller.ui_internal::content = new ContentWindow(sc);
			
			
			addChild(controller.ui_internal::content);
			
		}
	}
}