package com.ei.display.decor
{
	public interface IConstrainable
	{
		 function set left(pos:Number):void;
		 function get left():Number;
		
		 function set right(pos:Number):void;
		 function get right():Number;
		
		 function set top(pos:Number):void;
		 function get top():Number;
		
		 function set bottom(pos:Number):void;
		 function get bottom():Number;
		
		 function set verticalCenter(pos:Number):void;
		 function get verticalCenter():Number;
		
		 function set horizontalCenter(pos:Number):void;
		 function get horizontalCenter():Number;
		 
		 function set restrictBounds(value:Boolean):void;
		 function get restrictBounds():Boolean;
		 
		 function set constrain(value:Boolean):void;
		 function get constrain():Boolean;
		
	}
}