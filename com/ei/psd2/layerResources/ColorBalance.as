package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	public class ColorBalance extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var records:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ColorBalance(reader:BinaryPSDReader)
		{
			
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			records = new Array();
			
			for(var i:int = 0; i < 3; i++)
			{
				records.push(new RangeSettings(r));
			}
			
			data = null;
		}
		
		

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class RangeSettings
{
	public var values:Array;
	
	public function RangeSettings(r:BinaryPSDReader):void
	{
		values = new Array();
		
		for(var i:int = 0; i < 3; i++)
		{
			values.push(r.readInt16());
		}
	}
}