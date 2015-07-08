package com.bridge.ui.controls
{
	import com.bridge.ui.core.ObjectProxy;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	
	import flash.text.TextFieldType;
	
	public class TextInput extends UIComponent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _textField:ObjectProxy;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function TextInput()
		{
			super();
			
			_textField = new ObjectProxy();
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function set width(value:Number):void
		{
			super.width = value;
			
			_textField.setProperty("width",value);
		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			super.height = value;
			_textField.setProperty("height",value);
		}
		
		/**
		 */
		public function set text(value:String):void
		{
			_textField.setProperty("text",value);
		}
		
		public function get text():String
		{
			return _textField.getProperty("text");
		}
		
		/**
		 * apply this to the style.
		 */
		 
		public function set password(value:Boolean):void
		{
			_textField.ui_internal::textField.displayAsPassword = value;
		}
		
		/**
		 */
		 
		public function get password():Boolean
		{
			
			return _textField.ui_internal::textField.displayAsPassword;
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		ui_internal function set textField(value:Text):void
		{
			_textField.target = value;
			
			value.setProperty("type",TextFieldType.INPUT);
			value.setProperty("selectable",true);
		}
		
		/**
		 */
		
		ui_internal function get textField():Text
		{
			return _textField.target as Text;
		}
		

	}
}