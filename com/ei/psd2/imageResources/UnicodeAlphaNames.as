package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class UnicodeAlphaNames extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _names:Array = new Array();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function UnicodeAlphaNames(imgRes:ImageResource)
		{
			super(imgRes);
			
			var r:BinaryPSDReader =  imgRes.getDataReader();
			
			while(r.bytesToEnd > 0)
			{
				var name:String = r.readPSDUnicodeString();
				
				if(name.length > 0)
					this._names.push(name);
			}
			
			//r.close();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get names():Array
		{
			return _names;
		}

	}
}