package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class IPTC_NAA extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var entries:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function IPTC_NAA(imgRes:ImageResource)
		{
			super(imgRes);
			var reader:BinaryPSDReader = imgRes.getDataReader();
			reader.readByte();
			reader.readUint16();
			reader.readUint16();
			reader.readUint16();
			
			entries = new Array();
			
			while(reader.bytesToEnd > 0)
			{
				var start:int = reader.readByte();
				
				if(start != 0x1c)
					throw new Error("IPTC error");
					
				var entry:IPTCEntry = new IPTCEntry();
				entry.id = reader.readUint16();
				reader.readByte();
				entry.name = reader.readPascalStringUnpadded();
				this.entries.push(entry);
			}
			
			//reader.close
		}

	}
}

class IPTCEntry
{
	public var id:int;
	
	public var name:String;
}