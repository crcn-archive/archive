package com.bridge.ui.controls.grid
{
	import com.addicted2flash.layout.LayoutEventType;
	import com.bridge.ui.controls.scroll.ScrollableContent;
	
	public class ScrollableList extends ScrollableContent
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _vY:Number;
		private var _vX:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ScrollableList()
		{
			_vY = 0;
			_vX = 0;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get y():Number
		{
			return _vY;
		}
		
		/**
		 */
		
		override public function set y(value:Number):void
		{
			_vY = value;
			
			
			this.notifyLayoutObservers(LayoutEventType.POSITION);
		}
		
		/**
		 */
		
		override public function get x():Number
		{
			return _vX;
		}
		
		/**
		 */
		
		override public function set x(value:Number):void
		{
			_vX = value;
			
			this.notifyLayoutObservers(LayoutEventType.POSITION);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override public function get height():Number
		{
			
			
			return super.height;
		}
		
		

	}
}