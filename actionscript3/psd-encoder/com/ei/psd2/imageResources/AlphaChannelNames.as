package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class AlphaChannelNames extends ImageResource
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
		
		public function AlphaChannelNames(imgRes:ImageResource)
		{
			super(imgRes);
			
			var r:BinaryPSDReader = imgRes.getDataReader();
			
			while(r.bytesToEnd > 0)
			{
				var length:int = r.readByte();
				
				var name:String = r.readPSDChars(length);
				
				if(name.length > 0)
					this._names.push(name);
				
				
			
			}
			//r.close();???
			
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