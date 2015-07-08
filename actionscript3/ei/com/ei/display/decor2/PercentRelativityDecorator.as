package com.ei.display.decor2
{
	import flash.display.DisplayObjectContainer;
	
	public class PercentRelativityDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _percentX:Number;
		private var _percentY:Number;
		private var _percentWidth:Number;
		private var _percentHeight:Number;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var subtractPercentWidth:Number;
		public var subtractPercentHeight:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function PercentRelativityDecorator(target:DisplayObjectContainer)
		{
			super(target);
			
			//for box
			subtractPercentWidth = 0;
			subtractPercentHeight = 0;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set percentX(value:Number):void
		{
			_percentX = value;
			
			isReady = true;
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
			
			isReady = true;
		}
		
		public function get percentY():Number
		{
			return _percentY;
		}
		
		/**
		 */
		
		public function set percentWidth(value:Number):void
		{
			_percentWidth = value;
			
			isReady = true;
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
			
			isReady = true;
		}
		
		public function get percentHeight():Number
		{
			return _percentHeight;
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
			
			if(!isNaN(_percentX))
			{
				target.x = ((manager.parentWidth - target.width) * _percentX ) / 100;
				
			}
			
			if(!isNaN(_percentY))
			{
				target.y = ((manager.parentHeight - target.height) * _percentY ) / 100;
			}
			
			
			
			if(!isNaN(_percentWidth))
			{
				target.width = ((manager.parentWidth - target.x - subtractPercentWidth) * _percentWidth ) / 100
			}
			
			
			
			if(!isNaN(_percentHeight))
			{
			
				target.height = ((manager.parentHeight - target.y - subtractPercentHeight) * _percentHeight ) / 100
			}
		}

	}
}