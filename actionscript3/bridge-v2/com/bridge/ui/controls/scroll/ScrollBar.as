/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/

package com.bridge.ui.controls.scroll
{
	import com.bridge.ui.core.Container;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class ScrollBar extends UIComponent
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _content:Container;
		
		private var _scroller:DisplayObject;
		private var _scrollLessV:DisplayObject;
		private var _scrollMoreV:DisplayObject;
		private var _scrollMoreH:DisplayObject;
		private var _scrollLessH:DisplayObject;
		private var _scrollBackground:DisplayObject; 
		
		private var _scrollHolder:Sprite;
		
		private var _resize:Boolean;	  //allows the scrollbar to resize or not
		private var _dragging:Number;	  //defines how fast the scroll delay is behind the dragger (ex: 100 = slow, 1 = no drag)
		private var _smoothing:Number;    //defines how fast the scrollbar is (ex: 100 = smooth, 1 = chunky)

		private var _buttonHolder:Sprite; //holds all the components besides the background
		private var _scrollHandler:ScrollHandler;
		
		private var _initialized:Boolean;
		private var _type:String;
		
		
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function ScrollBar(type:String)
		{
			
			super();
			_type = type;
			
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		//----------------------
		// Scroll GUI
		//----------------------
		
		/**
		 */
		
		ui_internal function set scrollMoreY(value:DisplayObject):void
		{
			_scrollMoreV = value;
		}
		
		
		ui_internal function get scrollMoreY():DisplayObject
		{
			return _scrollMoreV;
		}
		
		
		/**
		 */
		
		ui_internal function set scrollMoreX(value:DisplayObject):void
		{
			_scrollMoreH = value;
		}
		
		
		ui_internal function get scrollMoreX():DisplayObject
		{
			return _scrollMoreH;
		}
		
		
		
		/**
		 */
		
		ui_internal function set scrollLessY(value:DisplayObject):void
		{
			_scrollLessV = value;
		}
		
		ui_internal function get scrollLessY():DisplayObject
		{
			return _scrollLessV;
		}
		
		/**
		 */
		 
		ui_internal function set scrollLessX(value:DisplayObject):void
		{
			_scrollLessH = value;
		}
		
		ui_internal function get scrollLessX():DisplayObject
		{
			return _scrollLessH;
		}
		
		/**
		 */
		
		ui_internal function set scroller(value:DisplayObject):void
		{
			_scroller = value;
			
			//_scrollHandler.refresh();
		}
		
		ui_internal function get scroller():DisplayObject
		{
			return _scroller;
			
		}
				
		/**
		 */
		 
		ui_internal function set scrollBackground(value:DisplayObject):void
		{
			_scrollBackground = value;
			
			_scrollHandler.drawBounds();
		}
		
		ui_internal function get scrollBackground():DisplayObject
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
		
		public function set target(value:Container):void
		{
			_content = value;
			
			if(_initialized)
				startScrollBar();
				
		}
		
		/**
		 */
		
		public function get target():Container
		{
			return _content;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function initiate(scrollBackground:DisplayObject = null,
								 scroller:DisplayObject			= null,
								 scrollLessX:DisplayObject      = null,
								 scrollLessY:DisplayObject		= null,
								 scrollMoreX:DisplayObject	    = null,
								 scrollMoreY:DisplayObject		= null):void
		{
			
			_initialized = true;
			
			
			_scrollLessV   	  = scrollLessY 	 != null ? scrollLessY 		: new Sprite();
			_scrollMoreV   	  = scrollMoreY 	 != null ? scrollMoreY 		: new Sprite();
			_scrollMoreH      = scrollMoreX 	 != null ? scrollMoreX 		: new Sprite();
			_scrollLessH	  = scrollLessX 	 != null ? scrollLessX 		: new Sprite();
			_scroller     	  = scroller		 != null ? scroller    	    : new Sprite();
			_scrollBackground = scrollBackground != null ? scrollBackground : new Sprite();
			
			
			if(_content)
				startScrollBar();
			
		}
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
		/**
		 */
		
		private function startScrollBar():void
		{
			_scrollHandler = new ScrollHandler(this,_type);
			
			
		}
	}
}