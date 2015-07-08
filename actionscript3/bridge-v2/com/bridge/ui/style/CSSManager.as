package com.bridge.ui.style
{
	import com.bridge.ui.model.UIModel;
	
	/**
	 * grabs the model style instance and pushes style sheets to it.
	 */
	 
	public class CSSManager
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _model:UIModel = UIModel.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function CSSManager()
		{
		}
		
		public function parse(value:String):void
		{
			_model.styler.parse(value);
		}
		
		

	}
}