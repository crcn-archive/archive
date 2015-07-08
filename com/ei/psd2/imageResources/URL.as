package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class URL extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var value:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function URL(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			value = new String(reader.readChars(reader.bytesToEnd));
			
			//reader.close();
		}

	}
}