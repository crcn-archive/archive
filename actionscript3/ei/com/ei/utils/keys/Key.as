package com.ei.utils.keys
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	internal class Key
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private static var _keysDown:Array;
        
        private static var _root:DisplayObject;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function Key(focus:DisplayObject)
		{
			
			
			if(_root == null)
				focus.addEventListener(Event.ENTER_FRAME,waitForRoot);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        //--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function isDown(code:int):Boolean
		{
			return _keysDown.indexOf(code) > -1;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		private function waitForRoot(event:Event):void
		{
			if(event.target.root != null)
			{
				event.target.removeEventListener(Event.ENTER_FRAME,waitForRoot);
				
				_root = event.target.root;
				
				_keysDown = new Array();
			
				_root.addEventListener(KeyboardEvent.KEY_DOWN,onKeyDown);
				_root.addEventListener(KeyboardEvent.KEY_UP,onKeyUp);	
			}
		}
        /**
		 */
		 
		public function onKeyDown(event:KeyboardEvent):void
		{
			_keysDown.push(event.keyCode);
		}
		
		/**
		 */
		
		public function onKeyUp(event:KeyboardEvent):void
		{
			var index:int = _keysDown.indexOf(event.keyCode);
			delete _keysDown[index];
		}
	}
}