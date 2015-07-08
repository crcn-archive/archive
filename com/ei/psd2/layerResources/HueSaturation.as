package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	public class HueSaturation extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var colorizeMode:Boolean;
		public var colorize:HSLModifier;
		public var settings:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function HueSaturation(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			var version:int = r.readUint16();
			colorizeMode = r.readBoolean();
			r.baseStream.position += 1;
			
			this.settings = new Array();
			
			if(version == 1)
			{
				this.colorize = new HSLModifier(r);
				this.colorize.hue = r.readInt16() * 180 / 100;
				this.colorize.saturation = r.readUint16();
				this.colorize.lightness = r.readUint16();
				
				
				for(var i:int = 0; i < 7; i++)
				{
					var hsl:HSLModifier = new HSLModifier(r);
					this.settings.push(hsl);
					hsl.hue = r.readInt16();
					
				}
				
				for(var i:int = 0; i < 7; i++)
				{
					this.settings[i].saturation = r.readUint16();
				}
				
				for(var i:int = 0; i < 7; i++)
				{
					this.settings[i].lightness = r.readUint16();
				}
			}
			else
			if( version == 2)
			{
				this.colorize = new HSLModifier(r);
				
				var hsl:HSLModifier = new HSLModifier(r);
				
				this.settings.push(hsl);
				
				for(var i:int = 0; i < 6; i++)
				{
					var ranges:Array = new Array();
					
					for(var j:int = 0; j < 4; j++)
					{
						ranges.push(r.readUint16());
						
					}
					
					hsl = new HSLModifier(r);
					this.settings.push(hsl);
					
					hsl.ranges = ranges;
				}
			}
			
			data = null;
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class HSLModifier
{
	public var hue:int;
	public var saturation:int;
	public var lightness:int;
	public var ranges:Array;
	
	public function HSLModifier(r:BinaryPSDReader)
	{
		hue = r.readUint16();
		saturation = r.readUint16();
		lightness = r.readUint16();
	}
		
}