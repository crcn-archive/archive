package com.bridge.ui.controls.media.audio
{
	import com.bridge.ui.controls.media.Player;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class AudioPlayer extends Player
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------



		protected var _soundChannel:SoundChannel;
		protected var _soundTransform:SoundTransform;
		
		protected var _paused:Boolean;
		protected var _source:String;
		
		protected var _currentPosition:Number;
		
		protected var _sound:Sound;
		
		public var name:String;
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function AudioPlayer()
		{
			_paused = true;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function get paused():Boolean
		{
			return _paused;
		}
		
		
		/**
		 */
		
		
		override public function get volume():Number
		{
			
			return _soundTransform.volume;
			
		}
		
		override public function set volume(value:Number):void
		{
			
			if(!_soundTransform)
				return;
				
			_soundTransform.volume = value;
			_soundChannel.soundTransform = _soundTransform;
			
		}
		
		
		public function get source():String
		{
			return _source;
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
			_source = value;
			trace("AudioPlayer::load="+value);
			
			if(_sound)
			{
				_sound.removeEventListener(Event.OPEN,onSongOpen,false);
				_sound.removeEventListener(Event.COMPLETE,onSongLoad,false);
				_sound.removeEventListener(IOErrorEvent.IO_ERROR,onIOError,false);
			
				stop();
			
			}
			
			_sound = new Sound();
			_sound.addEventListener(Event.OPEN,onSongOpen,false,0,true);
			_sound.addEventListener(Event.COMPLETE,onSongLoad,false,0,true);
			_sound.addEventListener(IOErrorEvent.IO_ERROR,onIOError,false,0,true);
			
			
			_sound.load(new URLRequest(value));
			var sound:Sound;
			
			
		}
		
		override public function play(position:Number = -1):void
		{
			if(!_paused)
				return;
				
			_paused = false;
			
			trace("AudioPlayer::resume");
			
			dispatchEvent(new Event("resume"));
			
			_soundChannel = _sound.play();
			
			
			
			if(_soundTransform)
			{
				_soundChannel.soundTransform = _soundTransform;
				
			}
			else
			{
				_soundTransform = _soundChannel.soundTransform;
			}
			
			_soundChannel.soundTransform.volume = 0;
			
			
			trace(_soundChannel.soundTransform.volume);
			
		}
		
		override public function pause():void
		{
			
			trace("AudioPlayer::pause()",this.name);
			
			
			if(!_soundChannel)
				return;
			
			_currentPosition = _soundChannel.position;
			
			
			_soundChannel.stop();
			
			
			
			_paused = true;
			dispatchEvent(new Event("pause"));
			
		}
		
		public function get soundChannel():SoundChannel
		{
			return _soundChannel;
		}
		
		
		override public function stop():void
		{
			pause();
			
		}
		
		override public function togglePlay():void
		{
			trace("AudioPlayer::togglePlay()");
			
			if(_paused)
				play()
			else
				pause();	
		}

		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		private function onIOError(event:IOErrorEvent):void
		{
			trace("AudioPlayer::onIOError"+event.text);
		}
		
		
		
		/**
		 */
		
		protected function onSongLoad(event:Event):void
		{
			trace("AudioPlayer::onSongLoad()");
			
			event.target.removeEventListener(event.type,onSongLoad);
			
			
			dispatchEvent(new Event("loaded"));
			
			
		}
		
		/**
		 */
		protected function onSongOpen(event:Event):void
		{
			event.target.removeEventListener(event.type,onSongOpen);
			
			trace("AudioPlayer::onSongOpen()");
			
			dispatchEvent(new Event("open"));
		}
		
		
	}
}