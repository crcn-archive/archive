package com.ei.display.decor
{
	public interface IBox
	{
		function set alignment(value:String):void;
		function get alignment():String;
		function set margin(value:Number):void;
		function get margin():Number;
		function set shrinking(value:Number):void;
		function get shrinking():Number;
	}
}