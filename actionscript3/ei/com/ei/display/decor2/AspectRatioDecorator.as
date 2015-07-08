package com.ei.display.decor2
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class AspectRatioDecorator extends DisplayObjectDecorator
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _ratioType:String;
		private var _staticWidth:Number;	
		private var _staticHeight:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function AspectRatioDecorator(target:DisplayObjectContainer,index:int = 0)
		{
			super(target,index);
			
			aspectRatioType = AspectRatioType.STRETCH;
			
			_staticWidth  = target.width;
			_staticHeight = target.height;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function set aspectRatioType(value:String):void
		{
			_ratioType = value;
			
			isReady = true;
		}
		
		public function get aspectRatioType():String
		{
			return _ratioType;
		}
		
		/**
		 */
		
		public function set staticWidth(value:Number):void
		{
			_staticWidth = value;
			
			//refresh(true);
		}
		
		public function get staticWidth():Number
		{
			return _staticWidth;
		}
		
		/**
		 */
		
		public function set staticHeight(value:Number):void
		{
			_staticHeight = value;
			
			//refresh(true);
		}
		
		public function get staticHeight():Number
		{
			return _staticHeight;
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
			var wRatio:Number = 1;
			var hRatio:Number = 1;
			
			if((manager.parentWidth < staticWidth || _ratioType == AspectRatioType.STRETCH) && manager.parentWidth != 0)
			{
				
				wRatio = manager.parentWidth / staticWidth;
				
			}
			
			if((manager.parentHeight < staticHeight || _ratioType == AspectRatioType.STRETCH) && manager.parentHeight != 0)
			{
				hRatio = manager.parentHeight / staticHeight;
				
			}
			
			var controlRatio:Number = wRatio < hRatio ? wRatio : hRatio;
			
			
			target.width  = _staticWidth  * controlRatio;
			target.height = _staticHeight * controlRatio;
			
			//trace(target.width,target.height,target.x,target.y);
			
			if(_ratioType == AspectRatioType.KEEP_RATIO)
			{
				target.scaleX = controlRatio;
				target.scaleY = controlRatio;
			}	
		}

	}
}