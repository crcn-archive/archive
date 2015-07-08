package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.grid.DataGrid;
	import com.bridge.ui.controls.grid.ScrollableList;
	import com.bridge.ui.style.Style;
	
	public class SimpleDataGridSkin extends SimpleCanvasSkin
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SimpleDataGridSkin(controller:DataGrid,style:Style)
		{
			super(controller,style,new ScrollableList());
			
			
			
			
		}

	}
}