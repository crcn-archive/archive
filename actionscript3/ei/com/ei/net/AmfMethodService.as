	

package com.ei.net
{
	import com.ei.events.AmfEvent;
	
	import flash.events.EventDispatcher;
	
	dynamic public class AmfMethodService extends EventDispatcher
	{
		
		public var data:Object;
		public var info:Object;
		public var command:String;
		
		
		public var name:String;
		
		public function onResult(result:Object):void{
			data = result;
			dispatchEvent(new AmfEvent(AmfEvent.RESULT));
		}
		
		public function onFault(result:Object):void{
			data = result;
			dispatchEvent(new AmfEvent(AmfEvent.FAULT));
		}

		
	}
}