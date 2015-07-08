package com.bridge.ui.utils.tween.handle
{
	import com.bridge.ui.core.UIComponent;
	
	public class StyleHandler
	{
		
		public static function styleTweenHandler(item:UIComponent, property:Object, currentTime:Number, start:Object, stop:Object, duration:Number, easingFunction:Function):void
		{
			/*var proxy:Object;
						
			for(var prop:String in stop)
			{
				
				proxy = new Object();
				
				var property:* = item.implementor.getProperty(prop);
				
				//if the property is not defined we'll start at zero x = undefined x = 0
				if(!property)
				{
					property = 0;
				}
				
				switch(prop)
				{
					//colors are the ONLY exception to tweening
					case "backgroundColors":
						colorTweenHandler(proxy,prop,currentTime,property,stop[prop],duration,easingFunction);
					break;
					default:
						defaultHandler(proxy,prop,currentTime,property as Number,stop[prop],duration,easingFunction);
					break;
				}
				
				trace(prop,proxy[prop]);
				if(proxy[prop])
					item.implementor.setProperty(prop,proxy[prop]);
				
			}*/
			
		}
		
		public static function defaultHandler(item:Object, property:String, currentTime:Number, start:Number, stop:Number, duration:Number, easingFunction:Function):void
		{
			//get the new position
			var change:Number = stop - start;
			var newPosition:Number = easingFunction(currentTime, start, change, duration);
			
			
			if(!isNaN(newPosition))
			{
				item[ property ] = newPosition;
			}
		}
	}
}



