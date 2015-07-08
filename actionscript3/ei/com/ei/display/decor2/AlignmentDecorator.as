package com.ei.display.decor2
{
	import flash.display.DisplayObjectContainer;
	
	public class AlignmentDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _verticalCenter:Number;
		private var _horizontalCenter:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function AlignmentDecorator(target:DisplayObjectContainer)
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
		 
		public function get verticalCenter():Number
		{
			return _verticalCenter;
		}
		
		public function set verticalCenter(pos:Number):void
		{
			//trace(_target,"VERTICALCENTER",pos);
			_verticalCenter = pos;	
			
			isReady = true;
		}
		
		/**
		 */
		
		public function get horizontalCenter():Number
		{
			return _horizontalCenter;
		}
		
		public function set horizontalCenter(pos:Number):void
		{
			//trace(_target,"HORIZONTALCENTER",pos);
			_horizontalCenter = pos;
			
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

	}
}