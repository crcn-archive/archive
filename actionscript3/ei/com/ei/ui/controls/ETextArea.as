package com.ei.ui.controls
{
	import com.ei.text.StyleableText;
	import com.ei.ui.core.ECanvas;
	import com.ei.utils.style.template.text.TextDrawer;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.TextFieldType;
	
	public class ETextArea extends ECanvas
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
		
		public function ETextArea() 
		{
			
			super();
			_textField 			 = new StyleableText(this.implementor);
			_textField.multiline = true;
			//wordWrap = true;

			addChild(_textField);
			
			_textField.addEventListener(Event.CHANGE,onTextChange);
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		override public function set width(value:Number):void
		{
			super.width		 = value;	
		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			super.height 	  = value;	
		}
		
		/**
		 */
		
		public function set text(value:String):void
		{
			_textField.text  = value;
			drawTextBounds();
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
			drawTextBounds();
		}
		
		public function get htmlText():String
		{
			return _textField.htmlText;
		}
		
		
		/**
		 */
		
		public function set editable(value:Boolean):void
		{
			_textField.type = TextFieldType.INPUT;
		}
		
		public function get editable():Boolean
		{
			return _textField.type == TextFieldType.INPUT;
		}
		
		/**
		 */
		
		public function set wordWrap(value:Boolean):void
		{
			_textField.wordWrap = value;
		}
		
		public function get wordWrap():Boolean
		{
			return _textField.wordWrap;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
        override protected function drawBackground():void
        {
        	super.drawBackground();
        	
        	drawTextBounds();
        }
        
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onTextChange(event:Event):void
		{
			drawTextBounds();
			changeTextPosition();
		}
		
		/**
		 */
		
		private function drawTextBounds():void
		{
			
			//var textWidthBounds:Number  = target.width - verticalScrollBar.width;
			//var textHeightBounds:Number = target.height - horizontalScrollBar.height;
			
			/*if(_textField.width < textWidthBounds)
			{
				_textField.width = textWidthBounds;
			}
			else*/
				if(_textField.wordWrap)
					_textField.width  = super.width //- verticalScrollBar.width;
				else
					_textField.width  = _textField.textWidth //+ verticalScrollBar.width;
				
			
			/*if(_textField.height < textHeightBounds)
				_textField.height = textHeightBounds;
			else
				_textField.height = _textField.textHeight + horizontalScrollBar.height;*/
			
			
			_textField.dispatchEvent(new Event(Event.RESIZE,true));
		}
		
		/**
		 */
		
		private function changeTextPosition():void
		{
			
			/*var bounds:Rectangle = _textField.getCharBoundaries(_textField.caretIndex);
			
			if(!bounds)
				return;
				
			var newY:Number = bounds.y + horizontalScrollBar.height * 2;
			var newX:Number = bounds.x + verticalScrollBar.width * 2;

			if(newY > target.height)
			{
				content.y = - (newY - target.height);
			}
			
			if(newX > target.width)
			{
				content.x = - (newX - target.width);
			}*/
		}
		
		
		/**
		 */
		
		/*private function getCaratPosition(pos:String):Number
		{
			var text:TextField = new TextField();
			
		}*/

	}
}