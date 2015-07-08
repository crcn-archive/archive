package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	public class LayerNameSource extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var name:String;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function LayerNameSource(reader:BinaryPSDReader)
		{
			super(reader);
			var r:BinaryPSDReader = this.dataReader;
			
			name = r.readPSDChars(r.bytesToEnd);
			
			data = null;
		}

	}
}