package com.ei.display.decor
{
	import com.ei.events.DisplayObjectDecoratorEvent;
	
	import flash.display.DisplayObject;
	
	public class DisplayObjectDecorator
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
		
		public function DisplayObjectDecorator(target:DisplayObject)
		{
			
			_target = target;
			
		//	_target.addEventListener(DisplayObjectDecoratorEvent.FIND_DECORATOR,onFindDecorator);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get target():DisplayObject
		{
			return _target;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onFindDecorator(event:DisplayObjectDecoratorEvent):void
		{
			if(event.target != null)
			{
				event.callback(this);
			}
		}

	}
}