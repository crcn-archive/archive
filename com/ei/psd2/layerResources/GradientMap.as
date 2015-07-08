package com.ei.psd2.layerResources
{
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.BinaryPSDReader;
	
	public class GradientMap extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var reverse:Boolean;
		public var dither:Boolean;
		public var name:String;
		public var colorStops:Array;
		public var transparencyStops:Array;
		public var interpolation:int;
		public var mode:int;
		public var randomSeed:int;
		public var showTransparency:Boolean;
		public var useVectorColor:Boolean;
		public var roughness:int;
		public var colorModel:int;
		public var minChannelValues:Array;
		public var MaxChannelValues:Array;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function GradientMap(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			var version:int = r.readUint16();
			reverse = r.readBoolean();
			dither = r.readBoolean();
			name = r.readPSDUnicodeString();
			r.jumpToEvenNthByte(2);
			
			var cnt:int = r.readUint16();
			
			colorStops = new Array();
			
			for(var i:int = 0; i < cnt; i++)
			{
				colorStops.push(new ColorStop(r));
			}
			
			cnt = r.readUint16();
			
			transparencyStops = new Array();
			
			for(var i:int = 0; i < cnt; i++)
			{
				transparencyStops.push(new TransparencyStop(r));
			}
			
			var expansionCount = r.readUint16();
			
			if(expansionCount > 0)
				interpolation = r.readInt16();
				
			var length:int = r.readUint16();
			this.mode = r.readUint16();
			
			this.randomSeed = r.readUint32();
			
			r.baseStream.position += 1;
			showTransparency = r.readBoolean();
			
			r.baseStream.position += 1;
			this.useVectorColor = r.readBoolean();
			
			this.roughness = r.readUint32();
			
			this.colorModel = r.readUint16();
			
			this.minChannelValues = r.readPSDChannelValues(4);
			this.MaxChannelValues = r.readPSDChannelValues(4);
			
			this.data = r.readBytes(r.bytesToEnd);
		}

	}
}
	import com.ei.psd2.ColorModes;
	import com.ei.psd2.BinaryPSDReader;
	

class ColorStop
{
	public var location:int;
	public var midPoint:int;
	public var colorMode:int;
	public var channels:Array;
	public var unknown:int;
	
	public function ColorStop(r:BinaryPSDReader)
	{
		location = r.readUint32();
		midPoint = r.readUint32();
		colorMode = r.readUint16();
		channels = r.readPSDChannelValues(4);
		unknown = r.readUint16();
	}
	
}

class TransparencyStop
{
	public var location:int;
	public var midPoint:int;
	public var opacity:int;
	
	
	public function TransparencyStop(r:BinaryPSDReader)
	{
		location = r.readUint32();
		midPoint = r.readUint32();
		opacity  = r.readUint16();
	}
	
	
}