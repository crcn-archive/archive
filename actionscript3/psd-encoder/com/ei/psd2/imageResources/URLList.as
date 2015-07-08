package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class URLList extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var urlsx:Array;
		public var urls:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function URLList(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			var numUrls:int = reader.readInt32();
			
			this.urls = new Array();
			for(var i:int = 0; i < numUrls; i++)
			{
				reader.readUint32();
				var id:int = reader.readUint32();
				var url:String = reader.readPSDUnicodeString();
				this.urls.push(new URLEntry(id,url));
				//this.urlsx.push(url);
			}
		
		}

	}
}


class URLEntry
{
	public var id:int;
	public var url:String;
		
	public function URLEntry(id:int,url:String)
	{
		this.id = id;
		this.url = url;
	}
}