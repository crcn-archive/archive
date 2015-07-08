package com.bridge.ui.layout2
{
	import com.addicted2flash.layout.core.ILayoutContainer;
	import com.addicted2flash.layout.core.LayoutComponent;
	import com.addicted2flash.layout.layouts.ILayout;
	import com.ei.utils.ArrayUtils;
	
	public class MultiLayout 
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _layouts:Array
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function MultiLayout()
		{
			_layouts = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function registerLayout(layout:ILayout):void
		{
			_layouts.push(layout);
		}
		
		/**
		 */
		
		public function unregisterLayout(layout:ILayout):void
		{
			_layouts = ArrayUtils.truncateByValue(_layouts,[layout])
		}
		

	}
}