package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	
	//Description lyid
	public class LayerId extends LayerResource
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
		
		public static const DESCRIPTION:String = "lyid";
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var id:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function LayerId(data:Object)
		{
			if(data is int)
				id = data as int;
			
			if(data is BinaryPSDReader)
			{
				super(data as BinaryPSDReader);
				var r:BinaryPSDReader = this.dataReader;
				this.id = r.readUint32();
				
				this.data = null;
			}
				
		}

	}
}