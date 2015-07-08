package com.endogine.serialization
{
	import flash.utils.ByteArray;
	
	public class BinaryReaderEx
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _stream:ByteArray;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		
		public function BinaryReaderEx(stream:ByteArray)
		{
			_stream = stream;
		}

		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		
		
		public function get baseStream():ByteArray
		{
			return _stream;
		}
		
		public function get bytesToEnd():int
		{
			return baseStream.length - baseStream.position;
		}
		
		/**
		 */
		
		public function get position():int
		{
			return baseStream.position;
		}
		
		/**
		 */
		 
		 public function set position(pos:int):void
		 {
		 	baseStream.position = pos;
		 }
		 
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function readPascalString():String
		{
			var s:String = "";
			
			var nLength:int = baseStream.readByte();
			
			for(var i:int = 0; i < nLength; i++)
				s += readChar();
				
			if(nLength % 2 == 0)
				baseStream.readByte();
			
			return s;	
			
		}
		
		/**
		 */
		
		public function readPascalStringUnpadded():String
		{
			return readPascalString();
		}
		
		
		/**
		 */
		
		public function jumpToEvenNthByte(n:int):void
		{
			var nMod:int = baseStream.position % n;
			
			if(nMod > 0)
				baseStream.position += n - nMod;
		}
		
		/**
		 */
		
		public function readChar():String
		{
			return baseStream.readUTFBytes(1);
		}
		
		/**
		 */
		
		public function readByte():int
		{
			return baseStream.readByte();
		}
		
		/**
		 */
		
		public function readBytes(length:int):ByteArray
		{
			var byteArray:ByteArray = new ByteArray();
			
			
			baseStream.readBytes(byteArray,0,length)
			
			
			
			//baseStream.position -= length;
			
			
			//byteArray.position = 0;
			
			return byteArray;
			
		}
		
		/**
		 */
		
		public function read(stream:ByteArray,pos:int,length:int):void
		{
			baseStream.readBytes(stream,pos,length);
		}
		
		/**
		 */
		
		public function readChars(length:int):String
		{
			return baseStream.readUTFBytes(length);
		}
		
		/**
		 */
		
		public function readSingle():int //FIX what's this?
		{
			return this.readByte();
		}
	}
}