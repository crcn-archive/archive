package com.ei.ui.core
{
	import com.ei.display.IDisplaceable;
	import com.ei.ui.decor.scroll.IContentScroller;
	import com.ei.ui.decor.scroll.ScrollBar;
	import com.ei.ui.decor.scroll.ScrollableContent;
	import com.ei.utils.SpriteUtils;
	import com.ei.utils.style.template.sprite.*;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class EContainer extends EUIComponent implements  IDisplaceable, IContentScroller
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Included Methods
        //
        //--------------------------------------------------------------------------
        
        include '../../../../com/ei/display/displaceChildren.as';
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		
		//this does nothing but keep the importred display object from dissappearing
		//fucking flex
		private var _beer:DisplayObject;
		
		
		//private var _content:Content;
		private var _sizeToWidth:Boolean;
		private var _sizeToHeight:Boolean;
		private var _drawer:SpriteDrawer;
		
		
		private var _width:Number;
		private var _height:Number;
		
		private var _contentArea:EContentScroller;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		public function EContainer()
		{
			super();
			
			_contentArea = new EContentScroller();
			super.addChild(_contentArea);
			
			_drawer = new SpriteDrawer(this,implementor,SpriteDrawMethod.ROUND_RECT_COMPLETE);	
			_drawer.addEventListener(Event.CHANGE,onStyleChange);
			
			
			addEventListener(Event.ADDED,onChildAdded);
			addEventListener(Event.RESIZE,onResize);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		//----------------------
		// Style
		//----------------------
		
		override public function set styleName(value:String):void
		{
			super.styleName		   = value;
			_contentArea.styleName = value;
		}
		
		//----------------------
		// Display Object
		//----------------------
		
		/**
		 */
		
		public function get target():Sprite
		{
			return _contentArea;
		}
		
		
		/**
		 */
		
		public function get drawer():SpriteDrawer
		{
			return _drawer;
		}
		
		
		//----------------------
		// Dimensions
		//----------------------
		
		/**
		 */
		
		override public function  set width(value:Number):void
		{	
			
			_drawer.setProperty("width",value);
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get width():Number
		{
			
			return _drawer.getProperty("width");

		}

		/**
		 */

		override public function set height(value:Number):void
		{
			
			_drawer.setProperty("height",value);
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number
		{
			
			return _drawer.getProperty("height");
		}
		
		//----------------------
		// Content Scroller
		//----------------------
		
		/**
		 */
		
		public function get verticalScrollBar():ScrollBar
		{
			return _contentArea.verticalScrollBar;
		}
		
		/**
		 */
		
		public function get horizontalScrollBar():ScrollBar
		{
			return _contentArea.horizontalScrollBar;
		}
		
		/**
		 */
		 
		public function get content():Sprite
		{
			return ScrollableContent(_contentArea.target).target;
		}
		
		
		//--------------------
		// padding
		//--------------------
		
		
		override public function set padding(value:Number):void
		{
			_contentArea.padding = value;
		}
		
		/**
		 */
		
		public function set paddingLeft(value:Number):void
		{
			_contentArea.paddingLeft = value;
		}
		
		public function get paddingLeft():Number
		{
			return _contentArea.paddingLeft;
		}
		
		/**
		 */
		
		public function set paddingRight(value:Number):void
		{
			_contentArea.paddingRight = value;
		}
		
		public function get paddingRight():Number
		{
			return _contentArea.paddingRight;
		}
		
		/**
		 */
		
		public function set paddingTop(value:Number):void
		{
			_contentArea.paddingTop = value;
		}
		
		public function get paddingTop():Number
		{
			return _contentArea.paddingTop;
		}
		
		/**
		 */
		
		public function set paddingBottom(value:Number):void
		{
			_contentArea.paddingBottom = value;
		}
		
		public function get paddingBottom():Number
		{
			return _contentArea.paddingBottom;
		}
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		
		//----------------------
		// Graphics 
		//----------------------
		
		
		/*
		 
		override public function addChild(child:DisplayObject):DisplayObject
		{
			super.addChild(_contentArea);
			
			var added:DisplayObject = _content.addChild(child);
			
			if(!_sizeToWidth && !_sizeToHeight)
			{
				//_drawer.setProperties(["width","height"],[SpriteUtils.furthestPoint(_content).x,SpriteUtils.furthestPoint(_content).y]);
				
				//return added;
			}
			
			if(!_sizeToWidth)
			{
				_drawer.setProperty("width",SpriteUtils.furthestPoint(_content).x);
			}
			
			if(!_sizeToHeight)
			{
				_drawer.setProperty("height",SpriteUtils.furthestPoint(_content).y);
			}
			
			return added;
		}
		
		
		 
		override public function removeChildAt(index:int):DisplayObject
		{
			return _content.removeChildAt(index);
		}
		
		
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			return _content.removeChild(child);
		}
		*/
		
		//-----------------------------------------------------------
		// 
		// Protected Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		protected function drawBackground():void
		{
			var newX:Number 	 = _drawer.style.lineThickness;
			var newY:Number 	 = _drawer.style.lineThickness;
			var newWidth:Number  = _drawer.style.width - _drawer.style.lineThickness * 2;
			var newHeight:Number = _drawer.style.height - _drawer.style.lineThickness * 2;
			
			_contentArea.x	    = newX;
			_contentArea.y 	    = newY;
			
			_contentArea.width  = newWidth;
			_contentArea.height = newHeight;
			
		}
		
		override public function set filters(value:Array):void
		{
			super.filters = value;
		}
	

		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function onStyleChange(event:Event):void
		{
			drawBackground();
		}
		
		
		/**
		 */
		
		private function onChildAdded(event:Event):void
		{
			setDimensions();
		}
		
		/**
		 */
		
		private function onResize(event:Event):void
		{
			if(event.target == this)
				return;
			
			
			//setDimensions();	
		}
		
		
		/**
		 */
		
		private function setDimensions():void
		{
			
			//width  = 320;
			//height = 262;
			
			//trace(content.width,content.height);
			
			/*trace("GO");
			
			trace(content.width);
			trace(content.height);
			
			trace(width);
			trace(height);
			
			if(isNaN(width))
			{
				width = content.width;
				
			}
			
			
			if(isNaN(height))
			{
				height = content.height;
			}*/
		}
		
	}
}