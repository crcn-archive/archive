package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.Label;
	import com.bridge.ui.controls.grid.DataGridColumn;
	import com.bridge.ui.controls.grid.IDataGridRenderer;
	import com.bridge.ui.core.ViewProxy;
	import com.bridge.ui.style.Style;
	
	public class SimpleDataGridColumnSkin extends ColoredUIComponentSkin implements IDataGridRenderer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _label:Label;
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function SimpleDataGridColumnSkin(controller:DataGridColumn,style:Style)
		{
			super(controller,style);
			
			_label = new Label();
			addChild(_label);
		}
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function set data(value:Object):void
		{
			_label.text = value[DataGridColumn(this.controller).labelField];
			
		}
		
		

	}
}