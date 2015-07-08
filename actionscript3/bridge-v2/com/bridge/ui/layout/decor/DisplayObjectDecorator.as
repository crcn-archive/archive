package com.bridge.ui.layout.decor
{
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.layout.LayoutManager;
	import com.bridge.ui.style.Style;
	import com.ei.utils.ParentType;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.EventDispatcher;
	
	dynamic public class DisplayObjectDecorator extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var priority:int;
		public var active:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _target:DisplayObjectContainer;
		private var _layoutManager:LayoutManager;
		private var _currentParent:ParentType;
		private var _enabled:Boolean;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DisplayObjectDecorator(priority:int = -1)
		{
			this.priority = priority;
			_enabled = true;
		}

		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		ui_internal function set layoutManager(value:LayoutManager):void
		{
			_layoutManager = value;
		}
		
		/**
		 */
		ui_internal function get layoutManager():LayoutManager
		{
			return _layoutManager;
		}
		
		/**
		 */
		public function set enabled(value:Boolean):void
		{
			_enabled = value;
		}
		
		/**
		 */
		
		public function get properties():Array
		{
			return [];
		}
		
		/**
		 */
		
		public function set currentTarget(value:DisplayObjectContainer):void
		{
			_target = value;
			
			if(_target.parent)
				_currentParent = new ParentType(_target);
		}
		
		/**
		 */
		public function get currentTarget():DisplayObjectContainer
		{
			return _target;
		}
		
		/**
		 */
		public function get currentParent():ParentType
		{
			return _currentParent;
		}
		
		/**
		 */
		
		public function get refreshTypes():Array
		{
			return [RefreshType.PARENT_RESIZE];
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function setProperty(name:String,value:*,draw:Boolean = true):void
		{
			this[name] = value;
			
			if(draw)	
				ui_internal::draw();
		}
		

		
		/**
		 */
		public function findProperties(style:Style):Array
		{
			for each(var property:String in properties)
			{
				if(style.containsKey(property))
				{
					
					return properties;
				}
			}
			
			return null;
		}
		
		/**
		 */
		 
		ui_internal function draw():void
		{
			if(_enabled)
				draw2();
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		protected function draw2():void
		{
			//abstract
		}
		
	}
}