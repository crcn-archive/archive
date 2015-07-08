package com.ei.psd2
{
	import com.endogine.serialization.RLECodec;
	
	import flash.utils.ByteArray;
	
	public class PixelData
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _height:int;
        private var _width:int;
        private var _bitsPerPixel:int;
        private var _numChannels:int;
        private var _isMerged:Boolean;
        private var _channelData:Array;
        
        private var _lineLengths:Array;
        private var _lineIndex:int;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function PixelData(width:int,height:int,bitsPerPixel:int,numChannels:int,isMerged:Boolean)
		{
			_width = width;
			_height = height;
			_bitsPerPixel = bitsPerPixel;
			_numChannels = numChannels;
			_isMerged = isMerged;
			_channelData = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function read(reader:BinaryPSDReader):void
		{
			//trace(reader.position);
			var comp:int = Compression.NONE;
			
			if(_isMerged)
			{
				comp = reader.readUint16();
				
				for(var i:int = 0; i < _numChannels; i++)
				{
					preReadPixels(reader,comp);
				}
			}
			
			
			for(var i:int = 0; i < _numChannels; i++)
			{
				if(!_isMerged)
				{
					
					comp = reader.readUint16();
					
				
					preReadPixels(reader,comp);
				}
				
				
				_channelData.push(readPixels(reader,comp));
			}
		}
		
		/**
		 */
		
		public function getChannelData(index:int):ByteArray
		{
			return _channelData[index];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         */
        
        private function preReadPixels(reader:BinaryPSDReader,compression:int):void
        {
        	switch (compression)
            {
                case Compression.RLE:
                    //ignore rle "header" with bytes per row...
                    //reader.BaseStream.Position += this._height * 2;
                    reader.baseStream.position += _height * 2;
                    //ushort[] rowLenghtList = new ushort[height];
                    //for (int i = 0; i < height; i++)
                    //    rowLenghtList[i] = reader.ReadUInt16();
                    break;
            }
            
           
        }
        
		/**
		 */
		
		private function readPixels(reader:BinaryPSDReader,compression:int):ByteArray
		{
		
			
			var bytesPerPixelPerChannel:int = _bitsPerPixel / 8;
			
			if(bytesPerPixelPerChannel < 1)
				bytesPerPixelPerChannel = 1;
				
			var bytesPerRow:int = _width * bytesPerPixelPerChannel;
			var totalBytes:int = bytesPerRow * _height;
			

			var pData:ByteArray = new ByteArray();
			pData.length = totalBytes;
			
			if(totalBytes < 0)
				return null;
			
			
			switch(compression)
			{
				case Compression.NONE:
					
					reader.read(pData,0,totalBytes);
				break;
				case Compression.RLE:
					
					
					
					for(var i:int = 0; i < _height; i++)
					{
						
						var offset:int = i * _width;
						var numDecodedBytes:int = 0;
						var numChunks:int = 0;
						
						while(numDecodedBytes < _width)
						{
							//trace(numDecodedBytes,_width,_height,numChunks);
							numDecodedBytes += RLECodec.decodeChunc(reader.baseStream,pData,offset + numDecodedBytes);
							numChunks++;
						}
					}
					
					
					
					//pData = arrayToByte(ar);
					
					//this.readLineLengths(reader,_height);
					//pData = this.readPlaneCompressed(reader);
					
					
					/*
					for (var i:int = 0; i < _height; i++)
                    {
                        var offset:int = i * this._width;
                        var numDecodedBytes:int = 0;
                       	var numChunks:int = 0;
                       	
                        while (numDecodedBytes < _width)
                        {
                            numDecodedBytes += RLECodec.decodeChunc(reader.baseStream, pData, offset + numDecodedBytes);
                            trace(numDecodedBytes,_width);
                            numChunks++;
                        }
                    }*/
                break;
					
			}
			
			return pData;
		}

	}
}