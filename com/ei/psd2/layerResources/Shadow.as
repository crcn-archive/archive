package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.EffectBase;
	
	public class Shadow extends EffectBase
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var intensity:int;
		public var angle:int;
		public var distance:int;
		public var useGlobalAngle:Boolean;
		public var inner:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Shadow(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			var blendModeSignature:String = null;
			
			var version:int = r.readInt32();
			
			switch(version)
			{
				case 0:
					blur = r.readUint32();
					intensity = r.readUint32();
					
					angle = r.readUint32();
					distance = r.readUint32();
					
					color = r.readPSDColor(16,true);
					
					blendModeKey = this.readBlendKey(r);
					
					enabled = r.readBoolean();
					useGlobalAngle = r.readBoolean();
					opacity = r.readByte();
				break;
				case 2:
					blur = r.readInt16();
					intensity = r.readUint32();
					
					angle = r.readUint32();
					distance = r.readUint32();
					
					var something:int = r.readUint16(); //TODO?
					
					color = r.readPSDColor(16,true);
					
					this.blendModeKey = this.readBlendKey(r);
					enabled = r.readBoolean();
					useGlobalAngle = r.readBoolean();
					opacity = r.readByte();
				break;
			}
			
			data = null;
		}

	}
}