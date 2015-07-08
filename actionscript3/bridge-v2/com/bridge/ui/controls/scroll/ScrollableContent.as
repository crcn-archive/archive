package com.bridge.ui.controls.scroll
{
	import com.addicted2flash.layout.Size;
	import com.bridge.ui.core.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class ScrollableContent extends UIComponent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ScrollableContent()
		{
			super();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get width():Number
		{
			
			var size:Size = this.preferredSize;
			
			if(size.width == -1)
				return super.controlWidth;
				
			return size.width;
		}
		
		
		
		/**
		 */
		override public function get height():Number
		{
			var size:Size = this.preferredSize;
			
			if(size.height == -1)
				return super.controlHeight;
				
			return size.height;
		}
		
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function link(child:DisplayObject):void
		{
			super.link(child);
			
			
		}
		
		/**
		 */
		
		override protected function delink(child:DisplayObject):void
		{
			//child.removeEventListener(Event.RESIZE,onChildResize);
			
			super.delink(child);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onChildResize(event:Event):void
		{
			//UI Elements do not bubble, stop anything that does
			event.stopPropagation();
			
			this.dispatchEvent(event);
		}

	}
}