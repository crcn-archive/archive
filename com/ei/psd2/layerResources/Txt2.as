package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.DynVal;
	import com.ei.psd2.LayerResource;
	
	public class Txt2 extends LayerResource
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public const settings:String = "EXTREMELY bloated data - 280 kB or more - to inspect, change to 'readData = true' in Txt2 class";
		public var values:DynVal;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Txt2(reader:BinaryPSDReader)
		{
			super(reader);
			
			var readData:Boolean = false; //Set to true to see it in all its... glory.
			
			if(readData);
			{
				/*
				
				 BinaryPSDReader r = this.GetDataReader();
                r.BaseStream.Position += 2;
                this.Values = new DynVal();
                this.Values.Children = new List<DynVal>();
                while (true)
                {
                    DynVal child = new DynVal();
                    this.Values.Children.Add(child);
                    try
                    {
                        if (child.ReadTdtaItem(r) == false)
                            break;
                    }
                    catch (Exception ex)
                    {

                    }
                }
                
                */
			}
		}

	}
}