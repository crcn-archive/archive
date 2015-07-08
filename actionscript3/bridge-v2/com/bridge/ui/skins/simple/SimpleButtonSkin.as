package com.bridge.ui.skins.simple
{
	import com.bridge.ui.controls.Button;
	import com.bridge.ui.controls.Canvas;
	import com.bridge.ui.controls.Label;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.skins.UISkin;
	import com.bridge.ui.style.Style;
	
	import flash.display.DisplayObject;
	
	public class SimpleButtonSkin extends UISkin
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function SimpleButtonSkin(controller:Button,style:Style)
		{
			
			super(controller,style);
			
			var canv:Canvas = new Canvas();
			canv.styleName  = "ButtonMouseUp";
			
			
			var mouseUp:DisplayObject   = addChild(canv);
			var mouseOut:DisplayObject  = addChild(canv);
			
			canv = new Canvas();
			canv.styleName  = "ButtonMouseOver";
			
			var mouseOver:DisplayObject = addChild(canv);
			
			
			
			var canv:Canvas = new Canvas();
			canv.styleName  = "ButtonMouseDown";
			
			var mouseDown:DisplayObject = addChild(canv);
			
			states.addState("mouseUp",mouseUp);
			states.addState("mouseOver",mouseOver);
			states.addState("mouseDown",mouseDown);
			states.addState("mouseOut",mouseOut);
			
			states.currentState = "mouseUp";
			
			
			
			
			var text:Label = new Label();
			controller.ui_internal::text = text;
			addChild(text);
		}
		
		

	}
}