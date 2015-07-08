package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.EffectBase;
	
	public class Bevel extends EffectBase
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var angle:int;
		public var strength:int;
		public var shadowBlendModeKey:String;
		public var shadowColor:int;
		public var bevelStyle:int;
		public var shadowOpacity:int;
		public var useGlobalAngle:Boolean;
		public var inverted:Boolean;
		public var unknown1:int;
		public var unknown2:int;
		public var unknown3:int;
		public var unknown4:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Bevel(reader:BinaryPSDReader)
		{
			super(reader);
			var r:BinaryPSDReader = this.dataReader;
			
			var blendModeSignature = null;
			
			var version:int = r.readUint32();
			
			
			switch(version)
			{
				case 0:
					blur = r.readUint32();
					data = null;
				break;
				case 2:
					angle = r.readUint16();
					strength = r.readUint16();
					blur = r.readUint16();
					
					unknown1 = r.readByte();
					unknown2 = r.readByte();
					unknown3 = r.readUint16();
					unknown4 = r.readUint16();
					
					blendModeKey = this.readBlendKey(r);
					shadowBlendModeKey = this.readBlendKey(r);
					
					color = r.readPSDColor(16,true);
					shadowColor = r.readPSDColor(16,true);
					
					bevelStyle = r.readByte();
					opacity = r.readByte();
					shadowOpacity = r.readByte();
					
					enabled = r.readBoolean();
					useGlobalAngle = r.readBoolean();
					
					inverted = r.readBoolean();
					
					var someColor:int = r.readPSDColor(16,true);
					var someColor2:int = r.readPSDColor(16,true);
				break;
					
			}
			
			
			data = null;
		}

	}
}