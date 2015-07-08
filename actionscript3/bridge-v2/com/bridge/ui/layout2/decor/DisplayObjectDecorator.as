package com.bridge.ui.layout2.decor
{
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.bridge.ui.core.UIComponent;
	
	public class DisplayObjectDecorator 
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _target:UIComponent;
		private var _ready:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DisplayObjectDecorator()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		
		/**
		 */
		
		public function get acceptedProperties():Array
		{
			return [];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function layoutComponent(c:ILayoutComponent):void
		{
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get isReady():Boolean
		{
			return _ready;
		}
		
		
		/**
		 */
		
		public function set target(value:UIComponent):void
		{
			_target = value;	
		}
		
		/**
		 */
		public function get target():UIComponent
		{
			return _target;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		protected function get ready():Boolean
		{
			return _ready;
		}
		
		/**
		 */
		protected function set ready(value:Boolean):void
		{
			_ready = value;
		}
		
		
		
	}
}