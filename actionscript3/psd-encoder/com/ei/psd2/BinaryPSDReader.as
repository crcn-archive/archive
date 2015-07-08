package com.ei.psd2
{

	import com.endogine.serialization.BinaryReverseReader;
	
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	public class BinaryPSDReader extends BinaryReverseReader
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function BinaryPSDReader(bytes:ByteArray)
		{
			super(bytes);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function readPSDChannelValues(channels:int):Array
		{
			var ar:Array = new Array();
			
			
			for(var i:int = 0; i < channels; i++)
			{
				ar.push(readUint16());
			}
			
			return ar;
		}
		
		/**
		 */
		
		public function readPSDChars(length:int):String
		{
			try
			{
				return baseStream.readUTFBytes(length);
			}
			catch(e:*)
			{
				return null;
			}
			
			return null;
			
		}
		
		
		
		/**
		 */
		
		public function readPSDColor(bits:int,alpha:Boolean):int
		{
			if(bits == 8)
			{
				var a:int = baseStream.readByte();
				
				if(!alpha)
				{
					a = 255;
				}
				
				
				return ColorControl.fromARGB(a,baseStream.readByte(),baseStream.readByte(),baseStream.readByte());
				
			}
			else
			{
				position += 2;
				var a:int = 255;
				
				if(alpha) // CS 4 this is wrong, glow has only RGB, alpha comes after blend mode
					a = this.readUint16();
					
				var r:int = this.readUint16() >> 8;
				var g:int = this.readUint16() >> 8;
				var b:int = this.readUint16() >> 8;
				
				
				//return ColorControl.fromRGB(100,255,55);
				//trace(ColorControl.fromRGB(r,g,b),
				return ColorControl.fromARGB(a,r,g,b);
			}
		}
		
		
		
		/**
		 */
		
		public function readPSDDouble():Number
		{
			var val:Number = baseStream.readDouble(); 
			
			
			return val;
			//return swapLong(val);
		}
		
		
		
		
		/**
		 */
		
		public function readPSDRectangle():Rectangle
		{
			var rect:Rectangle = new Rectangle();
			
			rect.y	    = readInt32();
			rect.x 	    = readInt32();
			rect.height = readInt32() - rect.y;
			rect.width  = readInt32() - rect.x;
			
			
			return rect;
		}
		
		
		
		/**
		 */
		
		public function readPSDUnicodeString():String
		{
			var s:String = new String();
			var nLength:int = readUint32();
			
			for(var i:int = 0; i < nLength * 2; i++)
			{
				var c:String = readChar();
				if(i % 2 == 1 && c != String(0))
					s += c;
					
			}
			
			return s;
		}
		
		/**
		 */
		
		public function readBoolean():Boolean
		{
			return baseStream.readBoolean();
		}
		
		
		
	}
}