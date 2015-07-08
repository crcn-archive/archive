package com.bridge.ui.layout2.decor
{
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.bridge.ui.core.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	dynamic public class PercentRelativityDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        private var _percentX:Number;
        private var _percentY:Number;
        private var _percentWidth:Number;
        private var _percentHeight:Number;
        
        
        public var subtractWidthSum:Number;
        public var subtractHeightSum:Number;
        
        public var percentWidthSum:Number;
        public var percentHeightSum:Number;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function PercentRelativityDecorator()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function get acceptedProperties():Array
		{
			return ["percentWidth","percentHeight","percentX","percentY"];
		}
		
		/**
		 */
		
		public function get percentWidth():Number
		{
			return this._percentWidth;
		}
		/**
		 */
		
		public function set percentWidth(value:Number):void
		{
			this._percentWidth = value;
			
			ready = true;
		}
		
		/**
		 */
		
		public function get percentHeight():Number
		{
			return this._percentHeight;
		}
		/**
		 */
		
		public function set percentHeight(value:Number):void
		{
			this._percentHeight = value;
			
			ready = true;
		}
		
		
		/**
		 */
		
		public function get percentX():Number
		{
			return this._percentX;
		}
		/**
		 */
		
		public function set percentX(value:Number):void
		{
			this._percentX = value;
			
			ready = true;
		}
		
		/**
		 */
		
		public function get percentY():Number
		{
			return this._percentY;
		}
		/**
		 */
		
		public function set percentY(value:Number):void
		{
			this._percentY = value;
			
			ready = true;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		

		 
		override public function layoutComponent(c:ILayoutComponent):void
		{
			
			
			var layoutBounds:Rectangle = c.layoutBounds;
			
			
			/*var newPercentWidth:Number  = this.percentWidth;
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
			}*/
			
			
			if(!isNaN(this.percentX))
			{
				target.controlX = Math.round(((layoutBounds.width - target.width) * this.percentX ) / 100);
				
			}
			
			if(!isNaN(this.percentY))
			{
				target.controlY = Math.round(((layoutBounds.height - target.height) * this.percentY ) / 100);
			}
			
			
			if(!isNaN(this.percentWidth))
			{
				
				//Note: having Number causes funny gliffs in the display object, and is *slightly* slower
				var newWidth:int = layoutBounds.width * this.percentWidth / 100;
				
				
				if(newWidth > 0)
					target.width = newWidth;
				else
					target.width = 0;
				
				//target.width = layoutBounds.width;//Math.round(((layoutBounds.width - target.x) * this.percentWidth ) / 100);
				
			}
			
			if(!isNaN(this.percentHeight))
			{
				
				var newHeight:int = Math.round(((layoutBounds.height - target.y) * this.percentHeight ) / 100);
				
				//layoutBounds.width = target.width;
				
				if(newHeight >= 0)
					target.height = newHeight;
				else
					target.height = 0;
			}
			
			
			
			
			
			
		}
		
		
		

	}
}