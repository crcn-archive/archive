package com.bridge.ui.controls.grid
{
	import com.bridge.ui.core.ObjectProxy;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.skins.simple.SimpleDataGridColumnSkin;
	import com.bridge.ui.core.ui_internal;
	
	public class DataGridColumn extends UIComponent
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _headerProxy:ObjectProxy;
		private var _labelField:String;
		private var _dataProvider:Object;
		private var _data:Object;
		private var _index:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function DataGridColumn(data:Object,index:int)
		{
			super();
			
			_data = data;
			_index = index;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        		
        /**
		 */
		
		public function get index():int
		{
			return _index;
		}
		
		/**
		 */
		
		public function get label():String
		{
			return _headerProxy.getProperty("text");
		}
		
		/**
		 */
		 
		
		 
		public function set label(value:String):void
		{
			_headerProxy.setProperty("text",value);
		}
		
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
		public function get data():Object
		{
			return _data;
		}
		
		/**
		 */
		
		public function set data(value:Object):void
		{
			_data = value;
			
			if(this.initialized)
				this.ui_internal::view.data = _data;
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
			
			data = data;
		}
		
		
		
		

	}
}