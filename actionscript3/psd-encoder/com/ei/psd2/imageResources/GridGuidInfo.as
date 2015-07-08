package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class GridGuidInfo extends ImageResource
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var gridCycle:int = 576;
		public var guides:Array = new Array();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function GridGuidInfo(imgRes:ImageResource)
		{
			super(imgRes);
			
			
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			var version:int = reader.readUint32();
			
			this.gridCycle = reader.readUint64();
			
			var guideCount:int = reader.readUint32();
			
			for(var i:int = 0; i < guideCount; i++)
			{
				var guide:GridGuide = new GridGuide(reader);
				this.guides.push(guide);
			}
			
			//reader.close;
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class GridGuide
{
	public var location:int;
	public var isHorizontal:Boolean;
	
	public function set locationInPixels(value:Number):void
	{
		this.location = value * 32;
	}
	
	public function get locationInPixels():Number
	{
		return this.location / 32;
	}
	
	
	//public function GridGuide
	
	public function GridgeGuide(reader:BinaryPSDReader)
	{
		location = reader.readUint32();
		isHorizontal = reader.readBoolean();
	}
}