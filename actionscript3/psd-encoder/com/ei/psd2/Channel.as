package com.ei.psd2
{
	import flash.utils.ByteArray;
	
	public class Channel
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _usage:int;
        private var _layer:Layer;
        private var _data:ByteArray;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function Channel(reader:BinaryPSDReader,layer:Layer)
		{
			
			_layer = layer;
			
			if(reader == null)
				return;
				
			_usage = reader.readInt16();
			
			var length:int = reader.readUint32();//filler
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function get usage():int
		{
			return _usage;
		}
		
		/**
		 */
		 
		public function get data():ByteArray
		{
			return _data;
		}
		
		public function set data(value:ByteArray):void
		{
			_data = value;
		}

	}
}