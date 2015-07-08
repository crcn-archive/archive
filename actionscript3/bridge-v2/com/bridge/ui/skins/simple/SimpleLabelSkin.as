package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.Text;
	import com.bridge.ui.style.Style;
	
	public class SimpleLabelSkin extends SimpleTextSkin
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SimpleLabelSkin(controller:Text,style:Style)
		{
			super(controller,style);
			
			this.textField.autoSize = "left";
		}

	}
}