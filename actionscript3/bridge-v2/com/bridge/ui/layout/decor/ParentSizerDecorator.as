package com.bridge.ui.layout.decor
{
	import com.bridge.ui.core.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	
	/**
	 * sizes the parent according the child size, if the width is NaN
	 */
	 
	public class ParentSizerDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var width:Number;
        public var height:Number;
		

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ParentSizerDecorator()
		{
			super(-1);
		}
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get properties():Array
		{
			return ["width","height"];
		}
		
		/**
		 */
		override public function get refreshTypes():Array
		{
			return [RefreshType.CHILD_ADDED];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function draw2():void
		{
			trace("ParentSizerDecorator::draw2()");
			
			
			if(isNaN(width) || isNaN(height))
				for(var i:int = 0; i < this.currentTarget.numChildren; i++)
				{
					var child:DisplayObject = this.currentTarget.getChildAt(i);
					
					child.removeEventListener(Event.RESIZE,onChildResize);
					child.addEventListener(Event.RESIZE,onChildResize);
					
					
					var ui:UIComponent = UIComponent(this.currentTarget);
					
					trace("RESIZE IT");
					
					ui.width  = ui.controlWidth;
					ui.height = ui.controlHeight;
				}
		}
		
		/**
		 */
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onChildResize(event:Event):void
		{
			
		}

	}
}