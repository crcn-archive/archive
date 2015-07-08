package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class ColorTransferFunctions extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var functions:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ColorTransferFunctions(imgRes:ImageResource)
		{
			super(imgRes);
			
			trace("COLOR TRANSFER FUNCTIONS");
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			this.functions = new Array();
			
			for(var i:int = 0; i < 4; i++)
			{
				this.functions.push(new ColorTransferFunction(reader));
			}
			
			//reader.close();
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class ColorTransferFunction
{
	public var curve:Array;
	public var Override:Boolean;
	
	public function ColorTransferFunction(reader:BinaryPSDReader)
	{
		curve = new Array();
		
		for(var i:int = 0; i < 13; i++)
		{
			curve.push(reader.readInt16());
			
		}
		
		if(this.curve[0] == -1 || this.curve[12] == -1)
		{
			throw new Error("Error");
		}
		
		this.Override = reader.readUint16() > 0 ? true : false;
	}
}