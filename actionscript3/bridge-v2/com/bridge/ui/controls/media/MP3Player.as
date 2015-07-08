package com.bridge.ui.controls.media
{
	import com.ei.utils.Sleep;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	public class MP3Player extends EventDispatcher implements IPlayer
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		private var _soundTransform:SoundTransform;
		
		private var _progressInt:int;
		
		private var _paused:Boolean;
		
		private var _totalTimeString:String;
		private var _currentTimeString:String;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function MP3Player()
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
		public function get id3()
		{
			return _sound.id3;
		}
		
		/**
		 */
		
		public function get bufferTime():Number
		{
			return null;
		}
		
		/**
		 */
		
		public function get currentTimeString():String
		{
			return _currentTimeString;
		}
		
		/**
		 */
		
		public function get paused():Boolean
		{
			return _paused;
		}
		
		/**
		 */
		
		public function get percentDone():Number
		{
			
			if (!_sound || !_sound.length || !_soundChannel) 
				return 0;
			
			return _soundChannel.position / _sound.length * 100;
		}
		
		/**
		 */
		
		public function get percentLoaded():Number
		{
			
			return Math.round(_sound.bytesLoaded/_sound.bytesTotal*100)
		}
		
		public function get timeLeftString():String
		{
			return _totalTimeString;
		}
		
		/**
		 */
		
		public function get totalSeconds():Number
		{
			return 0;
		}
		
		public function get volume():Number
		{
			
			return _soundTransform.volume;
			
		}
		
		public function set volume(value:Number):void
		{
			
			if(!_soundTransform)
				return;
				
			_soundTransform.volume = value;
			_soundChannel.soundTransform = _soundTransform;
			
		}
		
		public function set bufferTime(value:Number):void
		{
			
		}
		
		public function get type():String
		{
			return "mp3";
		}
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function load(value:String):void
		{
			
			if(_sound)
			{
				_sound.removeEventListener(Event.COMPLETE,onSongLoad);
				_sound.removeEventListener(Event.OPEN,onSongOpen);
				_sound.removeEventListener(Event.ID3,onID3Info);
				_sound.removeEventListener(ProgressEvent.PROGRESS,onDownloadProgress);
				_sound.removeEventListener(IOErrorEvent.IO_ERROR,onIOError);
				_soundChannel.removeEventListener(Event.COMPLETE,onSongEnd);
			
				stop();
			
			}
			
			_sound = new Sound();
			
			_sound.addEventListener(Event.OPEN,onSongOpen);
			_sound.addEventListener(Event.COMPLETE,onSongLoad);
			_sound.addEventListener(Event.ID3,onID3Info);
			_sound.addEventListener(ProgressEvent.PROGRESS,onDownloadProgress);
			_sound.addEventListener(IOErrorEvent.IO_ERROR,onIOError);
			
			
			trace("MP3Player::load("+value+")");
			
			
			_sound.load(new URLRequest(value));
			_sound.play();
			
			if(_soundTransform)
			{
				//_soundChannel.soundTransform = _soundTransform;
				
			}
			else
			{
				//_soundTransform = _soundChannel.soundTransform;
			}
			
			//_soundChannel.addEventListener(Event.COMPLETE,onSongEnd);
			
			
			
		}
		
		public function pause():void
		{
			
			trace("MP3Player::pause()");
			
			if(!_soundChannel)
				return;
			
			
			_soundChannel.stop();
			
			
			
			_paused = true;
			dispatchEvent(new Event("pause"));
			
		}
		
		public function get soundChannel():SoundChannel
		{
			return _soundChannel;
		}
		
		public function play(position:Number = -1):void
		{
			
			//stop();
			
				
			if(!_paused)
				return;
				
			_paused = false;
			
			if(position == -1 && _soundChannel)
				position = _soundChannel.position;
			else
			{
				position = _sound.length
			}
			
			
			dispatchEvent(new Event("resume"));
				
			Sleep.timeout(50,onPlayProgress);
			
			trace("MP3Player::play()");
			
			if(_soundChannel && position < _sound.length)
			{
				trace("MP3Player::PASS");
			
				_soundChannel = _sound.play(position);
				_soundChannel.soundTransform = _soundTransform;
			}
			else
			{
				trace("MP3Player::PLAY NO SL");
				_soundChannel = _sound.play();
			}
			
			
		}
		
		public function stop():void
		{
			pause();
			
		}
		
		public function togglePlay():void
		{
			trace("MP3Player::togglePlay()");
			
			if(_paused)
				play()
			else
				pause();	
		}
		
		public function seek(percent:Number):void
		{
			stop();
			play(percent);
		}
		
		
		/**
		 */
		 
		public function addCuePoint(callback:Function,time:String,reausable:Boolean,...params:Array):void
		{
			
		}
		
		/**
		 */
		
		public function clearCuePoints():void
		{
			
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
			trace("MP3Player::onIOError"+event.text);
		}
		
		/**
		 */
		private function onSongOpen(event:Event):void
		{
			trace("MP3Player::onSongOpen");
		}
		
		/**
		 */
		
		private function onPlayProgress():void
		{
			if(!_paused)
				Sleep.timeout(50,onPlayProgress);
				
			
			_currentTimeString = getTime(percentDone);
			
			
			
			dispatchEvent(new Event("playing"));
		}
		
		/**
		 */
		
		private function onDownloadProgress(event:ProgressEvent):void
		{
			
			trace("MP3Player::progress"+event.bytesLoaded+" "+event.bytesLoaded);
			dispatchEvent(event);
			
		}
		
		/**
		 */
		
		private function onSongEnd(event:Event):void
		{
			trace("MP3Player::onSongEnd");
			event.target.removeEventListener(event.type,onSongEnd);
			
			stop();
			
			dispatchEvent(new Event("end"));
		}
		
		/**
		 */
		
		private function onSongLoad(event:Event):void
		{
			trace("MP3Player::onSongLoad()");
			_sound.play();
			event.target.removeEventListener(event.type,onSongLoad);
			event.target.removeEventListener(ProgressEvent.PROGRESS,onDownloadProgress);
			
			
			_totalTimeString = getTime(_sound.length);
		}
		
		/**
		 */
		
		private function onID3Info(event:Event):void
		{
			event.target.removeEventListener(event.type,onID3Info);
		}
		
		/**
		 */
		
		private function getTime(rawTime:Number):String
		{
			var newTime:Number = rawTime / 60;
			var minutes:Number = Math.floor(newTime);
			var seconds:Number = Math.floor(Math.abs(minutes - newTime) * 60);
			
			
			var nseconds:String = String(seconds);
			
			if(seconds < 10)
			{
				nseconds = 0+nseconds;
			}
			
			return minutes+":"+nseconds;
		}
	}
}
	import flash.net.Socket;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.errors.IOError;
	

	class ShoutcastTuner
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _portRegexp:RegExp = /(?<=:)\d+/i;
		private var _hostRegexp:RegExp = /.*?(?=:\d+)/i;
		private var _socket:Socket;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ShoutcastTuner()
		{
			_socket = new Socket();
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
		
        /**
		 */
		
		public function load(value:String):void
		{
			var spl:Array = value.split(":");
			
			var port:int 	= _portRegexp.exec(value)[0];
			var host:String = _hostRegexp.exec(value)[0];
			
			trace("ShoutcastTuner::load host="+host+", port="+port);
			
			_socket.connect(host,port);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onSockActive(event:Event):void
		{
			trace("ShoutcastTuner::onSockActive");
		}
		
		/**
		 */
		 
		private function onSockClose(event:Event):void
		{
			trace("ShoutcastTuner::onSockClose");	
		}
		
		/**
		 */
		 
		public function onSockConnect(event:Event):void
		{
			trace("ShoutcastTuner::onSockConnect");
		}
		
		/**
		 */
		 
		public function onSockIOError(event:IOErrorEvent):void
		{
			trace("ShoutcastTuner::onSockIOError",event.text);
		}
		
		/**
		 */
		 
		public function onSockData(event:Event):void
		{
			trace("ShoutcastTuner::onSockData");
		}
		
		/**
		 */
		 
		public function onSockSecurityError(event:SecurityErrorEvent):void
		{
			trace("ShoutcastTuner::onSockSecurityError()");
		}
		
		
	}