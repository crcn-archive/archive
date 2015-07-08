/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/

package com.bridge.ui.controls.media
{
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.layout2.ConstraintLayout;
	import com.bridge.ui.layout2.decor.AspectRatioDecorator;
	
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
	
	public class VideoPlayer extends UIComponent implements IPlayer
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
		
		
		private var _cuePoints:Object;
		
		private var _paused:Boolean;
		
		private var _bufferTime:Number;
		
		
		private var _ffTime:Number = NaN;
		private var _rwTime:Number = NaN;
		
		private var _factor;
		
		private var _enableControls:Boolean;
		
		
		private var _ratioDecorator:AspectRatioDecorator;
		
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
			
			_factor = "";
			
			_enableControls = true;
			
			_cuePoints = new Object()
			
			
			_videoPlayer = new Video();
			
			_bufferTime = 0;
			
			
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
			currentStyle.setProperty("aspectRatioType",value);
		}
		
		public function get scaling():String
		{
			
			return currentStyle.getProperty("aspectRatioType");
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
		
		public function set bufferTime(value:Number):void
		{
			_bufferTime = value;
			
			

		}
		
		/**
		 */
		
		public function get bufferTime():Number
		{
			return _bufferTime;
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
			_width = value;
			
			
			_videoPlayer.width = value;
		}
		
		override public function get width():Number
		{
			//return _width;
			
			return _videoPlayer.width;
		}
		
		override public function set height(value:Number):void
		{
			_height = value;
			
			_videoPlayer.height = value;
		}
		
		override public function get height():Number
		{
			//return _height;
			 
			return _videoPlayer.height;
		}
		
		public function get currentTimeString():String
		{
			return getTime(_stream.time);
		}
		
		
		public function get timeLeftString():String
		{
			
			var time:Number = _stream.client.info.duration - _stream.time;
			
			if(time < 0)
				time = 0;
				
			return getTime(time);
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
		
		/**
		 */
		
		public function get timeFactor():String
		{
			return _factor;
		}
		
		
		public function get type():String
		{
			return "video";
		}
		
		/**
		 */
		 
		public function set enableControls(value:Boolean):void
		{
			_enableControls = value;
		}
		
		/**
		 */
		public function get enableControls():Boolean
		{
			return _enableControls;
		}
		
		
        //--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		public function addCuePoint(cue:Function,time:String,reusable:Boolean,...params:Array):void
		{
			
			if(!_cuePoints[time])
				_cuePoints[time] = new Array();
				
			_cuePoints[time].push({cue:cue,params:params,reusable:reusable,triggered:false});
		}
		
		/**
		 */
		
		public function clearCuePoints():void
		{
			_cuePoints = new Object();
		}
		/**
		 */
		 
		public function load(value:String):void
		{
			trace("VideoPlayer::load("+value);
			
			
			_currentVideo = value;
			
			
			//trace("VideoPlayer::load()");
			
			if(_connected)
			{
				
				trace("VideoPlayer::connected()");
				if(!(_stream.client is VideoClient))
				{
					_stream.client = new VideoClient(this);
				}
				
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
			
			if(!_enableControls)
				return;
			
			_paused = false;
			
			//trace("VideoPlayer::play()");
			dispatchEvent(new Event("resume"));
			
			
			
			_stream.resume();
			
			
			_timer.stop();
			_timer.start();
			
			
		}
		
		/**
		 */
		
		public function pause():void
		{
			
			if(!_enableControls)
				return;
			
			//trace("VideoPlayer::pause()");
			
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
			
			//trace(_rwTime,_ffTime);
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
			//trace(_stream.time);
			
			
			onPlaying();
				
		}
		
		
		/**
		 */ 
		
		public function seek(value:Number):void
		{
			
			//trace("VideoPlayer::seek("+value+")");
			
			//on constant seek pause dispatches an event
			if(!_paused)
				pause();
			
			var newTime:Number = (_stream.client.info.duration * value) / 100;
			
			//trace("VideoPlayer::newTime = "+newTime);
			
			//var b:Dragger = Eventnew Dragger(target,type,lockCenter,objBounds);
			//b.startDragger();
			//b.
			
			
			try
			{
				_stream.seek(newTime);
			}catch(e:*)
			{
				//trace("VideoPlayer::invalidSeekTime");
				//dispatchEvent(new Event("invalidSeekTime"));
			}
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        
		ui_internal function get ratioDecorator():AspectRatioDecorator
		{
			return _ratioDecorator;
		}
        /**
		 */
		 
		 override protected function invalidateLayoutDecorators():void
		 {
		 	super.invalidateLayoutDecorators();
		 	
		 	var lay:ConstraintLayout = this.layout as ConstraintLayout;
		 	
		 	_ratioDecorator = new AspectRatioDecorator();
		 	
		 	lay.registerConstraint(_ratioDecorator,0);
		 	
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
        	
        	trace(event.info.code);
        	
            switch (event.info.code) 
            {
                case "NetConnection.Connect.Success":
                    connectStream();
                    break;
                case "NetStream.Play.StreamNotFound":
                    //connectStream();
                    break;
            }
        }

        /**
		 */
		

        private function connectStream():void 
        {
        	//trace("VideoPlayer::connectStream()");
        	
        	_connected = true;
        	
        	if(_stream)
        	{
        		
        	}
        	
            _stream = new NetStream(_connection);
            
            _stream.addEventListener(NetStatusEvent.NET_STATUS, netStreamStatusHandler);
            _stream.addEventListener(AsyncErrorEvent.ASYNC_ERROR,onError);
            _stream.addEventListener(IOErrorEvent.IO_ERROR,onError);
  
			
        	 _videoPlayer.attachNetStream(_stream);
           
            
            if(_currentVideo)
             	_stream.play(_currentVideo);
             	
             
            
        }
        
        private function netStreamStatusHandler(event:NetStatusEvent):void
        {
        	switch(event.info.code)
        	{
        		case "NetStream.Play.StreamNotFound":
        		break;
        		default:
        			//trace(event.info.code);
            
        		break;
        	}
        	
        }
        
        
		
		private function onError(event:*):void
		{
			//trace(event);
			//trace(event);
		}
		
		/**
		 */
		
		
        private function securityErrorHandler(event:SecurityErrorEvent):void 
        {
            //trace("securityErrorHandler: " + event);
        }
        
        /**
		 */
		
		
        private function asyncErrorHandler(event:AsyncErrorEvent):void 
        {
            // ignore AsyncErrorEvent events.
        }
        
        /**
		 */
		
		public function get percentBuffered():Number
		{
			return Math.round(_stream.bufferLength/(_stream.time+_bufferTime)*100);
		}
        
        /**
		 */
		
		private function onPlaying(event:TimerEvent = null):void
		{
			//ugly.
			
			var buffering:Boolean;
			
			
			if(_stream.time > 3600)
			{
				_factor = "Hours";
			}
			else
			if(_stream.time > 60)
			{
				_factor = "Minutes";
			}
			else
			{
				_factor = "Seconds";
			}
			
			
			
			if(_stream.time == _lastTime && event && Math.floor(_stream.time) == Math.floor(_totalTime))
			{
				
				stop();
				
				dispatchEvent(new Event("end"));
				
				
			}
			
			
			_lastTime = _stream.time;
			_currentTime = getTime(_stream.time);
			
			
			
			//both methods of adding cues are acceptable 
			
			//only seconds 5
			
			trace("VideoPlayer::"+_currentTime,_lastTime);
			var cuePointsInt:Array = _cuePoints[Math.floor(_lastTime)];
			
			
			//minutes 0:05
			var cuePointsString:Array = _cuePoints[_currentTime];
			
			if(cuePointsInt == null)
				cuePointsInt = new Array();
			
			if(cuePointsString == null)
				cuePointsString == new Array();
			
			//merge both cues
			var allCues = cuePointsInt.concat(cuePointsString);
			
			
			for each(var cue:Object in allCues)
			{
				if(cue && (!cue.triggered || cue.reusable))
				{
					
					trace("VideoPlayer::ON CUE");
					
					var func:Function = cue.cue;
					var params:Array = cue.params;
					cue.triggered = true;
					
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
	import flash.events.Event;
	import com.ei.utils.ObjectUtils;
	import flash.utils.setInterval;
	import flash.events.ProgressEvent;
	import flash.utils.clearInterval;
	import com.ei.utils.Sleep;
	import com.bridge.ui.controls.media.VideoPlayer;
	import com.bridge.ui.layout.decor.AspectRatioDecorator;
	import com.bridge.ui.layout.decor.AspectRatioType;
	import com.bridge.ui.controls.media.VideoScaling;
	import com.bridge.ui.core.ui_internal;
	

	class VideoClient
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var info:Object;
		public var player:VideoPlayer;
		
		
		private var _interval:int = -1;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Constants
        //
        //--------------------------------------------------------------------------
		
		public function VideoClient(player:VideoPlayer):void
		{
			this.player = player;
		
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
	    	
	    	
	    	player.ui_internal::ratioDecorator.staticHeight = info.height;
	    	player.ui_internal::ratioDecorator.staticWidth  = info.width;
	    	
	    	
	    	
	    	player.ui_internal::ratioDecorator.aspectRatioType = player.scaling;
	    	
	    	
	    	player.update();
	    	
	   		player.totalTimeString = info.duration;
	   		
	   		player.dispatchEvent(new Event("loaded"));
	   		
	   		Sleep.timeout(1000,resize);
	   		
	   		
	   		destroyProgress();
	   		
	   		_interval = setInterval(getProgress,800);
	   		
	   		
	        //trace("metadata: duration=" + info.duration + " width=" + info.width + " height=" + info.height + " framerate=" + info.framerate);
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
	        //trace("cuepoint: time=" + info.time + " name=" + info.name + " type=" + info.type);
	    }
	}