package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.scroll.ScrollMask;
	import com.bridge.ui.skins.UISkin;
	import com.bridge.ui.style.Style;
	
	public class SimpleScrollMaskSkin extends UISkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SimpleScrollMaskSkin(controller:ScrollMask,style:Style)
		{
			super(controller,style);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override protected function change():void
		{
			draw2();
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		
		protected function draw2():void
		{
			with(this.graphics)
			{
				clear();
				beginFill(0);
				drawRect(0,0,this.style.getProperty("width"),this.style.getProperty("height"));
			}
		} 
		

	}
}