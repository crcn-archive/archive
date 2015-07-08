package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class PrintFlagsInfo extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var centerCrop:int;
		public var bleedWidthValue:int;
		public var bleedWidthScale:uint;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function PrintFlagsInfo(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			var version:uint = reader.readUint16();
			centerCrop = reader.readByte();
			reader.readByte();
			this.bleedWidthValue = reader.readUint32();
			this.bleedWidthScale = reader.readUint16();
			
			
		}

	}
}