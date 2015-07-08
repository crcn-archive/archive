package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.scroll.VerticalScrollBar;
	import com.bridge.ui.core.Container;
	import com.bridge.ui.style.Style;
	
	import flash.filters.GlowFilter;
	
	public class SimpleVerticalScrollBarSkin extends SimpleScrollBarSkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function SimpleVerticalScrollBarSkin(controller:VerticalScrollBar,style:Style)
		{
			super(controller,style);  
			
			controller.dragging = 1.3;
			var cont:Container = new Container();
			cont.percentWidth = 100;
			
			cont.buttonMode = true;
			
			controller.initiate(this,cont);
			
			controller.resize = false;
			
			addChild(cont);
		}

	}
}