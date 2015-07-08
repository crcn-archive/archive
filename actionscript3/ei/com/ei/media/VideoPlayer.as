package com.ei.media
{
	import com.ei.ui.core.EUIComponent;
	
	import flash.events.AsyncErrorEvent;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.NetStatusEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.TimerEvent;
	import flash.media.SoundTransform;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Timer;
	import flash.utils.setInterval;
	
	public class VideoPlayer extends EUIComponent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------


		private var _stream:NetStream;
		private var _connection:NetConnection;
		
		
		private var _currentVideo:String;
		
		
		private var _connected:Boolean;
		
		private var _currentStep:Number;
		
		private var _volume:Number;
		
		private var _soundTransform:SoundTransform;
		
		
		private var _timer:Timer;
		
		private var _playing:Boolean;
		
		
		private var _type:String;
		

		public  var _videoPlayer:Video;
		
		private var _currentTime:String;
		private var _totalTime:Number;
		
		//used to determine if the video is complete
		private var _lastTime:Number;
		
		
		private var _width:Number;
		private var _height:Number;
		
		
		private var _quePoints:Object;
		
		private var _paused:Boolean;
		
		
		private var _ffTime:Number = NaN;
		private var _rwTime:Number = NaN;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		
		public function VideoPlayer()
		{
			
			super();
			
			_quePoints = new Object()
			
			
			_videoPlayer = new Video();
			
			addChild(_videoPlayer);
			
			
			_connection = new NetConnection();
			
            _connection.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            _connection.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
            _connection.connect(null);
            
            _currentStep = 0;
            
            _soundTransform = new SoundTransform();
            
            
            _timer = new Timer(500);
            _timer.addEventListener(TimerEvent.TIMER,onPlaying);
          
            
            _currentTime = "";
            
        }
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set scaling(value:String):void
		{
			_type = value;
		}
		
		public function get scaling():String
		{
			
			return _type;
		}
		
		/**
		 */
		
		public function get percentDone():Number
		{
			if(_stream == null || _stream.client == null || _stream.client.info == null)
				return 0;
				
			
			return (_stream.time/_stream.client.info.duration) * 100;
		}
		
		/**
		 */
		
		public function set volume(value:Number):void
		{
			_volume = value;
			
			
			_soundTransform.volume = value / 100;
			
			
			if(_stream)
				_stream.soundTransform = _soundTransform;
				
			
		}
		
		/**
		 */
		
		public function get volume():Number
		{
			return _volume;
		}
		
		
		/**
		 */
		
		public function get percentLoaded():Number
		{
			return (_stream.bytesLoaded / _stream.bytesTotal) * 100;
		}
		
		
		/**
		 */
		
		override public function set width(value:Number):void
		{
			_width = super.width = value;
			
			
			//_videoPlayer.width = value;
		}
		
		override public function get width():Number
		{
			return _width;
			
			//return _videoPlayer.width;
		}
		
		override public function set height(value:Number):void
		{
			_height = super.height = value;
			
			//_videoPlayer.height = value;
		}
		
		override public function get height():Number
		{
			return _height;
			 
			//return _videoPlayer.height;
		}
		
		public function get currentTimeString():String
		{
			return getTime(_stream.time);
		}
		
		
		public function get timeLeftString():String
		{
			return getTime(_stream.client.info.duration - _stream.time);
		}
		
		
		public function set totalTimeString(value:String):void
		{
			_totalTime = new Number(value);
		}
		
		public function get totalTimeString():String
		{
			return getTime(_totalTime);
		}
		
		public function get totalSeconds():Number
		{
			return _totalTime;
		}
		
		
		
        //--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function addQuePoint(que:Function,time:String,reusable:Boolean,...params:Array):void
		{
			
			if(!_quePoints[time])
				_quePoints[time] = new Array();
				
			_quePoints[time].push({que:que,params:params,reusable:reusable,triggered:false});
		}
		
		/**
		 */
		
		public function clearQuePoints():void
		{
			_quePoints = new Object();
		}
		/**
		 */
		 
		public function load(value:String):void
		{
			
			_currentVideo = value;
			
			
			trace("VideoPlayer::load()");
			
			if(_connected)
			{
				
				_stream.client = new VideoClient(this);
				
				//_timer.stop();
				
				_stream.play(_currentVideo);
				
				
				//_stream.seek(1);
				
				//_timer.start();
				
				pause();
			}
		}
		
		/**
		 */
		
		public function togglePlay():void
		{
			
			
			if(_playing)
			{
				pause();
			}
			else
			{
				play();
			}
			
			_playing = !_playing;
			
			
			
			
		}
		
		public function get paused():Boolean
		{
			return _paused;
		}
		
		/**
		 */
		
		public function play():void
		{
			
			_paused = false;
			
			trace("VideoPlayer::play()");
			dispatchEvent(new Event("resume"));
			
			
			
			_stream.resume();
			
			
			_timer.stop();
			_timer.start();
			
			
		}
		
		/**
		 */
		
		public function pause():void
		{
			
			trace("VideoPlayer::pause()");
			
			_timer.stop();
			
			dispatchEvent(new Event("pause"));
			
			_stream.pause();
			
			
			_paused = true;
			
		}
		
		/**
		 * temporary
		 */
		
		public function stop():void
		{
			pause();
		}
		
		/**
		 */
		
		public function fastForward(steps:Number):void
		{
			
			if(!paused)
				pause();
			
			
			
			_ffTime = _stream.time + steps;
			
			
			if(!isNaN(_rwTime))
			{
				_ffTime = _rwTime;
				_rwTime = NaN;
			}
			
			
			_stream.seek(_ffTime);
			
			
			
			onPlaying();
			
		}
		
		
		
		/**
		 */
		
		public function rewind(steps:Number):void
		{
			if(!paused)
				pause();
			
			_rwTime = _stream.time - (steps*2);
			
			trace(_rwTime,_ffTime);
			if(!isNaN(_ffTime))
			{
				_rwTime = _ffTime;
				_ffTime = NaN;
			}
			
			if(_rwTime <= 0)
			{
				_rwTime = 0;
				
				
			}
			
			_stream.seek(_rwTime);
			trace(_stream.time);
			
			
			onPlaying();
				
		}
		
		
		/**
		 */ 
		
		public function seek(value:Number):void
		{
			
			trace("VideoPlayer::seek("+value+")");
			
			
			pause();
			
			var newTime:Number = (_stream.client.info.duration * value) / 100;
			
			trace("VideoPlayer::newTime = "+newTime);
			
			//var b:Dragger = Eventnew Dragger(target,type,lockCenter,objBounds);
			//b.startDragger();
			//b.
			
			
			try
			{
				_stream.seek(newTime);
			}catch(e:*)
			{
				trace("VideoPlayer::invalidSeekTime");
				dispatchEvent(new Event("invalidSeekTime"));
			}
		}
		
		
        
        //--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		

        private function netStatusHandler(event:NetStatusEvent):void 
        {
        	
        	trace("VideoPlayer::netStatusHandler()");
        	
            switch (event.info.code) 
            {
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    //trace("Unable to locate video: " + videoURL);
                    break;
            }
        }

        /**
		 */
		

        private function connectStream():void 
        {
        	trace("VideoPlayer::connectStream()");
        	
        	_connected = true;
        	
            _stream = new NetStream(_connection);
            _stream.addEventListener(NetStatusEvent.NET_STATUS, netStatusHandler);
            _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onError);
            _stream.addEventListener(IOErrorEvent.IO_ERROR,onError);
  

            _videoPlayer.attachNetStream(_stream);
            
            
            if(_currentVideo)
             	_stream.play(_currentVideo);
             	
             
            
        }
        
        
		
		private function onError(event:*):void
		{
			trace(event);
		}
		
		/**
		 */
		
		
        private function securityErrorHandler(event:SecurityErrorEvent):void 
        {
            trace("securityErrorHandler: " + event);
        }
        
        /**
		 */
		
		
        private function asyncErrorHandler(event:AsyncErrorEvent):void 
        {
            // ignore AsyncErrorEvent events.
        }
        
        /**
		 */
		
		function onPlaying(event:TimerEvent = null):void
		{
			//ugly.
			if(_stream.time == _lastTime && event && Math.floor(_stream.time) == Math.floor(_totalTime))
			{
				stop();
				
				dispatchEvent(new Event("videoComplete"));
				
			}
			
		
			_lastTime = _stream.time;
			_currentTime = getTime(_stream.time);
			
			var quePoints:Array = _quePoints[this.getTime(Math.floor(_lastTime))];
			
			trace("VideoPlayer::"+quePoints);
			for each(var que:Object in quePoints)
			{
				
				if(que && (!que.triggered || que.reusable))
				{
					
					var func:Function = que.que;
					var params:Array = que.params;
					que.triggered = true;
					
					func.apply(null,params);
				}
			}
			
			
			dispatchEvent(new Event("playing"));
			
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
	import flash.events.EventDispatcher;
	import com.ei.media.VideoPlayer;
	import com.ei.display.decor.AspectRatio;
	import com.ei.media.Scaling;
	import com.ei.display.decor.AspectRatioType;
	import flash.events.Event;
	import com.ei.display.decor.Constraints;
	import com.ei.display.decor2.AspectRatioDecorator;
	import com.ei.utils.ObjectUtils;
	import flash.utils.setInterval;
	import flash.events.ProgressEvent;
	import flash.utils.clearInterval;
	import com.ei.utils.Sleep;
	

	class VideoClient
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var info:Object;
		public var player:VideoPlayer;
		
		private var _ratio:AspectRatioDecorator;
		
		private var _interval:int = -1;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
		
		public function VideoClient(player:VideoPlayer):void
		{
			this.player = player;
			
			
			_ratio = new AspectRatioDecorator(player);
			//_ratio.stretch = false;
			
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		
		
	    public function onMetaData(info:Object):void 
	    {
	    	
	    	this.info = info;
	    	
	    	_ratio.staticHeight = info.height;
	    	_ratio.staticWidth  = info.width;
	    	
	    	
	    	_ratio.aspectRatioType = player.scaling;
	    	
	   		player.totalTimeString = info.duration;
	   		
	   		player.dispatchEvent(new Event("loaded"));
	   		
	   		Sleep.timeout(1000,resize);
	   		
	   		
	   		destroyProgress();
	   			
	   		_interval = setInterval(getProgress,800);
	   		
	        trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
	    }
	    
	    private function resize():void
	    {
	    	player.dispatchEvent(new Event(Event.RESIZE));
	    }
	    
	    public function getProgress():void
	    {
	    	if(player.percentLoaded == 100)
	    	{
	    		destroyProgress();
	    	}
	    		
	    	player.dispatchEvent(new ProgressEvent(ProgressEvent.PROGRESS));
	    }
	    
	    
	    
	    private function destroyProgress():void
	    {
	    	if(_interval > 0)
	   			clearInterval(_interval);
	   			
	    }
	    
	    /**
		 */
		
		
	    public function onCuePoint(info:Object):void 
	    {
	        trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	    }
	}