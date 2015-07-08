//controls the size of the display objects

package com.bridge.ui.layout.decor
{
	
	import com.bridge.ui.core.ui_internal;
	
	dynamic public class DimensionDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DimensionDecorator(priority:int = -1)
		{
			super(priority);
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
			return ["width","height","x","y","rotation"];
		}
		
		
		/**
		 * only refresh when the style changes, otherwise on resize it will refresh
		 */
		 
		override public function get refreshTypes():Array
		{
			return [];
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
			if(!isNaN(this.width))
			{
				currentTarget.width = this.width;
				
				//this will refresh the child decorators
				//ui_internal::layoutManager.width = this.width;
			}
			
			if(!isNaN(this.rotation))
			{
				currentTarget.rotation = this.rotation;
			}
			
			if(!isNaN(this.height))
			{
				currentTarget.height = this.height;
				
				
				//refresh child decorators
				//ui_internal::layoutManager.height = this.height;
			}
			
			if(!isNaN(this.x))
			{
				currentTarget.x = this.x;
			}
			
			if(!isNaN(this.y))
			{
				currentTarget.y = this.y;
			}
		}
		
		

	}
}