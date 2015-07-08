
/******************************************************************
 * DisplayText - renders text as a bitmap so other properties can 
 * be used on it														
 *  
 * Author: Craig Condon
 * 
 * Purpose: so the other properties canbe used such as alpha, and
 * because when button mode is on Sprites, the arrow shows on the 
 * text
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/
package com.ei.text
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class DisplayText extends Sprite
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _text:TextField;

		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------

		/**
		*/
		
		public function DisplayText(text:TextField)
		{
			_text = text;
			_text.addEventListener(Event.CHANGE,onTextChange);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function redraw():void
		{
			
			for(var i:int = 0; i < this.numChildren; i++)
			{
				this.removeChildAt(0);
			}
			
			
			var bitmapData:BitmapData = new BitmapData(_text.width,_text.height,true,0xFFFFFF);
			bitmapData.draw(_text);
			var bitmap:Bitmap = new Bitmap(bitmapData);
			
			addChild(bitmap);
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
			redraw();
		}


	}
}