package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ColorModes;
	import com.ei.psd2.ImageResource;
	
	public class DisplayInfo extends ImageResource
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var colorSpace:int = ColorModes.RGB;
		public var color:Array = [-1,0,0,0];
		public var opacity:int = 100;
		public var kind:Boolean = false;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function DisplayInfo(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			
			colorSpace = reader.readInt16();
			
			for(var i:int = 0; i < 4; i++)
			{
				color[i] = reader.readInt16();
			}
			
			opacity = Math.max(0,Math.min(100,reader.readInt16()));
			
			kind = reader.readByte() == 0? false : true;
			
		}

	}
}