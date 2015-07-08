package com.bridge
{
	
	public class BridgeCore
	{
		
		
		[Embed(source="bridgeCore.xml",mimeType="application/octet-stream")]
		private static var _script:Class;
		
		
		/**
		 * the Bridge script used to execute the required code to run any application.
		 */
		
		public static function get script():String
		{
			var com:BridgeDefinitions;
			
			return new _script();
		}

	}
}
			