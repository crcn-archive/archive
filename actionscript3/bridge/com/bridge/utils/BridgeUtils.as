package com.bridge.utils
{
	import com.bridge.node.BridgeNode;
	
	public class BridgeUtils
	{
		
		/**
		 * loops through all the nodes starting from a particular node (assoc. with load manager)
		 */
		
		public static function everyNode(start:BridgeNode,callback:Function):void
		{
			callback(start);
			
			
			var currentSibling:BridgeNode = start;
			
			while(currentSibling)
			{	
				callback(currentSibling);
				
				
				if(currentSibling.hasChildNodes())
					everyNode(currentSibling.firstChild,callback);
				
				
				
				currentSibling = currentSibling.nextSibling;
			}
		}

	}
}