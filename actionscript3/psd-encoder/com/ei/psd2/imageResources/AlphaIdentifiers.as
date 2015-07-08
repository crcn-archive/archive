package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class AlphaIdentifiers extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _ids:Array = new Array();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function AlphaIdentifiers(imgRes:ImageResource)
		{
			super(imgRes);
			
			var r:BinaryPSDReader = imgRes.getDataReader();
			
			while(r.bytesToEnd > 0)
				this._ids.push(r.readUint32());
				
			//reader.close();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get IDs():Array
		{
			return _ids;
		}

	}
}