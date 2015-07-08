package com.ei.ui.decor.scroll
{
	import com.ei.display.decor.AlignPolicy;
	import com.ei.display.decor.Box;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class ContentScroller extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Included Methods
        //
        //--------------------------------------------------------------------------
        
        include '../../../../../com/ei/display/displaceChildren.as';
        
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		private var _mask:Sprite;
		private var _bounds:Rectangle;
		private var _vertical:ScrollBar;
		private var _horizontal:ScrollBar;
		private var _target:DisplayObject;
		
		private var _content:ScrollableContent;
		private var _contentHolder:Sprite;
		private var _verticalHolder:Sprite;
		
		private var _vertAligner:Box;
		private var _horizAligner:Box;
		
		private var _paddingLeft:Number;
		private var _paddingRight:Number;
		private var _paddingTop:Number;
		private var _paddingBottom:Number;
		
		private var _width:Number;
		private var _height:Number;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		/**
		 */
		
		public function ContentScroller()
		{

			_content 		  = new ScrollableContent();
			
			
			_vertical		  = new ScrollBar(_content,AlignPolicy.VERTICAL);
			_horizontal       = new ScrollBar(_content,AlignPolicy.HORIZONTAL);
			
			new ScrollBarAligner(_vertical,ScrollAlign.REGULAR);
			new ScrollBarAligner(_horizontal,ScrollAlign.REGULAR);
			
			super.addChild(_content);
			
			super.addChild(_vertical);
			super.addChild(_horizontal);

			_content.disbleMask();
			
			_paddingLeft   = 0;
			_paddingRight  = 0;
			_paddingTop    = 0;
			_paddingBottom = 0;
			
			_width = 0;
			_height = 0;
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		
		/**
		 */
		
		override public function set width(value:Number):void
		{
			_content.width = value;
			
			//so padding doesn't catch it
			_width = value;
			_content.enableMask();
			setPadding();
			
			dispatchEvent(new Event(Event.RESIZE));
			
			
		}
		
		override public function get width():Number
		{
			
			return _width;
		}
		
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			_content.height = value;
			_height = value;
			
			
			_content.enableMask();
			setPadding();
			
			dispatchEvent(new Event(Event.RESIZE));
			
			
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		/**
		 */
		
		public function get horizontalScrollBar():ScrollBar
		{
			return _horizontal;
		}
		
		
		/**
		 */
		 
		public function get verticalScrollBar():ScrollBar
		{
			return _vertical;
		}
		
		public function get target():Sprite
		{
			return _content;
		}
		
		
		/**
		 */
		
		public function set padding(value:Number):void
		{
			_paddingLeft = value;
			_paddingRight = value;
			_paddingTop = value;
			_paddingBottom = value;
			
			setPadding();
		}
		
		/**
		 */
		
		public function set paddingLeft(value:Number):void
		{
			_paddingLeft = value;
			
			setPadding();
		}
		
		public function get paddingLeft():Number
		{
			return _paddingLeft;
		}
		
		/**
		 */
		
		public function set paddingRight(value:Number):void
		{
			_paddingRight = value;
			setPadding();
		}
		
		public function get paddingRight():Number
		{
			return _paddingRight;
		}
		
		/**
		 */
		
		public function set paddingTop(value:Number):void
		{
			_paddingTop = value;
			setPadding();
		}
		
		public function get paddingTop():Number
		{
			return _paddingTop;
		}
		
		/**
		 */
		
		public function set paddingBottom(value:Number):void
		{
			_paddingBottom = value;
			setPadding();
		}
		
		public function get paddingBottom():Number
		{
			return _paddingBottom;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function setPadding():void
		{
			_content.x      = _paddingLeft;

			_content.width  = _width - _paddingRight;
			_content.y      = _paddingTop;
			_content.height = _height - _paddingTop - _paddingBottom;
		}
		
		
		
		
		
	}
}