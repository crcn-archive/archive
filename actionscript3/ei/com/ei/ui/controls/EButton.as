package com.ei.ui.controls
{
	import com.ei.display.State;
	import com.ei.display.StyleableDisplayObject;
	import com.ei.ui.core.EUIComponent;
	
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class EButton extends EUIComponent
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _button:State;
		private var _label:String;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function EButton()
		{
			super();
			
			//var sb:SimpleButton
			//states used instead of SimpleButton since SimpleButton gives some problems
			
			_button				   = new State();
			
			_button.upState        = new EButtonState();
			_button.overState      = new EButtonState();
			_button.downState      = new EButtonState();

			
			addEventListener(MouseEvent.MOUSE_OVER,onMouseEvent);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseEvent);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent);
			
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			_button.currentState = "upState";
			
			_button.buttonMode = true;
			
			addChild(_button);
		}
		
		/**
		 */
		
		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
			this.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseEvent);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		override public function set styleName(value:String):void
		{
			setButtonProperty("styleName",value);
			StyleableDisplayObject(_button.upState).styleName        = value+".upState";
			StyleableDisplayObject(_button.overState).styleName      = value+".overState";
			StyleableDisplayObject(_button.downState).styleName      = value+".downState";
		}
		
		/**
		 */
		
		public function set label(value:String):void
		{
			setButtonProperty("label",value);
		}
		
		public function get label():String
		{
			return _label;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function setButtonProperty(name:String,value:*):void
		{
			StyleableDisplayObject(_button.upState)[name]       = value;
			StyleableDisplayObject(_button.overState)[name]     = value;
			StyleableDisplayObject(_button.downState)[name]     = value;
		}
		
		/**
		 */
		
		private function onMouseEvent(event:MouseEvent):void
		{
			//trace(event.type);
			
			switch(event.type)
			{
				case MouseEvent.MOUSE_UP:
					_button.currentState = "upState";
				break;
				case MouseEvent.MOUSE_OVER:
				//	if(Mouse.
					_button.currentState = "overState";
				break;
				case MouseEvent.MOUSE_OUT:
					_button.currentState = "upState";
				break;
				case MouseEvent.MOUSE_DOWN:
					_button.currentState = "downState";
				break;
			}
			
			9
		}
		
		
	}
}