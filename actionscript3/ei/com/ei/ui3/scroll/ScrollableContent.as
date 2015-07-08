package com.ei.ui3.scroll
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class ScrollableContent extends Sprite// implements IDisplaceable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Included Methods
        //
        //--------------------------------------------------------------------------
        
        //include '../../../../ei/display/displaceChildren.as';
        //include '../../../../ei/utils/furthestPoint.as';
        
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _mask:DisplayObject;
		private var _width:Number;
		private var _height:Number;
		private var _content:DisplayObject;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function ScrollableContent():void
		{
			
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

        	setMaskDimensions();
        }
        
        override public function get width():Number
        {
        	return _mask.width;
        }
        
        /**
		 */
		 
        override public function set height(value:Number):void
        {
        	
        	//dispatchEvent(new Event(Event.RESIZE));
        	
        	setMaskDimensions();
        }
        
        override public function get height():Number
        {
        	return _mask.height;
        }
        
        /**
		 */
        
        public function set content(value:DisplayObject):void
        {
        	if(_content)
        		removeChild(_content);
        	
        	_content = addChild(value);
        	
        	dispatchEvent(new Event(Event.CHANGE,true));
        }
        
        public function get content():DisplayObject
        {
        	return _content;
        }
        
        /**
		 */
		
		
		override public function set mask(value:DisplayObject):void
		{
			//add onto the position
			x += value.x;
			y += value.y;
			
			value.x = 0;
			value.y = 0;
			
			_mask = super.mask = addChild(value);
			
			
			//addChild(value);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function disableMask():void
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
        	//_mask.width = _width;
        	//_mask.height = _height;
        }
		

	}
}