package com.ei.psd2
{
	import flash.utils.Dictionary;
	

	public class GlobalImage
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _document:PSD;
        private var _fakeLayer:Layer;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function GlobalImage(document:PSD)
		{
			_document = document
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function load(reader:BinaryPSDReader):void
		{
			createLayer();
			//_fakeLayer.readPixels(reader);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function createLayer():void
		{
			_fakeLayer = new Layer(null,_document);
			_fakeLayer.isMerged = true;
			_fakeLayer.width = _document.size.x;
			_fakeLayer.height = _document.size.y;
			//_fakeLayer.channels = new Array();
		/*	for(var i:int = 0; i < _document.channels; i++)
			{
				_fakeLayer.channels[i] = new Channel(null,_fakeLayer);
			}*/
		}

	}
}