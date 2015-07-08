// ActionScript file
package com.ei.display.decor2
{

	import com.ei.events.DisplayObjectDecoratorEvent;
	
	import flash.display.DisplayObject;
	
	
	
	function getDisplayObjectDecorators(target:DisplayObject):Array
	{
		
		var decorators:Array = new Array();
				
		function callback(decorator:DisplayObjectDecorator):void
		{
			decorators.push(decorator);
		}
			
		
		//target.dispatchEvent(new DisplayObjectDecoratorEvent(DisplayObjectDecoratorEvent.FIND_DECORATOR,callback));
			
			
				
		return decorators;
	}

}