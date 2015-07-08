package com.bridge.ui.layout.decor
{
	import com.bridge.ui.core.ui_internal;
	
	import flash.display.Sprite;
	
	dynamic public class PercentRelativityDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var percentX:Number;
        public var percentY:Number;
        public var percentWidth:Number;
        public var percentHeight:Number;
        
        public var subtractWidthSum:Number;
        public var subtractHeightSum:Number;
        
        public var percentWidthSum:Number;
        public var percentHeightSum:Number;
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		/**
		 */
		 
		private var _targetParent:Sprite;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PercentRelativityDecorator(priority:int = -1)
		{
			super(priority);
			
			subtractWidthSum = 0;
			subtractHeightSum = 0;
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function get properties():Array
		{
			return ["percentX","percentY","percentWidth","percentHeight"];
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
			
			
			/*var newPercentWidth:Number = this.percentWidth / combinedPercentWidth * 100; 
			
			if(combinedPercentWidth == 0 || isNaN(newPercentWidth))
				newPercentWidth = this.percentWidth;
				
			trace(newPercentWidth,combinedPercentWidth,this.percentWidth);*/
			
			var newPercentWidth:Number  = this.percentWidth;
			var newPercentHeight:Number = this.percentHeight;
			var newSubWidthSum:Number   = this.subtractWidthSum;
			var newSubHeightSum:Number  = this.subtractHeightSum;
			
			if(!isNaN(percentWidthSum) && percentWidthSum > 100)
			{
				//trace(ui_internal::layoutManager.parentWidth - currentTarget.x);
				
				newPercentWidth = this.percentWidth / (percentWidthSum) * 100;
				
				
				//if(currentTarget.name == "fuck2")
				//trace(currentTarget.x,newSubWidthSum);
				
				//newSubWidthSum -= currentTarget.x;
			}
			
			if(!isNaN(percentHeightSum) && percentHeightSum > 100)
			{
				
				newPercentHeight = this.percentHeight / (percentHeightSum) * 100;
				
				//newSubHeightSum -= currentTarget.y;
			}
			
			//trace(currentTarget,newPercentHeight,percentWidthSum,this.percentWidth);
			
			if(!isNaN(this.percentX))
			{
				currentTarget.x = Math.round(((ui_internal::layoutManager.parentWidth - currentTarget.width) * this.percentX ) / 100);
				
			}
			
			if(!isNaN(this.percentY))
			{
				currentTarget.y = Math.round(((ui_internal::layoutManager.parentHeight - currentTarget.height) * this.percentY ) / 100);
			}
			
			
			
			if(!isNaN(this.percentWidth))
			{
				var newWidth:Number = Math.round(((ui_internal::layoutManager.parentWidth - currentTarget.x - newSubWidthSum) * newPercentWidth ) / 100);
				
				//if(currentTarget.name == "fuck2")
				//trace(newWidth,newSubWidthSum,newPercentWidth,percentWidthSum);
				//trace(newWidth,newSubWidthSum);
				
				if(newWidth > 0)
					currentTarget.width = newWidth;
				else
					currentTarget.width = 0;
				
				
			}
			
			
			
			if(!isNaN(this.percentHeight))
			{
				var newHeight:Number = Math.round(((ui_internal::layoutManager.parentHeight - currentTarget.y - newSubHeightSum) * newPercentHeight ) / 100);
				
				if(newHeight >= 0)
					currentTarget.height = newHeight;
				else
					currentTarget.height = 0;
			}
			
		}
		
		
		
		

	}
}