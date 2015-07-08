package com.ei.ui.decor.scroll
{
	import flash.display.Sprite;
	
	public interface IContentScroller
	{
		function get verticalScrollBar():ScrollBar;
		function get horizontalScrollBar():ScrollBar;
		function get content():Sprite;
	}
}