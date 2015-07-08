	package com.ei.ui.decor.scroll
{
	import com.ei.events.ScrollBarEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ScrollBar extends Sprite
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _policy:String;
		private var _content:ScrollableContent;
		
		private var _scroller:ScrollComponent;
		private var _scrollMore:ScrollComponent;
		private var _scrollLess:ScrollComponent;
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
		
		public function ScrollBar(target:ScrollableContent, policy:String)
		{
			_content = target;
			_policy  = policy;
			
			_scrollHolder     = new Sprite();
			_buttonHolder 	  = new Sprite();
			
			_scrollLess   	  = new ScrollComponent();
			_scrollMore   	  = new ScrollComponent();
			_scroller     	  = new ScrollComponent();
			_scrollBackground = new ScrollComponent();
			
			_scrollHolder.addChild(_scroller);
			
			_buttonHolder.addChild(_scrollMore);
			_buttonHolder.addChild(_scrollHolder);
			_buttonHolder.addChild(_scrollLess);
			
			addChild(_scrollBackground);
			addChild(_buttonHolder);


			_scrollHandler = new ScrollHandler(this);
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
		
		public function set scrollMore(value:DisplayObject):void
		{
			_scrollMore.target = value;
		}
		
		public function get scrollMore():DisplayObject
		{
			return _scrollMore;
		}
		
		/**
		 */
		
		public function set scrollLess(value:DisplayObject):void
		{
			_scrollLess.target = value;
		}
		
		public function get scrollLess():DisplayObject
		{
			return _scrollLess;
		}
		
		/**
		 */
		
		public function set scroller(value:DisplayObject):void
		{
			_scroller.target = value;
		}
		
		public function get scroller():DisplayObject
		{
			return _scroller;
		}
		
		/**
		 */
		
		public function get scrollHolder():Sprite
		{
			return _scrollHolder;
		}
		
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
		
		public function get scrollPolicy():String
		{
			return _policy;
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
		

	}
}