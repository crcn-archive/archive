package com.bridge.ui.controls.media.audio
{
	import com.bridge.ui.controls.media.PlayerUtils;
	import com.ei.utils.Sleep;
	
	import flash.events.Event;
	import flash.events.ProgressEvent;
	
	public class MP3Player extends AudioPlayer
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _progressInt:int;
		
		
		private var _totalTimeString:String;
		private var _currentTimeString:String;
		
		
		
		private var _totalSeconds:int;
		
		/**
		 * used from average download speed if time isn't set
		 */
		 
		private var _totalTimeNoSet:Number;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function MP3Player()
		{
			super();
			
			_totalTimeNoSet = 0;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		
		override public function get percentLoaded():Number
		{
			
			return Math.round(_sound.bytesLoaded/_sound.bytesTotal*100)
		}
		
		
		
		/**
		 */
		
		override public function get totalSeconds():Number
		{
			//grab the total seconds set by any external data (XML)
			//flash doesn't natively know how long an audio file is
			var ts:int = _totalSeconds;
			
			//if the totalSeconds is 0 then set the current position of the sound
			if(ts == 0)
			{
				ts = _totalTimeNoSet;
				
				/*if(_totalTimeNoSet > 0)
				{
				}
				else
				{
					//the sound length has microseconds as well
					ts = _sound.length / 1000; 
				}*/
			}
			
			return ts;
		}
		/**
		 */
		
		override public function get timeLeftString():String
		{
			return _totalTimeString;
		}
		
		public function get totalTime():String
		{
			trace(totalSeconds,PlayerUtils.getTime(totalSeconds));
			return PlayerUtils.getTime(totalSeconds);
		}
		
		/**
		 */
		
		public function set totalTime(value:String):void
		{
			var ts:uint = 0;
			
			//split the times
			var splitTime:Array = value.split(":");
			
			
			//factored by colon hours:minutes:seconds 1:45:30;
			var timeIndex:Array = [1,60,3600,62400];
			
			//calculate the number of seconds in the time
			for(var i:int = splitTime.length-1; i >= 0;  i--)
			{
				
				ts += Number(splitTime[i]) * timeIndex[i];
			}
			
			trace("STMP3",ts,value);
			
			_totalSeconds = ts;
			
			trace(_totalSeconds);
			
			
		}
		/**
		 */
		
		public function get id3()
		{
			return _sound.id3;
		}

		/**
		 */
		
		override public function get currentTimeString():String
		{
			
			var pos:Number = 0;
			
			if(_soundChannel)
				pos = _soundChannel.position/1000;
				
			return PlayerUtils.getTime(pos);
		}
		
		
		/**
		 */
		
		override public function get percentDone():Number
		{
			
			if (!_sound || !_sound.length || !_soundChannel) 
				return 0;
			
			
			return _soundChannel.position / totalSeconds / 10;
		}
		
		/**
		 */
		override public function get type():String
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
		
		override public function load(value:String):void
		{
			
			
			super.load(value);
			
			
			if(_sound)
			{
				_sound.removeEventListener(Event.ID3,onID3Info);
				_sound.removeEventListener(ProgressEvent.PROGRESS,onDownloadProgress);
			}
			
			
			_sound.addEventListener(Event.ID3,onID3Info);
			_sound.addEventListener(ProgressEvent.PROGRESS,onDownloadProgress);
		}
		
		/**
		 */
		
		override public function seek(percent:Number):void
		{
			stop();
			play(percent);
		}
		
		/**
		 */
		override public function play(position:Number = -1):void
		{
			//position is percent
			
			if(!_paused)
				return;
				
			_paused = false;
			
			
			if(position == -1)
				position = this._currentPosition/_sound.length*100;
			
			
			var newPosition:Number = (_sound.length * position) / 100;
			
			
			trace(newPosition,position,_sound.length);
			
			
			Sleep.timeout(50,onPlayProgress);
			
			trace("MP3Player::play()");
			
			
			
			if(newPosition < _sound.length)
			{
				trace("MP3Player::PASS");
				
				_soundChannel = _sound.play(newPosition);
				
				
				
				
				
			}
			else
			{
				trace("MP3Player::PLAY NO SL");
				_soundChannel = _sound.play();
			}
			
			if(_soundTransform)
			{
				_soundChannel.soundTransform = _soundTransform;
				
			}
			else
			{
				_soundTransform = _soundChannel.soundTransform;
			}
			
			dispatchEvent(new Event("resume"));
			dispatchEvent(new Event("playing"));
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		
		private function onDownloadProgress(event:ProgressEvent):void
		{
			
			var loaded:int = event.bytesLoaded;
			var duration:int = _sound.length;
			var kbps:Number  = ((loaded/1000)/(duration/1000));
			trace("MP3Player::kbps="+kbps);
			var total:Number = event.bytesTotal / 1000;
			_totalTimeNoSet = (total/kbps);
			
			trace("MP3Player::totalTime="+_totalTimeNoSet);
			
			
			//trace("MP3Player::progress"+event.bytesLoaded+" "+event.bytesLoaded);
			
			dispatchEvent(event);
			
		}
		
		
		/**
		 */
		private function onID3Info(event:Event):void
		{
			event.target.removeEventListener(event.type,onID3Info);
			trace("MP3::onID3Info()");
			
		}
		
		
		
		/**
		 */
		override protected function onSongLoad(event:Event):void
		{
			super.onSongLoad(event);
			event.target.removeEventListener(ProgressEvent.PROGRESS,onDownloadProgress);
			
			
			
			onDownloadProgress(new ProgressEvent(ProgressEvent.PROGRESS,false,false,_sound.bytesLoaded,_sound.bytesTotal));
			
			
		}
		
		/**
		 */
		override protected function onSongOpen(event:Event):void
		{
			
			super.onSongOpen(event);
			
		}
		
		/**
		 */
		
		private function onPlayProgress():void
		{
			if(!_paused)
				Sleep.timeout(50,onPlayProgress);
				
			_totalTimeString = PlayerUtils.getTime(_sound.length);
			
			
			dispatchEvent(new Event("playing"));
		}
		
		
		
	}
}