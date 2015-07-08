package com.bridge.ui.controls.grid
{
	import com.addicted2flash.layout.layouts.Column;
	
	import flash.display.DisplayObject;
	
	public class DataGridColumnRenderer extends Column
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _labelField:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DataGridColumnRenderer()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function set labelField(name:String):void
		{
			_labelField = name;
		}
		
		/**
		 */
		public function get labelField():String
		{
			return _labelField;
		}
		
		/**
		 */
		
		public function getFieldData(data:Object,index:int):DisplayObject
		{
			var column:DataGridColumn = new DataGridColumn(data,index);
			column.labelField = _labelField;
			return column;
		}
		
	}
}