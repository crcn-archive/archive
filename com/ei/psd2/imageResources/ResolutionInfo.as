package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class ResolutionInfo extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var hRes:int = 72;
		public var hResUnit:int = 1;
		public var widthUnit:int = 2;

		public var vRes:int = 72;
		public var vResUnit:int = 1;
		public var heightUnit:int = 2;

        

		public function ResolutionInfo(imgRes:ImageResource )
		{
			super(imgRes);
			//m_bResolutionInfoFilled = true;
			var reader:BinaryPSDReader = imgRes.getDataReader();

			this.hRes = reader.readInt16();
			this.hResUnit = reader.readInt32();
			this.widthUnit = reader.readInt16();

			this.vRes = reader.readInt16();
			this.vResUnit = reader.readInt32();
			this.heightUnit = reader.readInt16();

		}

	}
}