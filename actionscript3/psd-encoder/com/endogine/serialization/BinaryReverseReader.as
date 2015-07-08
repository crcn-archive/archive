package com.endogine.serialization
{
	import flash.utils.ByteArray;
	
	public class BinaryReverseReader extends BinaryReaderEx
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function BinaryReverseReader(stream:ByteArray)
		{
			super(stream);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function readPSD8BitSingle():int
		{
			return baseStream.readByte() + baseStream.readByte();
		}
		
		/**
		 */
		
		public function readPSDSingle():int
		{
			return readSingle();
		}
		
		/**
		 */
		
		public function readPSDFixedSingle():Number
		{
			return readSingle();
		}
		
		/**
		 */
		
		public function readInt16():int
		{
			var val:int = baseStream.readShort();
			
			
			return val;
			//return swapShort(val);
			
		}
		
		/**
		 */
		
		public function readInt32():int
		{
			var val:int = baseStream.readInt();
			
			
			return val;
			//return swapInt(val);
		}
		
		/**
		 */
		
		public function readInt64():Number
		{
			var val:int = baseStream.readDouble(); //readFloat()??
			
			return val;
			//return swapLong(val);
		}
		
		/**
		 */
		
		public function readUint16():int
		{
			var val:uint = baseStream.readUnsignedShort();
			
			return val;
			//return swapShort(val);
		}
		
		/**
		 */
		
		public function readUint32():int
		{
			var val:uint = baseStream.readUnsignedInt();
			
			return val;
			//return swapInt(val);
		}
		
		/**
		 */
		
		public function readUint64():int
		{
			var val:uint = baseStream.readUnsignedInt(); //no readUnsignedDouble Float Long??
			
			return val;
			//return swapLong(val);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		
		protected function swapShort(value:int):int
		{
			var b1:int = value & 0xff;
			var b2:int = (value >> 8) & 0xff;
			
			return (b1 << 8 | b2 << 0);
		}
		
		/**
		 */
		
		protected function swapInt(value:int):int
		{
			var b1:int = (value >> 0) & 0xff;
			var b2:int = (value >> 8) & 0xff;
			var b3:int = (value >> 16) & 0xff;
			var b4:int = (value >> 24) & 0xff;
			
			return b1 << 24 | b2 << 16 | b3 << 8 | b4 << 0;
		}
		
		protected function swapLong(value:Number):Number
		{
			var b1:int = (value >> 0) & 0xff;
			var b2:int = (value >> 8) & 0xff;
			var b3:int = (value >> 16) & 0xff;
			var b4:int = (value >> 24) & 0xff;
			var b5:int = (value >> 32) & 0xff;
			var b6:int = (value >> 40) & 0xff;
			var b7:int = (value >> 48) & 0xff;
			var b8:int = (value >> 56) & 0xff;
			
			return b1 << 56 | b2 << 48 | b3 << 40 | b4 << 32 |
				   b5 << 24 | b6 << 16 | b7 <<  8 | b8 << 0;
		}
		

	}
}