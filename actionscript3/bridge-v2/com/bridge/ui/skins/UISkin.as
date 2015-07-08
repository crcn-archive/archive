package com.bridge.ui.skins
{
	import com.bridge.events.StyleEvent;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.style.Style;
	import com.ei.utils.info.ClassInfo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	public class UISkin extends Sprite implements ISkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------

		//used for when a property might not exist or multiple properties are being set
		//for instance: 
		/*
		
		target.ignoreChanges = true;
		target.width = 100;
		target.height = 100;
		target.refresh();
		
		= quicker
		
		*/
        public var ignoreChanges:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _controller:UIComponent;
		private var _style:Style;
		private var _initialized:Boolean;
		private var _states:States;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function UISkin(controller:UIComponent,style:Style)
		{
			_controller = controller;
			_style	    = style;
			_states 	= new States(this);
			
			_controller.ui_internal::view = this;
			
			_style.addEventListener(StyleEvent.CHANGE,onStyleChange,false,0,true);
			addEventListener(Event.ADDED_TO_STAGE,init2,false,1,false);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set currentState(name:String):void
		{
			_states.currentState = name;
		}
		
		public function get currentState():String
		{
			return _states.currentState;
		}
		
		/**
		 */
		
		public function get controller():UIComponent
		{
			return _controller;
		}
		
		/**
		 */
		public function get style():Style
		{
			return _style;
		}
		
		/**
		 */
		 
		override public function get width():Number
		{
			return _style.getProperty("width");
		}
		
		/**
		 */
		 
		override public function get height():Number
		{
			return _style.getProperty("height");
		}
		
		/**
		 */
		override public function set x(value:Number):void
		{
			_controller.x = value;
		}
		
		/**
		 */
		 
		override public function get x():Number
		{
			return _controller.x;
		}
		
		/**
		 */
		 
		override public function set y(value:Number):void
		{
			_controller.y = value;
		}
		
		override public function get y():Number
		{
			return _controller.y;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function setProperty(name:String,value:*):void
		{
			_style.setProperty(name,value);
		}
		
		/**
		 */
		public function getProperty(name:String):*
		{
			return _style.getProperty(name);
		}
		
		/**
		 */
		 
		public function refresh():void
		{
			this.change();
		}

		
		/**
		 */
		public function clone(controller:UIComponent,style:Style):UISkin
		{
			var info:ClassInfo = new ClassInfo(this);
			
			
			var clazz = flash.utils.getDefinitionByName(info.name);
			
			return new clazz(controller,style);
		}
		
		/**
		 * bubble up once
		 */
		
		override public function dispatchEvent(event:Event):Boolean
		{
			controller.update();
			return super.dispatchEvent(event);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		protected function onStyleChange(event:StyleEvent):void
		{
			
			if(_initialized && ignoreChanges)
			{
				//trace("UISkin::onStyleChange()",event.property,event.value);
			
				change();
			}
		}
		
		/**
		 */
		protected function get states():States
		{
			return _states;
		}
		
		
		
		/**
		 */
		 
		protected function init():void
		{
			//abstract
		}
		
		/**
		 */
		protected function change():void
		{
			//abstract
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function init2(event:Event):void
		{
			event.target.removeEventListener(event.type,init2);
			
			
			init();
			
			_initialized = true;
		}
	}
}