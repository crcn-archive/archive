package com.ei.display.decor2
{
	import com.ei.ui2.core.UIComponent;
	
	public class UILayoutDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _left:Number;
		private var _right:Number;
		private var _top:Number;
		private var _bottom:Number;
		private var _width:Number;
		private var _height:Number;
		private var _percentWidth:Number;
		private var _percentHeight:Number;
		private var _verticalCenter:Number;
		private var _horizontalCenter:Number;
		private var _percentX:Number;
		private var _percentY:Number;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function UILayoutDecorator(target:UIComponent)
		{
			super(target,-1);
			
			isReady = true;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set percentWidth(value:Number):void
		{
			_percentWidth = value;
			
			
		}
		

		public function get percentWidth():Number
		{
			return _percentWidth;
		}
		
		/**
		 */
		
		public function set percentHeight(value:Number):void
		{
			_percentHeight = value;
			
			
			
		}
		
		public function get percentHeight():Number
		{
			return _percentHeight;
		}
		
		/**
		 */
		
		public function set percentX(value:Number):void
		{
			_percentX = value;	
		}
		
		public function get percentX():Number
		{
			return _percentX;
		}
		
		/**
		 */
		
		public function set percentY(value:Number):void
		{
			_percentY = value;
		}
		
		public function get percentY():Number
		{
			return _percentY;
		}
		
		/**
		 */
		
		public function set width(value:Number):void
		{
			_width = value;
			
			
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
			
			
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		
		/**
		 */
		
		public function set left(value:Number):void
		{
			_left = value;
			
			
		}
		
		public function get left():Number
		{
			return _left;
		}
		
		/**
		 */
		
		public function set right(value:Number):void
		{
			_right = value;
			
			
		}
		
		public function get right():Number
		{
			return _right;
		}
		
		/**
		 */
		
		public function set top(value:Number):void
		{
			_top = value;
		}
		
		/**
		 */
		
		public function get top():Number
		{
			return _top;
		}
		
		/**
		 */
		
		public function set bottom(value:Number):void
		{
			_bottom = value;
		}
		
		public function get bottom():Number
		{
			return _bottom;
		}
		
		/**
		 */
		
		public function set verticalCenter(value:Number):void
		{
			_verticalCenter = value;
		}
		
		public function get verticalCenter():Number
		{
			return _verticalCenter;
		}
		
		/**
		 */
		
		public function set horizontalCenter(value:Number):void
		{
			_horizontalCenter = value;
		}
		
		public function get horizontalCenter():Number
		{
			return _horizontalCenter;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override protected function refresh2():void
		{
			if(isAllNaN(_verticalCenter,_horizontalCenter))
			{
				alignTarget();
			}
			
			
			if(isAllNaN(_left,_right,_top,_bottom))
			{
				constrainTarget();
			}
			
			if(isAllNaN(_percentWidth,_percentHeight,_percentX,_percentY))
			{
				setPercentRelativity();	
			}
			
			
			if(isAllNaN(_width,_height))
			{
				setDimensions();
			}
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		private function alignTarget():void
		{
			var newPosition:Number;
			
			if(!isNaN(_horizontalCenter))
			{
				newPosition = manager.parentWidth/2 - target.width/2 + _horizontalCenter;
				
				//if(_restrictBounds && (newPosition < 0 || newPosition > manager.parentWidth))
				//	return;
					
				target.x = newPosition;
			}
			
			if(!isNaN(_verticalCenter))
			{
				newPosition =  manager.parentHeight/2 - target.height/2 + _verticalCenter;
				
				//if(_restrictBounds && (newPosition < 0 || newPosition > manager.parentHeight))
				//	return;
					
				target.y = newPosition;
			}
		}
		
		/**
		 */
		
		private function constrainTarget():void
		{
			
		}
		
		/**
		 */
		
		private function setDimensions():void
		{
			
		}
		
		/**
		 */
		
		private function setPercentRelativity():void
		{
			
		}
		
		/**
		 */
		
		private function isAllNaN(...values:Array):Boolean
		{
			for each(var num:Number in values)
			{
				if(!isNaN(num))
					return true;
				
			}
			
			return false;
		}
		
		
		
		
		

	}
}