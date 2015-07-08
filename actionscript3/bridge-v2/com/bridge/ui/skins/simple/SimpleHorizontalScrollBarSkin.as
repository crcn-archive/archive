package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.scroll.HorizontalScrollBar;
	import com.bridge.ui.core.Container;
	import com.bridge.ui.style.Style;
	import com.bridge.ui.core.ui_internal;
	
	public class SimpleHorizontalScrollBarSkin extends SimpleScrollBarSkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SimpleHorizontalScrollBarSkin(controller:HorizontalScrollBar,style:Style)
		{
			
			super(controller,style);
			
			controller.dragging = 1.3;
			var cont:Container = new Container();
			cont.percentHeight = 100;
			cont.style = "backgroundColors:#990000;";
			
			cont.buttonMode = true;
			
			controller.initiate(this,cont);
			//controller.ui_internal::scroller = cont;
			
			addChild(cont);
			
			
		}
		
		

	}
}