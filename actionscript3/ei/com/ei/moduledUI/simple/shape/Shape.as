package com.ei.moduledUI.simple.shape
{
	import com.ei.moduledUI.core.ComponentHandler;
	
	public class Shape extends ComponentHandler
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _x:Number;
		private var _y:Number;
		private var _width:Number;
		private var _height:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Shape()
		{
			_x = 0;
			_y = 0;
			_width = 0;
			_height = 0;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function set width(value:Number):void
		{
			_width = value;
			
			setProperty("width",value);
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		/**
		 */
		
		public function set height(value:Number):void
		{
			_height = value;
			
			setProperty("height",value);
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		/**
		 */
		
		public function set x(value:Number):void
		{
			_x = value;
			
			setProperty("x",value);
		}
		
		public function get x():Number
		{
			return _x;
		}
		
		/**
		 */
		
		public function set y(value:Number):void
		{	
			_y = value;
			
			setProperty("y",value);
		}
		
		public function get y():Number
		{
			return _y;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function setProperty(name:String,value:Object):void
		{
			//abstract
		}
		
		

	}
}