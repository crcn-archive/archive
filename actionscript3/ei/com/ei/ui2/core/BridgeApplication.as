package com.ei.ui2.core
{
	import flash.events.Event;
	
	public class BridgeApplication extends UIComponent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BridgeApplication()
		{
			super();
			
			
			stage.addEventListener(Event.RESIZE,onStageResize);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onStageResize(event:Event):void
		{
			
			if(event.target != stage)
				return;
				
			layoutManager.width  = stage.stageWidth;
			layoutManager.height = stage.stageHeight;
		}
		
		
		

	}
}