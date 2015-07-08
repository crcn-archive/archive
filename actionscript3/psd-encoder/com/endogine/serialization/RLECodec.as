package com.endogine.serialization
{
	import flash.utils.ByteArray;
	
	public class RLECodec
	{
		public static function decodeChunc(reader:ByteArray, destinationBuffer:ByteArray,bufferOffset:int):int
		{
			var numUncompressedWritten:int = 0;
			
			var len:int = reader.readByte() & 0xFF;
			

			if(len < 128)
			{
				var numUncompressedToRead = len + 1;
				numUncompressedWritten = numUncompressedToRead;
				
				while (numUncompressedToRead != 0)
                {
                	
                    destinationBuffer[bufferOffset] = reader.readByte() & 0xFF;
                    
                    bufferOffset++;
                    numUncompressedToRead--;
                }
			}
			
			else if (len > 128)
            {
            	
                //more than 128: RLE-compressed pixels
                var numCompressedToRead:int = (len ^ 0xff) + 2;

                numUncompressedWritten = numCompressedToRead;

                // Next -len+1 bytes in the dest are replicated from next source byte.
                // (Interpret len as a negative 8-bit int.)
                //									len ^= 0x0FF;
                //									len += 2;
                var byteValue:int = reader.readByte();

                while (numCompressedToRead != 0)
                {
                    destinationBuffer[bufferOffset] = byteValue & 0xFF;
                    bufferOffset++;
                    numCompressedToRead--;
                }
            }
            else if (len == 128)
            {
                // Do nothing
            }

            return numUncompressedWritten;
		}
	}
	
}