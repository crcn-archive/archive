package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ColorControl;
	import com.ei.psd2.LayerResource;
	
	public class SheetColor extends LayerResource
	{
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var color:int;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function SheetColor(data:Object)
		{
			if(data is int)
				color = data as int;
				
			if(data is BinaryPSDReader)
			{
				super(data as BinaryPSDReader);
				var r:BinaryPSDReader = this.dataReader;
				
				var alpha:Number = r.readByte();
				
				color = ColorControl.fromARGB(alpha,r.readByte(),r.readByte(),r.readByte());
				this.data = null;
			}
		}

	}
}