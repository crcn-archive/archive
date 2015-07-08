package com.ei.ui.core
{
	import com.ei.display.decor2.UILayoutDecorator;
	import com.ei.ui2.core.UIComponent;
	
	public class EUIComponent2 extends UIComponent
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _layoutDecorator:UILayoutDecorator;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function EUIComponent2()
		{
			super();
		
			_layoutDecorator = new UILayoutDecorator(this);
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
			_layoutDecorator.percentWidth = value;
			
			
		}
		

		public function get percentWidth():Number
		{
			return _layoutDecorator.percentWidth;
		}
		
		/**
		 */
		
		public function set percentHeight(value:Number):void
		{
			_layoutDecorator.percentHeight = value;
			
			
			
		}
		
		public function get percentHeight():Number
		{
			return _layoutDecorator.percentHeight;
		}
		
		/**
		 */
		
		public function set percentX(value:Number):void
		{
			_layoutDecorator.percentX = value;	
		}
		
		public function get percentX():Number
		{
			return _layoutDecorator.percentX;
		}
		
		/**
		 */
		
		public function set percentY(value:Number):void
		{
			_layoutDecorator.percentY = value;
		}
		
		public function get percentY():Number
		{
			return _layoutDecorator.percentY;
		}
		
		/*
		override public function set width(value:Number):void
		{
			_layoutDecorator.width = value;
			
			
		}
		
		
		override public function get width():Number
		{
			return _layoutDecorator.width;
		}
		
		
		override public function set height(value:Number):void
		{
			_layoutDecorator.height = value;
			
			
		}
		
		override public function get height():Number
		{
			return _layoutDecorator.height;
		}*/
		
		
		/**
		 */
		
		public function set left(value:Number):void
		{
			_layoutDecorator.left = value;
			
			
		}
		
		public function get left():Number
		{
			return _layoutDecorator.left;
		}
		
		/**
		 */
		
		public function set right(value:Number):void
		{
			_layoutDecorator.right = value;
			
			
		}
		
		public function get right():Number
		{
			return _layoutDecorator.right;
		}
		
		/**
		 */
		
		public function set top(value:Number):void
		{
			_layoutDecorator.top = value;
		}
		
		/**
		 */
		
		public function get top():Number
		{
			return _layoutDecorator.top;
		}
		
		/**
		 */
		
		public function set bottom(value:Number):void
		{
			_layoutDecorator.bottom = value;
		}
		
		public function get bottom():Number
		{
			return _layoutDecorator.bottom;
		}
		
		/**
		 */
		
		public function set verticalCenter(value:Number):void
		{
			_layoutDecorator.verticalCenter = value;
		}
		
		public function get verticalCenter():Number
		{
			return _layoutDecorator.verticalCenter;
		}
		
		/**
		 */
		
		public function set horizontalCenter(value:Number):void
		{
			_layoutDecorator.horizontalCenter = value;
		}
		
		public function get horizontalCenter():Number
		{
			return _layoutDecorator.horizontalCenter;
		}

	}
}