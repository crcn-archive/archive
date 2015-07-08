package com.ei.ui.decor
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class ScrollBar
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _target:DisplayObject;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function ScrollBar(target:DisplayObject)
		{
			_target = target;
			_target.addEventListener(Event.ENTER_FRAME,waitForRoot);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function set upArrow(up:DisplayObject):void
		{
			
		}
		
		/**
		 */
		 
		public function set downArrow(down:DisplayObject):void
		{
			
		}
		
		/**
		 */
		
		public function set leftArrow(left:DisplayObject):void
		{
			
		}
		
		/**
		 */
		
		public function set rightArrow(right:DisplayObject):void
		{
			
		}
		
		/**
		 */
		
		public function set verticalScrollBar(bar:DisplayObject):void
		{
			
		}
		
		/**
		 */
		
		public function set horizontalScrollBar(bar:DisplayObject):void
		{
			
		}
		
		
		/**
		 */
		
		public function set verticalScrollBack(back:DisplayObject):void
		{
			
		}
		
		
		/**
		 */
		 
		public function set horizontalScrollBack(back:DisplayObject):void
		{
			
		}
		 
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function waitForRoot(event:Event):void
		{
			if(_target.root != null && _target.stage != null)
			{
				_target.removeEventListener(Event.ENTER_FRAME,waitForRoot);
				//_parentType.resizeableObject.addEventListener(Event.RESIZE,onParentResize);
				//drawConstraints();
			}
		}
	}
}