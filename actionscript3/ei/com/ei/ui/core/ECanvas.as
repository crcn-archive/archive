package com.ei.ui.core
{
	import com.ei.display.decor.ChildList;
	import com.ei.ui2.core.UIComponent;
	import com.ei.utils.style.template.sprite.SpriteDrawMethod;
	import com.ei.utils.style.template.sprite.SpriteDrawer;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class ECanvas extends EUIComponent

	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _content:Content;
		private var _drawer:SpriteDrawer;
		private var _cList:ChildList;
		private var _sizeToWidth:Boolean;
		private var _sizeToHeight:Boolean;

		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		public function ECanvas()
		{
			super();
			
			_content = new Content();
			_cList   = new ChildList(_content);

			super.addChild(_content);

			_drawer = new SpriteDrawer(this,implementor,SpriteDrawMethod.ROUND_RECT_COMPLETE);	
			_drawer.addEventListener(Event.CHANGE,onStyleChange);
			
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		//----------------------
		// Display Object
		//----------------------
		
		
		/**
		 */
		 
		public function get content():Content
		{
			return _content;
		}
		
		/**
		 */
		
		override public function get numChildren():int
		{
			return _content.numChildren;
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
			
			
			this.layoutManager.width = value;
			
			_sizeToWidth = true;
			_drawer.setProperty("width",value);
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get width():Number
		{
			//wrap incase they are strings
			if(_sizeToHeight)
				return _drawer.getProperty("width") + _drawer.getProperty("lineThickness");

			return super.width;
		}

		/**
		 */

		override public function set height(value:Number):void
		{
			this.layoutManager.height = value;
			
			_sizeToHeight = true;
			_drawer.setProperty("height",value);
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function get height():Number
		{
			if(_sizeToHeight)
				return _drawer.getProperty("height") + _drawer.getProperty("lineThickness");

			return super.height;
		}
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		
		//----------------------
		// Graphics 
		//----------------------
		
		
		/**
		 */
		 
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if(child is UIComponent)
				layoutManager.registerChild(child as UIComponent);
			
			super.addChild(_content);
			var added:DisplayObject = _content.addChild(child);

			if(!_sizeToWidth)
			{
				_drawer.setProperty("width",_cList.width);
			}
			
			if(!_sizeToHeight)
			{
				_drawer.setProperty("height",_cList.height);
			}
			
			return added;
		}

		
		/**
		 */
		 
		override public function removeChildAt(index:int):DisplayObject
		{
			layoutManager.unregisterChildAt(index);
			
			return _content.removeChildAt(index);
		}
		
		/**
		 */
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			
			if(child is UIComponent)
				layoutManager.unregisterChild(child as UIComponent);
			
			return _content.removeChild(child);
		}
		
		/**
		 */
		
		override public function getChildAt(index:int):DisplayObject
		{
			return _content.getChildAt(index);	
		}
		
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
			var newWidth:Number  = _drawer.style.width;
			var newHeight:Number = _drawer.style.height;
			
			//the children can change size as well so be sure to get them
			if(!_sizeToHeight)
			{
				newHeight = super.height;
			}
			
			if(!_sizeToWidth)
			{
				newWidth  = super.width;
			}
			
			newHeight = newHeight - _drawer.style.lineThickness * 2;
			newWidth  = newWidth  - _drawer.style.lineThickness * 2;

			_content.x	    = newX;
			_content.y 	    = newY;
			_content.width  = newWidth;
			_content.height = newHeight;
			
			
			//dispatchEvent(new Event(Event.RESIZE));
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
		
		
	}
}