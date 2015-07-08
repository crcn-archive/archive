package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.Text;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.skins.UISkin;
	import com.bridge.ui.style.Style;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class SimpleTextSkin extends UISkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _textField:TextField;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SimpleTextSkin(controller:Text,style:Style)
		{
			super(controller,style);
			
			
			_textField = new TextField();
			controller.ui_internal::textField = _textField;
			
			addChild(_textField);
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		override protected function init():void
		{
			setTextStyle();
		}
		
        /**
		 */
		 
		override protected function change():void
		{
			setTextStyle();
		}
		
		/**
		 */
		protected function get textField():TextField
		{
			return _textField;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function setTextStyle():void
		{
			
			
			var textFormat:TextFormat = new TextFormat(style.getProperty("fontFace"),
													   style.getProperty("fontSize"),
													   style.getProperty("fontColor"),
													   style.getProperty("bold"),
													   style.getProperty("italic"),
													   style.getProperty("underline"),
													   style.getProperty("url"),
													   style.getProperty("fontTarget"),
													   style.getProperty("align"),
													   style.getProperty("fontLeftMargin"),
													   style.getProperty("fontRightMargin"),
													   style.getProperty("fontIndent"),
													   style.getProperty("fontLeading"));
			
			if(style.getProperty("width"))
				_textField.width = style.getProperty("width");
				
			if(style.getProperty("height"))
				_textField.height = style.getProperty("height");
			
			if(style.getProperty("selectable") != null)
				_textField.selectable = style.getProperty("selectable");
			
			if(style.getProperty("multiline"))
				_textField.multiline = style.getProperty("multiline");
			
			
			if(style.getProperty("wordWrap"))
				_textField.wordWrap = style.getProperty("wordWrap");
			
														   
			_textField.defaultTextFormat = textFormat;
			
			if(style.getProperty("fontFace") is String)
				_textField.embedFonts = true;
				
				
			//refresh the font
			_textField.text = _textField.text;
		}

	}
}