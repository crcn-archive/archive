package com.bridge.ui.layout2
{
	import com.bridge.events.StyleEvent;
	import com.bridge.ui.style.Style;
	
	import flash.display.DisplayObject;
	
	public class StyleSetter
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _target:DisplayObject;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function StyleSetter(target:DisplayObject,style:Style)
		{
			_target = target;
			
			style.addEventListener(StyleEvent.CHANGE,onStyleChange);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onStyleChange(event:StyleEvent):void
		{
			if(_target.hasOwnProperty(event.property))
			{
				_target[event.property] = event.value;
			}
		}

	}
}