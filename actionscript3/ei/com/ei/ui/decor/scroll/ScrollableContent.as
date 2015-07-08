package com.ei.ui.decor.scroll
{

	import com.ei.display.IDisplaceable;
	import com.ei.display.UnresizeableSprite;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public class ScrollableContent extends Sprite implements IDisplaceable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Included Methods
        //
        //--------------------------------------------------------------------------
        
        include '../../../../ei/display/displaceChildren.as';
        include '../../../../ei/utils/furthestPoint.as';
        
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _mask:Sprite;
		private var _width:Number;
		private var _height:Number;
		private var _content:Sprite;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function ScrollableContent(newWidth:Number = 0,newHeight:Number = 0):void
		{
			
			_content = new UnresizeableSprite();
			_mask    = new Sprite();
			
			super.addChild(_content);
			super.addChild(_mask);
			
			
			enableMask();
			
			_width  = 0;
			_height = 0;
			
			width  = newWidth;
			height = newHeight;

		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		 
        override public function set width(value:Number):void
        {

        	_width = value;
        	_content.width = value;
        	dispatchEvent(new Event(Event.RESIZE));
        	
        	setMaskDimensions();
        }
        
        override public function get width():Number
        {
        	return _width;
        }
        
        /**
		 */
		 
        override public function set height(value:Number):void
        {
        	_height = value;
        	_content.height = value;
        	dispatchEvent(new Event(Event.RESIZE));
        	
        	setMaskDimensions();
        }
        
        override public function get height():Number
        {
        	return _height;
        }
        
        
        public function get target():Sprite
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
		
		public function disbleMask():void
		{
			this.mask = null;
		}
		
		/**
		 */
		
		public function enableMask():void
		{
			_content.mask = _mask;
		}
		
		
	
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        private function setMaskDimensions():void
        {
        	with(_mask.graphics)
        	{
        		clear();
        		beginFill(0);
        		drawRect(0,0,_width,_height);
        		endFill();
        	}
        }
		

	}
}