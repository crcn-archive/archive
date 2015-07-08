package com.ei.psd2.rle
{
	import flash.utils.ByteArray;
	
	public class RLEPackBits
	{
		
		public static function unpack(data:ByteArray,size:int):ByteArray
		{
			
			var result:ByteArray = new ByteArray();
			result.length = size;
			
			var writePos:int = 0;
			var readPos:int = 0;
			
			while(readPos < data.length)
			{
				var n:int = data[readPos++];
				
				if(n > 0)
				{
					var count:int = n + 1;
					
					for(var j:int = 0; j < count; j++)
					{
						result[writePos++] = data[readPos++];
					}
				}
				else
				{
					var b:int = data[readPos++];
					
					var count:int = -n + 1;
					
					for(var j:int = 0; j < count; j++)
					{
						result[writePos++] = b;
					}
				}
			}
			
			return result;
			
		}
		
		

	}
}