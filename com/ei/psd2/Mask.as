package com.ei.psd2
{
	import flash.geom.Rectangle;
	
	public class Mask extends Channel
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _flags:int;
        private var _flags2:int;
        private var _maskBg:int;
        private var _layer:Layer;
        private var _rectangle:Rectangle;
        private var _otherRectangle:Rectangle;
        private var _color:int;
        
       
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function Mask(reader:BinaryPSDReader,layer:Layer)
		{
			super(null,layer);
			
			_flags = 0;
			_flags2 = 0;
			
			_layer = layer;
			
			var nLength:int = reader.readUint32();
			
			
			if(nLength == 0)
				return;
				
			var nStart:int = reader.position;
			
			_rectangle = reader.readPSDRectangle();
			
			
			_color = reader.readByte();
			
			_flags = reader.readByte();
			
			if(nLength == 20)
				reader.readUint16();
			else
			if(nLength == 36)
			{
				_flags2 = reader.readByte();
				_maskBg = reader.readByte();
				_otherRectangle = reader.readPSDRectangle();
			}
			
			
			reader.position = nStart + nLength;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
        public function get rectangle():Rectangle
        {
        	return _rectangle;
        }
        
	}
}