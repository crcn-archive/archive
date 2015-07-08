package com.ei.ui.controls
{
	import com.ei.text.StyleableText;
	import com.ei.ui.core.EUIComponent;
	import com.ei.utils.style.template.text.TextDrawer;
	
	import flash.events.Event;
	
	public class ELabel extends EUIComponent
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _textField:StyleableText;
		private var _drawer:TextDrawer;
		private var _widthSet:Boolean;
		private var _heightSet:Boolean;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function ELabel() 
		{
			
			super();
			_textField 			 = new StyleableText(this.implementor);
			_textField.autoSize  = "left";
			
			_textField.text = "";
			
			addChild(_textField);
			

		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------

		/**
		 */
		
		public function set text(value:String):void
		{
			_textField.text  = value;
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		public function get text():String
		{
			return _textField.text;
		}
		
		/**
		 */
		
		public function set htmlText(value:String):void
		{
			_textField.htmlText = value;
		}
		
		public function get htmlText():String
		{
			return _textField.htmlText;
		}
		
		/**
		 */
		 
		public function set autoSize(value:String):void
		{
			_textField.autoSize = value;
		}
		
		public function get autoSize():String
		{
			return _textField.autoSize;
		}
	}
}