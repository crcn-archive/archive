/******************************************************************
 * EText - an interface for a text field for other classes to 
 * use. InputText and TextArea both use this class since they 
 * share very similar functionality, but don't inherit from this
 * class because they have totally different functions.												
 *  
 * Author: Craig Condon
 * 
 * Purpose: to separate and create a decoupled text handler that
 * implements the StyleableDisplayObject, making it accessible to
 * CSS. It also uses the DisplayText class which automatically turns
 * a text
 * 
 * Usage: used in any class that inherits the StyleableDisplayObject 
 * class
 * 
 * copyright © 2008 Craig Condon
 * 
 ******************************************************************/

package com.ei.text
{
	
	import com.ei.utils.style.StyleImp;
	import com.ei.utils.style.template.text.TextDrawer;
	
	import flash.events.Event;
	import flash.text.TextField;
	
	
	public class StyleableText extends TextField
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _textField:TextField;
		private var _drawer:TextDrawer;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function StyleableText(implementor:StyleImp)
		{
			super();
			_drawer		   = new TextDrawer(this,implementor);
		}
		

	}
}