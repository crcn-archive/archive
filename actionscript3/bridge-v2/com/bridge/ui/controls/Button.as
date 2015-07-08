package com.bridge.ui.controls
{
	import com.bridge.ui.controls.scroll.ScrollMask;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	
	import flash.events.MouseEvent;
	
	public class Button extends UIComponent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _text:Text;
		private var _label:String;
		private var _hitTest:ScrollMask;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function Button()
		{
			super();
			
			addEventListener(MouseEvent.MOUSE_UP,onMouseEvent);
			addEventListener(MouseEvent.MOUSE_OVER,onMouseEvent);
			addEventListener(MouseEvent.MOUSE_DOWN,onMouseEvent);
			addEventListener(MouseEvent.MOUSE_OUT,onMouseEvent);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function set label(value:String):void
		{
			_label = value;
			
			if(_text)
			{
				_text.text = value;
			}
		}
		
		public function get label():String
		{
			return _label;
		}
		
		
		ui_internal function set text(value:Text):void
		{
			_text = value;
		}
		
		ui_internal function get text():Text
		{
			return _text;
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
			super.init();
			
			if(ui_internal::text)
			{
				ui_internal::text.text = _label;
			}
			
			
			//create a hit test area
			_hitTest = new ScrollMask();
			_hitTest.buttonMode = true;
			_hitTest.alpha = 0;
			addChild(_hitTest);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onMouseEvent(event:MouseEvent):void
		{
			ui_internal::skin.currentState = event.type;
		}

	}
}