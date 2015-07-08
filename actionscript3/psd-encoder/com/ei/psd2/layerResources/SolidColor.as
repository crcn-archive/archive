package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.DynVal;
	import com.ei.psd2.LayerResource;
	
	public class SolidColor extends LayerResource
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
		
		public function SolidColor(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			
			
			descriptor = new DynVal(r,true);
			
			
			
			traceRoute(descriptor);
			
			
			
			function traceRoute(desc:DynVal,tab:String="",index:int = 0):void
			{
				trace(tab,index,desc.value,desc.name,desc.objectType,desc.unicodeName);
				
				index++;
				
				for each(var child:DynVal in desc.children)
				{
					//if(child.value != null || child.value != undefined)
						//trace(index+":"+tab+child.value);
						
					if(child.children)
						traceRoute(child,tab+"\t",index);
				}
			}

			
			
			
			data = null;
		}

	}
}