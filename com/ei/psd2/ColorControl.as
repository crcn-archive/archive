package com.ei.psd2
{
	public class ColorControl
	{
		
		public static function fromARGB(a:int,r:int,g:int,b:int):int
		{
			
			
			var ac:int = a & 0xff;
			var rc:int = r & 0xff;
			var gc:int = g & 0xff;
			var bc:int = b & 0xff;
					
					
			return (((((ac << 8) | rc) << 8) | gc) << 8) | bc;
		}
		
		public static function fromRGB(r:int,g:int,b:int):int
		{
			
			
			var ac:int = 255 & 0xff;
			var rc:int = r & 0xff;
			var gc:int = g & 0xff;
			var bc:int = b & 0xff;
					
					
			return (((((ac << 8) | rc) << 8) | gc) << 8) | bc;
		}
		
		public static function fromRGB2(r:int,g:int,b:int):int
		{	
			return (r << 16 | g << 8 | b) | b;
		}
	}
}