package com.ei.display
{
	import com.ei.utils.style.IStyleable;
	import com.ei.utils.style.StyleImp;
	
	public interface IStyleableDisplayObject extends IStyleable
	{
		function get implementor():StyleImp;
		function setProperty(name:*,value:*):void;
	}
}