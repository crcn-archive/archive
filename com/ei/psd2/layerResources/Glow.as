package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.EffectBase;
	import com.ei.psd2.display.PSDDisplayObject;
	import com.ei.psd2.effectResources.OuterGlowEffect;
	
	import flash.filters.GlowFilter;
	
	public class Glow extends EffectBase
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var intensity:int;
		public var useGlobalAngle:Boolean;
		public var inner:Boolean;
		public var unknown:int;
		public var unknownColor:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Glow(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			var blendModeSignature:String = null;
			
			var version:int = r.readUint32();
			
			switch(version)
			{
				case 0:
					blur = r.readUint32();
					data = null;
				break;
				case 2:
					blur = r.readUint16();
					
					intensity = r.readUint32()
					
					trace(blur,intensity);
					
					var something = r.readUint16();
				
					trace(r.baseStream.length);
					
					
					trace(r.position);
					color = r.readPSDColor(16,false);
					r.position += 2;//space
					trace(color,r.position);
					
					blendModeKey = this.readBlendKey(r);
					
					enabled = r.readBoolean();
					
					opacity = Math.abs(r.readByte())/256; // 0 - 1 is alpha
					
					
					//TODO!
					if(this.inner)
						this.unknown = r.readByte();
						
					this.unknownColor = r.readPSDColor(16,true);
					
					
					
					
					data = r.readBytes(r.bytesToEnd);
					
				break;
			}
			
			//trace(intensity,useGlobalAngle,inner,unknownColor,blur,color);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		override public function draw(displayObject:PSDDisplayObject):void
		{
			if(displayObject.filters == null)
				displayObject.filters = new Array();
				
				
			var effect:OuterGlowEffect = displayObject.getLayerEffect(OuterGlowEffect)as OuterGlowEffect;
			
			if(effect && this.tag == "oglw")
			{
				
				displayObject.filters = displayObject.filters.concat([new GlowFilter(effect.color,effect.alpha,effect.blur,effect.blur,effect.chokeMatte)]);
			}
		}

	}
}