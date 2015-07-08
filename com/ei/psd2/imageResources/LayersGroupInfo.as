package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class LayersGroupInfo extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var groupIds:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		
		public function LayersGroupInfo(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			groupIds = new Array();
			
			while(reader.bytesToEnd > 0)
			{
				groupIds.push(reader.readUint16());
			}
			
			//reader.close();
		}

	}
}