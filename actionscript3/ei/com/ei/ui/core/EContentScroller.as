package com.ei.ui.core
{
	import com.ei.display.IStyleableDisplayObject;
	import com.ei.display.StyleableDisplayObject;
	import com.ei.ui.decor.scroll.ContentScroller;
	import com.ei.ui.decor.scroll.ScrollComponent;
	
	import flash.display.Sprite;
	
	
	public class EContentScroller extends ContentScroller
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _styleName:String;
		
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function EContentScroller()
		{
			super();
			
			this.verticalScrollBar.scrollMore	    = new ECanvas();
			this.verticalScrollBar.scrollLess 	    = new ECanvas();
			this.verticalScrollBar.scrollBackground = new ECanvas();
			this.verticalScrollBar.scroller  	    = new ECanvas();
			Sprite(this.verticalScrollBar.scroller).buttonMode = true;
			
			this.horizontalScrollBar.scrollMore	      = new ECanvas();
			this.horizontalScrollBar.scrollLess 	  = new ECanvas();
			this.horizontalScrollBar.scrollBackground = new ECanvas();
			this.horizontalScrollBar.scroller  	      = new ECanvas();
			Sprite(this.horizontalScrollBar.scroller).buttonMode = true;
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function set styleName(value:String):void
		{
			// messy = rush job
			
			IStyleableDisplayObject(ScrollComponent(this.verticalScrollBar.scrollMore).target).styleName 	  = value+".verticalScrollBar.moreButton";
			IStyleableDisplayObject(ScrollComponent(this.verticalScrollBar.scrollLess).target).styleName 	  = value+".verticalScrollBar.lessButton";
			IStyleableDisplayObject(ScrollComponent(this.verticalScrollBar.scrollBackground).target).styleName = value+".verticalScrollBar.background";
			IStyleableDisplayObject(ScrollComponent(this.verticalScrollBar.scroller).target).styleName 	      = value+".verticalScrollBar.scroller";
			
			IStyleableDisplayObject(ScrollComponent(this.horizontalScrollBar.scrollMore).target).styleName 	      = value+".horizontalScrollBar.moreButton";
			IStyleableDisplayObject(ScrollComponent(this.horizontalScrollBar.scrollLess).target).styleName 	      = value+".horizontalScrollBar.lessButton";
			IStyleableDisplayObject(ScrollComponent(this.horizontalScrollBar.scrollBackground).target).styleName   = value+".horizontalScrollBar.background";
			IStyleableDisplayObject(ScrollComponent(this.horizontalScrollBar.scroller).target).styleName 	      = value+".horizontalScrollBar.scroller";
			
		}
		
		public function get styleName():String
		{
			return _styleName;
		}
		
		
	}
}