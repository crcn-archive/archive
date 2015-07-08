package com.ei.ui.controls
{
	import com.ei.events.StyleEvent;
	import com.ei.text.DisplayText;
	import com.ei.text.StyleableText;
	import com.ei.ui.core.ECanvas;
	import com.ei.ui.core.EUIComponent;
	
	
	
	
	public class EButtonState extends ECanvas
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _text:StyleableText;
		private var _displayText:DisplayText;
		private var _textHolder:EUIComponent;
		private var _centerText:Boolean;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function EButtonState()
		{
			super();
			_text = new StyleableText(this.implementor);
			_text.autoSize = "left";
			_text.selectable = false;
			
			_textHolder = new EUIComponent();
			_displayText = new DisplayText(_text);
			_textHolder.addChild(_displayText);
			
			
			
			addChild(_textHolder);
			
			this.implementor.addEventListener(StyleEvent.CHANGE,onStyleChange);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------

		/**
		 */
		
		public function set label(text:String):void
		{
			_text.text = text;
			_displayText.redraw();
		}
		
		/**
		 */
		
		public function get label():String
		{
			return _text.text;
		}
		
		
		//----------------------
		// Dimension
		//----------------------
		
		
		/**
		 */
		 
		public function set centerText(value:Boolean):void
		{
			_centerText = value;
			 
			 if(_centerText)
			 {
			 	_textHolder.horizontalCenter = 0;
			 	_textHolder.verticalCenter   = 0;
			 }
			
		}
		
		/**
		 */
		
		public function get centerText():Boolean
		{
			return _centerText;
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
			_displayText.redraw();
		}
		
		
		
	}
}