package com.bridge.ui.controls.media.audio
{
	import com.ei.utils.Sleep;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class AudioTuner extends AudioPlayer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _tempSound:Sound;
		private var _nsSoundChannel:SoundChannel;
		
		private var _interval:int;
		
		public var CLEAR_BUFFER_DELAY:Number = 600000;//ten minutes

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function AudioTuner()
		{
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get type():String
		{
			return "tuner";
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function load(value:String):void
		{
			super.load(value);
			
			this.play();
			
		}
		
		/**
		 */
		
		override public function pause():void
		{
			super.pause();
			
			this.dumpMem();
			
		}
		
		
		/**
		 */
		
		override public function play(position:Number = -1):void
		{
			super.play(position);
			
			Sleep.timeout(this.CLEAR_BUFFER_DELAY,dumpMem);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function dumpMem():void
		{
			
			_tempSound = new Sound();
			_tempSound.addEventListener(Event.OPEN,onComplete);
			_tempSound.addEventListener(Event.COMPLETE,onComplete);
			_tempSound.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			_tempSound.load(new URLRequest(this.source+Math.random()));
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		private function onIOError(event:IOErrorEvent):void
		{
			trace("AudioTuner::IO ERROR"+event.text);
		}
        /**
		 */
		
		private function onComplete(event:Event):void
		{
			trace("AudioTUner::onComplete()");
			
			event.target.removeEventListener(event.type,onComplete);
			
			onEnd();
			
			
			
		}
		
		/**
		 */
		private function updateFunction(current:Number):void
		{
			
			_soundChannel.soundTransform = new SoundTransform(current);
			
		}
		
		/**
		 */
		private function onEnd():void
		{
			trace("AudioTuner.onEnd()");
			
			
			_soundChannel.stop();
			_sound.close();
			
			
			_sound = _tempSound;
			
			
			if(!this.paused)
			{
				//FIXME : bad fix 
				_paused = true;
				this.play();
			}
			
			
		}
		
		
		
		
	}
}