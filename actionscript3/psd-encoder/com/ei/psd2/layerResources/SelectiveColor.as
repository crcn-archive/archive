package com.ei.psd2.layerResources
{
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.BinaryPSDReader;
	
	public class SelectiveColor extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var absoluteMode:Boolean;
		public var records:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function SelectiveColor(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			var version:int = r.readUint16();
			r.baseStream.position += 1;
			this.absoluteMode = r.readBoolean();
			
			this.records = new Array();
			for(var i:int = 0; i < 10; i++)
			{
				records.push(new CorrectionRecord(r));
			}
			
			data = null;
			
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class CorrectionRecord
{
	public var cyan:int;
	public var magenta:int;
	public var yellow:int;
	public var black:int;
	
	
	public function CorrectionRecord(r:BinaryPSDReader):void
	{
		cyan = r.readInt16();
		magenta = r.readInt16();
		yellow = r.readInt16();
		black = r.readInt16();
	}
}