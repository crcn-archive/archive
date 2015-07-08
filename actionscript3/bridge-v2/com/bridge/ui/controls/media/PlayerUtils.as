package com.bridge.ui.controls.media
{
	public class PlayerUtils
	{
		
		public static function getTime(rawTime:Number):String
		{
			var newTime:Number = rawTime / 60;
			var minutes:Number = Math.floor(newTime);
			var seconds:Number = Math.floor(Math.abs(minutes - newTime) * 60);
			
			
			var nseconds:String = String(seconds);
			
			if(seconds < 10)
			{
				nseconds = 0+nseconds;
			}
			
			return minutes+":"+nseconds;
		}

	}
}