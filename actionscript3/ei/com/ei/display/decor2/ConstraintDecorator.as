package com.ei.display.decor2
{
	import flash.display.DisplayObjectContainer;
	
	public class ConstraintDecorator extends DisplayObjectDecorator
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

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ConstraintDecorator(target:DisplayObjectContainer)
		{
			super(target);
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function get left():Number
		{
			return _left;
		}

		public function set left(pos:Number):void
		{
			_left = pos;
			//trace(_target,"LEFT",pos);
			isReady = true;
		}
		
		/**
		 */
		
		public function get right():Number
		{
			return _right;
		}
		
		public function set right(pos:Number):void
		{
			_right = pos;
			//trace(_target,"RIGHT",pos);
			isReady = true;
		}
		
		/**
		 */
		
		public function get top():Number
		{
			return _top;
		} 
		
		public function set top(pos:Number):void
		{
			_top = pos;
			//trace(_target,"TOP",pos);
			isReady = true;
		}
		
		
		/**
		 */
		
		public function get bottom():Number
		{
			return _bottom;
		}
		
		public function set bottom(pos:Number):void
		{
			_bottom = pos;
			//trace(_target,"POS",pos);
			isReady = true;
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
			
			if(!isNaN(_left))
			{
				target.x = _left;
			}
				
			//STRETCH if left and right are specified
			if(!isNaN(_right) && !isNaN(_left))
			{
				var newWidth:Number =  manager.parentWidth - _right - target.x;
					
				if(newWidth < 0)
					newWidth = 0;
							
				target.width = newWidth;
			}
			else
			if(!isNaN(_right))
			{
				//trace(manager.parentWidth);
				target.x = manager.parentWidth - _right - target.width;
			}

			if(!isNaN(_top))
			{
				target.y = _top;
			}
			
			if(!isNaN(_top) && !isNaN(_bottom))
			{
				var newHeight:Number = manager.parentHeight - _bottom - target.y;
				
				if(newHeight < 0)
					newHeight = 0;
					
				target.height = newHeight;
			}
			else
			if(!isNaN(_bottom))
			{
				target.y = manager.parentHeight - _bottom - target.height;
			}
			
			//set the center part now
			
			var newPosition:Number;
		}
		
	}
}