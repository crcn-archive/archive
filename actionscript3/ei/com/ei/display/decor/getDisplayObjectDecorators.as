// ActionScript file
package com.ei.display.decor
{

	import com.ei.display.decor.DisplayObjectDecorator;
	import com.ei.events.DisplayObjectDecoratorEvent;
	
	import flash.display.DisplayObject;
	
	
	
	function getDisplayObjectDecorators(target:DisplayObject,clazz:Class):Array
	{
		
		var decorators:Array = new Array();
				
		function callback(decorator:DisplayObjectDecorator):void
		{
			decorators.push(decorator);
		}
			
		
	//	target.dispatchEvent(new DisplayObjectDecoratorEvent(DisplayObjectDecoratorEvent.FIND_DECORATOR,callback));
			
			
				
		return decorators;
	}

}