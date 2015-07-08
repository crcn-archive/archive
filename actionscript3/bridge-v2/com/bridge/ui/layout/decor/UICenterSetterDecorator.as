package com.bridge.ui.layout.decor
{
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.layout.decor.DisplayObjectDecorator;
	import com.bridge.ui.style.Style;
	
	public class UICenterSetterDecorator extends  DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _x:Number;
		private var _y:Number;
		private var _cX:Number;
		private var _cY:Number;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function UICenterSetterDecorator()
		{
			
			
			_cX = 0;
			_cY = 0;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------


		/**
		 */
		override public function get refreshTypes():Array
		{
			return [];
		}
		
		/**
		 */
		override public function get properties():Array
		{
			return ["centerXPercent","centerYPercent","x","y"];
		}
		
		/**
		 */
		
		public function set x(value:Number):void
		{
			_x = value;
		}
		
		/**
		 */
		public function get x():Number
		{
			return 0;
		}


		/**
		 */
		public function set y(value:Number):void
		{
			_y = value;
		}
		
		/**
		 */
		 
		public function get y():Number
		{
			return _y;
		}
		
		/**
		 */
		public function get centerXPercent():Number
		{
			return _cX;
		}
		
		/**
		 */
		public function set centerXPercent(value:Number):void
		{
			_cX = value;
		}
		
		public function get centerYPercent():Number
		{
			return _cY;
			
		}
		public function set centerYPercent(value:Number):void
		{
			_cY = value;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function draw2():void
		{
			trace("DRAW DOG");
			
			//UIComponent(currentTarget).controlX = _y;
			//UIComponent(currentTarget).controlY = _y;
		} 
		
		
	}
}