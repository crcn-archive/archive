package com.bridge.ui.layout
{
	import com.bridge.ui.style.Style;
	
	import flash.events.IEventDispatcher;
	
	public interface ILayoutManageable extends IEventDispatcher
	{
		function get currentStyle():Style;
		function update():void;
	}
}