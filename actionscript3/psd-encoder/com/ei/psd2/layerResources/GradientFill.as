package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.DynVal;
	import com.ei.psd2.LayerResource;
	
	public class GradientFill extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var descriptor:DynVal;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function GradientFill(reader:BinaryPSDReader)
		{
			super(reader);
			var r:BinaryPSDReader = this.dataReader;
			
			
			descriptor = new DynVal(r,true);
			
			
			data = null;
		}

	}
}