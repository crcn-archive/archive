package com.bridge.ui.controls.media.audio
{
	import com.bridge.ui.controls.media.Player;
	
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.*;
	
	public class AudioFactory extends Proxy implements IEventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _currentPlayer:AudioPlayer;
		private var _eventListeners:Object;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function AudioFactory()
		{
			super();
			_eventListeners = new Object();
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override flash_proxy function setProperty(name:*,value:*):void
		{
			_currentPlayer[name] = value;
		}
		
		/**
		 */
		override flash_proxy function callProperty(name:*,...rest:Array):*
		{
			if(name == "toString")
				return "";
				
			return _currentPlayer[name].apply(_currentPlayer,rest);
		}
		
		/**
		 */
		 
		override flash_proxy function getProperty(name:*):*
		{
			return _currentPlayer[name];
		}
		
		/**
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
				if(_currentPlayer)
			_currentPlayer.addEventListener(type,listener,useCapture,priority,useWeakReference);
			
			
			if(!_eventListeners[type])
				_eventListeners[type] = new Array();
			
			_eventListeners[type].push({type:type,listener:listener,useCapture:useCapture,priority:priority,useWeakReference:useWeakReference});
		}
		
		/**
		 */
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return _currentPlayer.dispatchEvent(event);
		}
		
		/**
		 */
		
		public function hasEventListener(type:String):Boolean 
		{
			return _currentPlayer.hasEventListener(type);
		}
		
		/**
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			if(_currentPlayer)
				_currentPlayer.removeEventListener(type,listener,useCapture);
			
			if(!_eventListeners[type])
				_eventListeners[type] = new Array();
				
			for(var data:Object in _eventListeners[type])
			{
				if(_eventListeners[type][data].listener == listener)
					delete _eventListeners[type][data];
			}
			
		}
		
		/**
		 */
		public function willTrigger(type:String):Boolean 
		{
			return _currentPlayer.willTrigger(type);
		}
		
		
		

		/**
		 */
		
		public function load(value:String):void
		{
			var tunerRegexpTest:RegExp = /(?<=:)\d+/i;
			
			var oldPlayer:Player = _currentPlayer;
			
			if(tunerRegexpTest.test(value))
			{
				_currentPlayer = new AudioTuner();
				trace("AudioFactory::USE AUDIO TUNER");
			}
			else
			{
				_currentPlayer = new MP3Player();
				trace("AudioFactory::USE MP3 PLAYER");
			}
			
			
			for each(var ev:Array in _eventListeners)
				for each(var data:Object in ev)
				{
					if(oldPlayer)
						oldPlayer.removeEventListener(data.type,data.listener,data.useCapture);
						
					_currentPlayer.addEventListener(data.type,data.listener,data.useCapture,data.priority,data.useWeakReference);
						
				}
				
			
			_currentPlayer.dispatchEvent(new Event(Event.OPEN));
			
			try
			{
				_currentPlayer.load(value);
			}catch(e:*)
			{
				trace(e);
			}
			trace("GO");
			
			
		}
		
		
		

	}
}
	