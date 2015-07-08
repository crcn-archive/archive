package com.ei.psd2
{
	import flash.utils.ByteArray;
	
	public class Header
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
        
        public var version:uint;
        public var channels:uint;
        public var rows:uint;
        public var columns:uint;
        public var bitsPerPixel:uint;
        public var colorMode:uint;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function Header(reader:BinaryPSDReader = null)
		{
			version 	 = 1;
			channels 	 = 4;
			bitsPerPixel = 8;
			colorMode 	 = ColorModes.RGB;
			
			
			
			if(reader == null)
				return;
			
			version = reader.readUint16();
			
			if(version != 1)
				throw new Error("cannot read .psd version "+ version);
			
			
			
			var buf:ByteArray = new ByteArray();
			buf.length = 256;
			
			reader.read(buf,reader.position,6);
			
			channels 	 = reader.readUint16();
			rows 	 	 = reader.readUint32();
			columns   	 = reader.readUint32();
			bitsPerPixel = reader.readUint16();
			colorMode	 = reader.readUint16();
			
			//version = reader.read
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function get numColorChannels():int
		{
			switch(colorMode)
			{
				case ColorModes.Bitmap:
				case ColorModes.Grayscale:
				case ColorModes.Indexed:
					return 1;
				break;
				case ColorModes.Duotone:
					return 2;
				break;
				case ColorModes.Lab:
				case ColorModes.RGB:
					return 3;
				break;
				case ColorModes.CMYK:
					return 4;
				break;
				case ColorModes.Multichannel:
					return 5;
				break;
			}
			
			return 0;
		}
		
		
		/**
		 */
		
		

	}
}