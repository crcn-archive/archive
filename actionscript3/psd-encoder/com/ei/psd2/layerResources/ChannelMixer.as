package com.ei.psd2.layerResources
{
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.BinaryPSDReader;
	
	public class ChannelMixer extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var monochrome:Boolean;
		public var records:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ChannelMixer(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			
			var version:int = r.readUint16();
			r.baseStream.position += 1;
			
			this.records = new Array();
			var numChannels:int = 3;
			
			if(this.monochrome)
			{
				this.records.push(new MixerRecord(r,numChannels));
			}
			else
			{
				for(var i:int = 0; i < numChannels; i++)
				{
					records.push(new MixerRecord(r,numChannels));
				}
				
				
			}
			
			if(r.bytesToEnd > 0 && !this.monochrome)
				records.push(new MixerRecord(r,numChannels));
				
			this.data = null;
		}
		
		
		 
		

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class MixerRecord
{
	public var channels:Array;
	public var constants:int;
	public var unknown:int;
	
	
	public function MixerRecord(r:BinaryPSDReader, numChannels:int)
	{
		channels = new Array();
		for(var i:int = 0; i < numChannels; i++)
		{
			channels.push(r.readInt16());
		}
		
		this.unknown = r.readInt16();
		this.constants = r.readInt16();
	}
}