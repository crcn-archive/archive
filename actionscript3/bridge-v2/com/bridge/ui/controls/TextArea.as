package com.bridge.ui.controls
{
	import com.bridge.ui.core.ui_internal;
	
	public class TextArea extends Text
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TextArea()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function init():void
		{
			super.init();
			
			ui_internal::textField.multiline = true;
			ui_internal::textField.wordWrap  = true;
		}

	}
}