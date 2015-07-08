package com.ei.psd2.layerResources
{
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.BinaryPSDReader;
	
	public class Curves extends LayerResource
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
		
		public function Curves(reader:BinaryPSDReader)
		{
			super(reader);
			var r:BinaryPSDReader = this.extractTag();
			
			var unknown = r.readByte();
			
			var version:int = r.readUint16();
			var definedCurves = r.readUint32();
			
			this.records = new Array();
			var channelNum = -1;
			
			while(definedCurves > 0)
			{
				if((definedCurves & 1) > 0)
				{
					var curve:Curve = new Curve(r);
					curve.channel = channelNum
					records.push(curve);
				}
				
				channelNum++;
				definedCurves >>= 1;
			}
			
			if(r.bytesToEnd > 0)
			{
				var head:String = r.readPSDChars(4);
				version = r.readUint16();
				
				var numCurves:int = r.readUint32();
				
				for(var i:int = 0; i < numCurves; i++)
				{
					var channelId:int = r.readUint16();
					var curve:Curve = new Curve(r);
					curve.channel = channelId - 1;
				}
			}
			
			this.data = null;
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class Curve
{
	public var channel:int;
	public var points:Array;
	
	public function Curve(r:BinaryPSDReader)
	{
		var numPoints:int = r.readUint16();
		
		points = new Array();
		for(var i:int = 0; i < numPoints; i++)
		{
			points.push(new CurvePoint(r));
		}
		
		
	}
}

class CurvePoint
{
	public var output:int;
	public var input:int;
	
	
	public function CurvePoint(r:BinaryPSDReader)
	{
		output = r.readUint16();
		input  = r.readUint16();
	}
}