package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.EffectBase;
	
	public class CommonState extends EffectBase
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function CommonState(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			var version:int = r.readUint32();
			var visible:Boolean = r.readBoolean();
			var unused:Boolean = r.readUint16();
			
			data = null;
		}

	}
}