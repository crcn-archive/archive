package com.ei.ui.core
{

	import com.ei.display.decor.Constraints;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Content extends Sprite
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------

		private var _constraints:Constraints;
		private var _bgColor:Number
		private var _width:Number;
		private var _widthSet:Boolean;
		private var _heightSet:Boolean;
		private var _height:Number;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function Content(backgroundColor:Number = NaN)
		{
			_bgColor = backgroundColor;
			//_width = 0;
			//_height = 0;
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		//----------------------
		// Dimensions
		//----------------------
		
		/**
		 */
		
		override public function set width(value:Number):void
		{
			_width	  = isNaN(value)?0:value;
			_widthSet = true;
			drawBounds();
			dispatchEvent(new Event(Event.RESIZE,true));
		}
		
		override public function get width():Number
		{
			if(_widthSet)	
				return _width;
			
			return super.width;
		}

		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			_height	   = isNaN(value)?0:value;
			_heightSet = true;
			drawBounds();
			dispatchEvent(new Event(Event.RESIZE,true));
		}
		
		override public function get height():Number
		{
			if(_heightSet)
				return _height;
			
			return super.height;
		}

		
		//-----------------------------------------------------------
		// 
		//  Protected Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		
		protected function drawBounds():void
		{
			
			with(this.graphics)
			{
				clear();
				if(!isNaN(_bgColor))
					beginFill(_bgColor);
				drawRect(0,0,width,height);
			}
		}
		
	}
}