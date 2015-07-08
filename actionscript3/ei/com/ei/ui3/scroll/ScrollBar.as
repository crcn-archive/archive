package com.ei.ui3.scroll
{
	import com.ei.events.ScrollBarEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ScrollBar extends Sprite
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _content:ScrollableContent;
		
		private var _scroller:ScrollComponent;
		private var _scrollLessV:ScrollComponent;
		private var _scrollMoreV:ScrollComponent;
		private var _scrollMoreH:ScrollComponent;
		private var _scrollLessH:ScrollComponent;
		private var _scrollBackground:ScrollComponent; 
		
		private var _scrollHolder:Sprite;
		
		private var _resize:Boolean;	  //allows the scrollbar to resize or not
		private var _dragging:Number;	  //defines how fast the scroll delay is behind the dragger (ex: 100 = slow, 1 = no drag)
		private var _smoothing:Number;    //defines how fast the scrollbar is (ex: 100 = smooth, 1 = chunky)

		private var _buttonHolder:Sprite; //holds all the components besides the background
		private var _scrollHandler:ScrollHandler;
		
		
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function ScrollBar()
		{
			
			
			_scrollHolder     = new Sprite();
			_buttonHolder 	  = new Sprite();
			
			_scrollLessV   	  = new ScrollComponent();
			_scrollMoreV   	  = new ScrollComponent();
			_scrollMoreH      = new ScrollComponent();
			_scrollLessH	  = new ScrollComponent();
			_scroller     	  = new ScrollComponent();
			_scrollBackground = new ScrollComponent();
			
			//_scrollHolder.addChild(_scroller);
			
			_buttonHolder.addChild(_scrollMoreV);
			_buttonHolder.addChild(_scrollMoreH);
			_buttonHolder.addChild(_scrollHolder);
			_buttonHolder.addChild(_scrollLessH);
			_buttonHolder.addChild(_scrollLessV);
			
			
			addChild(_scrollBackground);
			addChild(_scroller);
			addChild(_buttonHolder);


			
			addEventListener(Event.ADDED,onAdded);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function set visiblie(value:Boolean):void
		{
			super.visible = value;
			dispatchEvent(new ScrollBarEvent(ScrollBarEvent.VISIBILITY));
			
		}
		//----------------------
		// Scroll GUI
		//----------------------
		
		/**
		 */
		
		public function set scrollMoreY(value:DisplayObject):void
		{
			_scrollMoreV.target = value;
		}
		
		
		public function get scrollMoreY():DisplayObject
		{
			return _scrollMoreV;
		}
		
		
		/**
		 */
		
		public function set scrollMoreX(value:DisplayObject):void
		{
			_scrollMoreH.target = value;
		}
		
		
		public function get scrollMoreX():DisplayObject
		{
			return _scrollMoreH;
		}
		
		
		
		/**
		 */
		
		public function set scrollLessY(value:DisplayObject):void
		{
			_scrollLessV.target = value;
		}
		
		public function get scrollLessY():DisplayObject
		{
			return _scrollLessV;
		}
		
		/**
		 */
		 
		public function set scrollLessX(value:DisplayObject):void
		{
			_scrollLessH.target = value;
		}
		
		public function get scrollLessX():DisplayObject
		{
			return _scrollLessH;
		}
		
		/**
		 */
		
		public function set scroller(value:DisplayObject):void
		{
			_scroller.target = value;
			
			//_scrollHandler.refresh();
		}
		
		public function get scroller():DisplayObject
		{
			return _scroller;
			
		}
		
		/**
		 */
		
		/*public function get scrollHolder():Sprite
		{
			return _scrollHolder;
		}*/
		
		/**
		 */
		
		public function get buttonHolder():Sprite
		{
			return _buttonHolder;
		}
				
		/**
		 */
		 
		public function set scrollBackground(value:DisplayObject):void
		{
			_scrollBackground.target = value;
			
			_scrollHandler.drawBounds();
		}
		
		public function get scrollBackground():DisplayObject
		{
			return _scrollBackground;
		}
		
		//----------------------
		// Scrollbar properties
		//----------------------
		
		
		/**
		 */
		 
		public function set smoothing(value:Number):void
		{
			_smoothing = value;
		}
		
		public function get smoothing():Number
		{
			return _smoothing;
		}
		
		
		/**
		 */
		 
		public function set dragging(value:Number):void
		{
			_dragging = value;
		}
		
		public function get dragging():Number
		{
			return _dragging;
		}
		
		
		/**
		 */
		 
		public function set resize(value:Boolean):void
		{
			_resize = value;
			_scrollHandler.resizeScrollBar = value;
		}
		
		public function get resize():Boolean
		{
			return _resize;
		}
		
		/**
		 */
		
		public function get target():ScrollableContent
		{
			return _content;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function onAdded(event:Event):void
		{
			
			event.target.removeEventListener(event.type,onAdded);
			
			var child:DisplayObject;
			
			for(var i:int = 0; i < this.parent.numChildren; i++)
			{
				child = this.parent.getChildAt(i);
				
				if(child is ScrollableContent)
				{
					_content = child as ScrollableContent;
					break;
				}
			}
			
			
			_scrollHandler = new ScrollHandler(this);
			
			
		}
	}
}