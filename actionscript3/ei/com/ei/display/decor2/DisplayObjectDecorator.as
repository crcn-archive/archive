package com.ei.display.decor2
{
	import com.ei.events.DisplayObjectDecoratorEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	public class DisplayObjectDecorator extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _target:DisplayObjectContainer;
		
		private var _manager:LayoutManager;
		
		
		private var _isReady:Boolean;
		
		private var _index:int;
		
		private var _enabled:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function DisplayObjectDecorator(target:DisplayObjectContainer,index:int = -1)
		{
			_target = target;
			_index = index;
			
			enable();
			
			_target.addEventListener(DisplayObjectDecoratorEvent.DECORATOR_REQUEST,onDecoratorRequest);
			onDecoratorRequest();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get target():DisplayObjectContainer
		{
			return _target;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function glue(manager:LayoutManager):void
		{
			_manager = manager;
			
			refresh();
		}
		
		/**
		 */
		
		public function unglue():void
		{
			_manager = null;
		}
		
		/**
		 */
		
		public function enable():void
		{
			_enabled = true;
		}
		
		/**
		 */
		
		public function disable():void
		{
			_enabled = false;
		}
		
		
		//so that child classes arent too free, we want to optimize
		//te display object's performance by only allowing them to
		// refresh when there is a layout manager glued to it
		final public function refresh():void
		{
			
			if(_manager != null && _enabled)
				refresh2();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------

		/**
		 */
		 
		 
		//this is where the refresh goes for all the child classes
		
		protected function refresh2():void
		{
			//abstract
		}
		
		/**
		 */
		
		protected function set isReady(value:Boolean):void
		{
			_isReady = value;
			
			if(_isReady && _manager == null)
			{
				dispatchReadyEvent();
			}
			else
			{
				
				//_target.dispatchEvent(new DisplayObjectDecoratorEvent(DisplayObjectDecoratorEvent.REMOVE_RECORATOR,this));
				refresh();
			}
			
		}
		
		/**
		 */
		
		protected function get isReady():Boolean
		{
			return _isReady;
		}
		
		/**
		 */
		
		protected function get manager():LayoutManager
		{
			return _manager;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onDecoratorRequest(event:DisplayObjectDecoratorEvent = null):void
		{
			
			//make sure that the object
			if(isReady)
				dispatchReadyEvent();
		}
		
		/**
		 */
		
		private function dispatchReadyEvent()
		{
			_target.dispatchEvent(new DisplayObjectDecoratorEvent(DisplayObjectDecoratorEvent.DECORATOR_RESPONSE,this,_index));
		}
		
	}
}