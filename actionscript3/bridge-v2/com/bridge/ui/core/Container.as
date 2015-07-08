//fix the container

package com.bridge.ui.core
{
	import com.bridge.ui.layout.decor.*;
	import com.bridge.ui.layout2.BoxLayout;
	
	import flash.display.DisplayObjectContainer;
	
	
	public class Container extends UIComponent
	{
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _content:DisplayObjectContainer;

		private var _boxDecorator:BoxDecorator;
		
		private var _box:BoxLayout
		
		private var _gap:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function Container()
		{
			
			super();
			
			_gap = 5;
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------


		/**
		 */
		public function get alignment():String
		{
			if(_box)
				return _box.alignment;
				
			return null;
		}
		
		/**
		 */
		
		public function set alignment(value:String):void
		{
			if(_box)
				_box.trash();
				
			
			this.layout = _box = new BoxLayout(this,value,_gap);
		}
		
		/**
		 */
		public function get gap():int
		{
			return _gap;
		}
		
		/**
		 */
		public function set gap(value:int):void
		{
			_gap = value;
			
			if(!alignment)
				return;
				
			if(_box)
				_box.trash();
			
			this.layout = _box = new BoxLayout(this,alignment,_gap);
		}
		
		
		/**
		 */
		 
		ui_internal function get content():DisplayObjectContainer
		{
			return this.content;
		}
		
		ui_internal function set content(value:DisplayObjectContainer):void
		{
			this.content = value;
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		protected function get content():DisplayObjectContainer
		{
			return _content;
		}
		 
		/**
		 */
		
		 
		protected function set content(value:DisplayObjectContainer):void
		{
			_content = value;
			ui_internal::view = _content;
		}
		
		
		
		
	}
}