package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	public class BlendElements extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var value:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BlendElements(data:Object)
		{
			if(data is Boolean)
				value = data;
				
			
			
			if(data is BinaryPSDReader)
			{
				super(data as BinaryPSDReader);
				var r:BinaryPSDReader = this.dataReader;
				
				value = r.readBoolean();
				this.data = null;
			}	
		}
		
		
		
	}
}