package com.ei.psd2.rle
{
	import flash.utils.ByteArray;
	
	public class RLEParse
	{
		public static function decodeChunk(data:ByteArray,width:int,height:int):ByteArray
		{
			

			var result:ByteArray = new ByteArray();
			result.length = width * height;
			
			var sizeScanLines:Array = new Array(height);
			
			var allSize:int = 0;
			
			for(var i:int = 0; i < height; i++)
			{
				sizeScanLines[i] = data.readShort();

				allSize += sizeScanLines[i];
			}
			
			
			for(var j:int = 0; j < height; j++)
			{
				var sizeScanLine:int = sizeScanLines[j];
				
				var out:ByteArray = new ByteArray();
				out.length = sizeScanLine;
				
				data.readBytes(out,0,data.bytesAvailable);
				
				var line:ByteArray = RLEPackBits.unpack(out,width);
				
				
				
				arrayCopy(line,0,result,j * width,line.length);
				
				
				
			}
			
			return result;
		}
		
		private static function arrayCopy(src:ByteArray,start:int,dest:ByteArray,index:int,num:int):void
		{
			var cInd:int = index;
			
			for(var i:int = start; i < num + start; i++)
			{
				dest[cInd] = src[i];
				
				cInd++;
			}
		}

	}
}