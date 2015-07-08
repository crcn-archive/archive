package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.Text;
	import com.bridge.ui.controls.TextInput;
	import com.bridge.ui.style.Style;
	import com.bridge.ui.core.ui_internal;
	
	public class SimpleTextInputSkin extends ColoredUIComponentSkin
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function SimpleTextInputSkin(controller:TextInput,style:Style)
		{
			super(controller,style);
			
			var text:Text = new Text();
			
			controller.ui_internal::textField = text;
			
			addChild(text);
			
			
		}

	}
}