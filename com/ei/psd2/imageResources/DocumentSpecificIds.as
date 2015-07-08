package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class DocumentSpecificIds extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var startIndex:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function DocumentSpecificIds(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			startIndex = reader.readUint32();
			//reader.close();
		}

	}
}