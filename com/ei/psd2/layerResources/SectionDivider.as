package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	public class SectionDivider extends LayerResource
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var type:int;
		public var blendKey:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
			
		public function SectionDivider(reader:BinaryPSDReader)
		{
			super(reader);
			var r:BinaryPSDReader = this.dataReader;
			
			this.type = r.readUint32();
			if(r.bytesToEnd > 0)
			{
				var header:String = r.readPSDChars(4);
				blendKey = r.readPSDChars(4);
				
				if(this.blendKey != "pass")
				{
					//do nothing??
				}
				
				
			}
			
			data = null;
		}

	}
}