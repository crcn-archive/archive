package com.bbuilder.net
{
	import com.ei.events.AmfEvent;
	import com.ei.net.AMFPHP;
	import com.ei.psd2.Layer;

	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.graphics.codec.PNGEncoder;
	import mx.utils.Base64Encoder;
	
	public class SaveBitmapBytecode
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

        private var _layers:Array;
        private var _script:String;
        private var _pngLoaders:Dictionary;
        private var _amfPHP:AMFPHP;
        private var _connected:Boolean;
        private var _tried:Boolean;

        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function SaveBitmapBytecode(gateway:String)
		{
			
			
			//que's are stored here so save can be called many times without overwritting current uploades
			_pngLoaders = new Dictionary();
			
			_amfPHP = new AMFPHP(gateway);
			_amfPHP.addEventListener(AmfEvent.CONNECT,onAMFConnect);
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function save(layers:Array):void
		{
			var dispObj:DisplayObject;
			
			for each(var layer:Layer in layers)
			{
				dispObj = layer.displayObject;
				
				if(dispObj is Bitmap)
				{

					var fileName:String = layer.name+".png";
					
					var enc:PNGEncoder = new PNGEncoder();
				
					var data:ByteArray = enc.encode(Bitmap(dispObj).bitmapData);
					var b64:Base64Encoder = new Base64Encoder();
					data.compress();
					b64.encodeBytes(data,0,data.length);
					_amfPHP.SaveBytecode.save(b64.drain(),fileName);
					_amfPHP.SaveBytecode.addEventListener(AmfEvent.RESULT,onAMFResult);
				}
			}
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         */
		
		/*private function onAMFResult(event:AmfEvent):void
		{
			
			event.target.removeEventListener(event.type,onAMFResult);
			
		}*/
		
		
		/**
		 */
		
		/*private function onAMFConnect(event:AmfEvent):void
		{
			
			event.target.removeEventListener(event.type,onAMFConnect);

			
		}
		*/
		
	}
}

