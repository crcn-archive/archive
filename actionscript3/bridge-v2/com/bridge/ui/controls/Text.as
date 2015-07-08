package com.bridge.ui.controls
{
	import com.bridge.ui.core.ObjectProxy;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	
	import flash.text.TextField;
	
	public class Text extends UIComponent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _textFieldProxy:ObjectProxy
		
		private var _text:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function Text()
		{
			super();
			
			_textFieldProxy = new ObjectProxy();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		override public function get width():Number
		{
			return _textFieldProxy.getProperty("width");
		}
		
		/**
		 */
		override public function get height():Number
		{
			return _textFieldProxy.getProperty("height");
		}
		
		/**
		 */
		
		public function set text(value:String):void
		{
			_textFieldProxy.setProperty("text",value);
			
			if(_text)
				var oldLength:int = _text.length;
				
			_text = value;
			
			//even though text may have 4 characters, it can change size
			if(oldLength != _text.length)
				this.update();
		}
		
		public function get text():String
		{
			return _text;
		}
		
		
		/**
		 */
		
		public function setProperty(type:String,value:Object):void
		{
			
			_textFieldProxy.setProperty(type,value);
		}
		
		/**
		 */
		
		public function getProperty(type:String):Object
		{
			return _textFieldProxy.getProperty("type");
		}
		
		/**
		 */
		
		ui_internal function set textField(value:TextField):void
		{
			this.textField = value;
			
			
		}
		
		ui_internal function get textField():TextField
		{
			return this.textField;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * enable overriding
		 */
		 
		protected function set textField(value:TextField):void
		{
			_textFieldProxy.target = value;
		}
		
		protected function get textField():TextField
		{
			return _textFieldProxy.target as TextField;
		}

	}
}