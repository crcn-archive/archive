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

package com.bridge.ui.utils.tween
{
	import com.bridge.events.TweenEvent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.Timer;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	
	public class Tween extends EventDispatcher
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		
		private var _item:Object;
		private var _property:String;
		private  var _start:Object;
		private  var _stop:Object;
		private var _duration:Number;
		private var _round:Boolean;
		private var _fps:Number;
		private var _complete:Boolean;
		private var _easingFunction:Function;
		private var _tweenHandler:Function;
		
		
		private var _timer:Timer;
		private var _currentTime:Number;
		
		private static const DUMMY_FRAMERATE:int = 30;

		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		 

		public function Tween(item:Object, property:String = null, start:Object = 0, stop:Object = 0, duration:uint = 0, tweenHandler:Function = null,fps:int = 35){
			
			
			_item	   = item;
			
			_fps       = fps;
			
			if(property != null)
				execute(property,start,stop,duration,tweenHandler);
			
		}
		
		
		
		public function execute(property:String, start:Object, stop:Object, duration:uint, tweenHandler:Function = null,fps:int = 35):void{
			_property  = property;
			_start	   = start;
			_stop 	   = stop;
			
			_duration  = duration;
			
			//initialize the tween
			
			_easingFunction = defaultEquation;
			_currentTime	= 0;
			
			if(tweenHandler != null)
			{
				_tweenHandler = tweenHandler;
			}
			else
			{
				_tweenHandler = defaultHandler;
			}
			
			if(_timer != null)
				endTween();
				
			startTween();
		}
		
		public function get complete():Boolean
		{
			return _complete;
		}
		
		private var _interval:int;
		
		/**
		 */
		
		public function startTween():void
		{
			//faster
			if(_item is DisplayObject)
				_item.addEventListener(Event.ENTER_FRAME,onTimer);
			else
				_interval = setInterval(onTimer,DUMMY_FRAMERATE);
			
			dispatchEvent(new TweenEvent(TweenEvent.START,true,true));
		}
		
		/**
		 */
		 
		public function endTween():void
		{
			if(_item is DisplayObject)
				_item.removeEventListener(Event.ENTER_FRAME,onTimer);
			else
				clearInterval(_interval);
			
		}
		
		/**
		 */
		 
		public function pause():void
		{
			_timer.stop();
		}
		
		/**
		 */
		 
		public function resume():void
		{
			_timer.start();
		}
		
		/**
		 */
		 
		public function reverse():void
		{
			var middleMan:Object;
			middleMan = _start;
			_start 	  = _stop;
			_stop 	  = middleMan;
			
			//restart the tween if it has stopped
			if(!_timer.running)
			{
				startTween();
			}
		}
		
		/**
		 */
		 
		public function set easingFunction(newEquation:Function):void
		{

			_easingFunction = newEquation;
		}
		
		/**
		 */
		
		public function get easingFunction():Function
		{
			return _easingFunction;
		}
		
		
		/**
		 */
		 
		public function get item():*
		{
			return _item;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		private function onTimer(event:Event=null):void{
			
			var st:Stage;
			
			if(_item is DisplayObject)
				st = DisplayObjectContainer(_item).stage;
			
			var framerate = DUMMY_FRAMERATE;
			
			if(st != null)
			{
				framerate = DisplayObjectContainer(_item).stage.frameRate;
			}
				
			
			//because FPS is not actually the time, divide it by 1000 so the duration in MS is always right and doesn't get screwed by FPS
			_currentTime += framerate;
			
			if(_stop != _start)
			{
				_tweenHandler(_item, _property, _currentTime, _start, _stop, _duration, _easingFunction);

				//dispatchEvent(new TweenEvent(TweenEvent.TWEENING,true,true));

				//stop the clip if the time goes past the speed
				//this ends the tween function
	
				if(_currentTime >= _duration)
				{
					_item[ _property ] = _stop;
					endTween();
					dispatchEvent(new TweenEvent(TweenEvent.COMPLETE,true,true));
					_complete = true;
				}
			}
			
			
		}
		
		/**
		 */
		
		private function defaultHandler(item:Object, property:String, currentTime:Number, start:Number, stop:Number, duration:Number, easingFunction:Function):void
		{
			//get the new position
			var change:Number = stop - start;
			var newPosition:Number = easingFunction(currentTime, start, change, duration);
			
			
			if(!isNaN(newPosition))
			{
				item[ property ] = newPosition;
			}
			
		}
		
		/**
		 */
		 
		private function defaultEquation(t:Number,b:Number,c:Number,d:Number):Number
		{
			return c / 2 * (Math.sin(Math.PI * (t / d - 0.5)) + 1) + b;
		}
		
		
	}
}