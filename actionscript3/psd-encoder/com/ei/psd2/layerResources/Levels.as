package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	
	
	public class Levels extends LayerResource
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var records:Array;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Levels(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			var version:int = r.readUint16();
			this.records = new Array();
			var endPos:int = Math.min(r.bytesToEnd,292);
			
			while(r.baseStream.position < endPos)
			{
				records.push(new LevelRecord(r));
			}
			
			if(r.bytesToEnd > 0)
			{
				var head:String = r.readPSDChars(4);
				var unknown1:int = r.readUint16();
				var unknown2:int = r.readUint16();
				
				while(r.bytesToEnd > 0)
					this.records.push(new LevelRecord(r));
					
			}
			
			data = null;
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class LevelRecord
{
	public var inputFloor:int;
	public var inputCeiling:int;
	public var outputFloor:int;
	public var outputCeiling:int;
	public var gamma:int;
	
	public function LevelRecord(r:BinaryPSDReader):void
	{
		inputFloor = r.readUint16();
		inputCeiling = r.readUint16();
		outputFloor = r.readUint16();
		outputCeiling = r.readUint16();
		gamma = r.readUint16();
	}
}