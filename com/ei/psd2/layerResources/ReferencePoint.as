package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	import flash.geom.Point;
	
	public class ReferencePoint extends LayerResource
	{
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var point:Point;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ReferencePoint(data:Object)
		{
			if(data is Point)
				point = data as Point;
			
			
			
			
			//trace(data);
			if(data is BinaryPSDReader)
			{
				super(data as BinaryPSDReader);
				
				var r:BinaryPSDReader = this.dataReader;
				
				
				point = new Point();
				point.x = r.readPSDDouble();
				point.y = r.readPSDDouble();
				
				this.data = null;
			}
		}

	}
}