package com.bridge.ui.controls.media
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class AudioSpectrum extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _byteArray:ByteArray;
		private var _interval:int;
		private var _bars:int;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var spectrumData:Array;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function AudioSpectrum()
		{
			super();
			
			_byteArray =  new ByteArray();
			spectrumData = new Array();
			_bars = 8;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function set bars(value:int):void
		{
			_bars = value;
		}
		
		public function get bars():int
		{
			return _bars;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function start():void
		{
			_interval = setInterval(onSpectrumData,30);
		}
		
		/**
		 */
		 
		public function stop():void
		{
			clearInterval(_interval);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onSpectrumData():void
		{
			var a:Number;
			var data = new Array();
			SoundMixer.computeSpectrum(_byteArray,true,0);
			
			var interval:int = 256/bars;
			
			
			for(var i = 0; i < 256; i+=interval)
			{
				data.push(_byteArray.readFloat());
			
			}
			
			spectrumData = data;
			
			dispatchEvent(new Event("spectrumData"));
		}
		

	}
}