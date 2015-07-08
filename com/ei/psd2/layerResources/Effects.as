package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.EffectBase;
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.display.PSDDisplayObject;
	
	public class Effects extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _resources:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Effects(reader:BinaryPSDReader)
		{
			super(reader);
			
			_resources = new Object();
			
			var r:BinaryPSDReader = this.dataReader;
			
			
			r.baseStream.position += 2;
			
			var nNumEffects:int = r.readUint16();
			
			for (var nEffectNum:int = 0; nEffectNum < nNumEffects; nEffectNum++)
            {
            	
            	var res:LayerResource = LayerResource.readLayerResource(r,EffectBase);
            	
            	
            	
                //EffectBase res = (EffectBase)LayerResource.ReadLayerResource(r, typeof(EffectBase));
                //if (res.Tag != "cmnS")
                //  continue;
                
                _resources[res.tag] = res;
                //this._resources.Add(res.Tag, res);
                //    case "sofi": //unknown
            }
            
            data = null;
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
			
			for each(var resource:LayerResource in _resources)
			{
				resource.draw(displayObject);
			}
		}

	}
}