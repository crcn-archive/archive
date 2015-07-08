package com.bridge.ui.model
{
	import com.bridge.ui.style.BridgeCSS;
	
	public class UIModel
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private static var _model:UIModel;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function UIModel()
		{
			if(_model)
			{
				throw new Error("Only one instance of UIModel can be instantiated");
			}
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		public static function getInstance():UIModel
		{
			if(!_model)
				_model = new UIModel();
			
			
			return _model;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

        public var styler:BridgeCSS = new BridgeCSS();

	}
}