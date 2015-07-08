package com.ei.psd2
{
	public class EffectBase extends LayerResource
	{
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var blur:int;
		public var color:int;
		public var enabled:Boolean;
		public var blendModeKey:String;
		public var opacity:int;
		
		
		public function EffectBase(reader:BinaryPSDReader)
		{
			super(reader);
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function readBlendKey(r:BinaryPSDReader):String
		{
			var blendModeSignature:String = r.readPSDChars(4); //8BIM
			
			return r.readPSDChars(4);
		}

	}
}