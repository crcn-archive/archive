package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class PrintFlags extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var labels:Boolean;
		public var cropMarks:Boolean;
		public var colorBars:Boolean;
		public var regMarks:Boolean;
		public var negative:Boolean;
		public var flip:Boolean;
		public var interpolate:Boolean;
		public var caption:Boolean;
		public var unknown:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function PrintFlags(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			labels = reader.readBoolean();
			cropMarks = reader.readBoolean();
			colorBars = reader.readBoolean();
			regMarks = reader.readBoolean();
			negative = reader.readBoolean();
			flip = reader.readBoolean();
			interpolate = reader.readBoolean();
			caption = reader.readBoolean();
			
			if(reader.bytesToEnd > 0)
				unknown = reader.readBoolean();
				
				
		}

	}
}