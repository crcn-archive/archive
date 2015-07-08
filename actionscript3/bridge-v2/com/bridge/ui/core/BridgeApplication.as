package com.bridge.ui.core
{
	import com.bridge.ui.controls.Canvas;
	import com.bridge.ui.model.UIModel;
	
	import flash.events.Event;
	
	public class BridgeApplication extends Canvas
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Embed(source="defaultStyle.css",mimeType="application/octet-stream")]
		private static var _style:Class;
		
		
		//this does nothing. it only includes the default skins to compile at runtime for FLA's
		private static const UI:UICore;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function BridgeApplication()
		{
			UIModel.getInstance().styler.parse(new _style());
			
			super();
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		override protected function init():void
		{
			super.init();
			
			_update = true;
			update();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        private var _update:Boolean;
        
        /**
		 */
		override public function update():void
		{
			
			//this.setLayoutBounds(0,0,stage.stageWidth,stage.stageHeight);
			//this.width = stage.stageWidth;
			//this.height = stage.stageHeight;
			
		}
        /**
		 */
		 
		private function onStageResize(event:Event):void
		{
			update();
		}
		
		
		

	}
}