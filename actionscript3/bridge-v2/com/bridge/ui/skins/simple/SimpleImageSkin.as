package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.Image;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.skins.UISkin;
	import com.bridge.ui.style.Style;
	
	public class SimpleImageSkin extends UISkin
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function SimpleImageSkin(controller:Image,style:Style)
		{
			super(controller,style);
			
			var container:UIComponent = new UIComponent();
			controller.ui_internal::container = container;
			trace("GOGOG");
			
			addChild(container);
		}
		

	}
}