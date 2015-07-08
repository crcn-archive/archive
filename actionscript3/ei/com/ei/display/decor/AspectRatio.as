package com.ei.display.decor
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import mx.events.ResizeEvent;
	
	public class AspectRatio
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _target:DisplayObject;
		private var _parent:DisplayObject;
		
		private var _useRatio:Boolean;
		
		private var _timer:Timer;
		
		private var _staticWidth:Number;
		
		private var _staticHeight:Number;
		
		
		private var _zoom:Number;
		
		private var _stretch:Boolean;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function AspectRatio(target:DisplayObject)
		{
			_target   = target;
			
			
			_zoom = 0;
			
			if(_parent == null && _target.parent != null)
			{
				_parent = _target.parent;
			}
			
			if(_parent == null)
				target.addEventListener(Event.ADDED,onAdded);
			else
				init();
				
			_timer = new Timer(30,5);
			_timer.addEventListener(TimerEvent.TIMER,onResize);
			_timer.start();
				
		
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set zoom(value:Number):void
		{
			_zoom = value;
			
			refresh(true);
		}
		
		/**
		 */
		
		public function set stretch(value:Boolean):void
		{
			_stretch = value;
		}
		
		/**
		 */
		
		public function get stretch():Boolean
		{
			return _stretch;
		}
		
		/**
		 */
		
		public function get zoom():Number
		{
			return _zoom;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		public function set staticWidth(value:Number):void
		{
			_staticWidth = value;
			
			//refresh(true);
		}
		
		public function get staticWidth():Number
		{
			return _staticWidth;
		}
		
		/**
		 */
		
		public function set staticHeight(value:Number):void
		{
			_staticHeight = value;
			
			//refresh(true);
		}
		
		public function get staticHeight():Number
		{
			return _staticHeight;
		}
		
		/**
		 */
		 
		public function refresh(dest:Boolean):void
		{
			var wRatio:Number = 1;
			var hRatio:Number = 1;
			//var ratio:Number
			
			if((_parent.width < staticWidth || _stretch) && _parent.width != 0)
			{
				
				wRatio = _parent.width / staticWidth;
				
			}
			
			if((_parent.height < staticHeight || _stretch) && _parent.height != 0)
			{
				hRatio = _parent.height / staticHeight;
				
			}
			////trace_parent.height,_parent.width,staticWidth,staticHeight,_target.width,_target.height,wRatio,hRatio);
			
			
			//ratio = 
			resize(wRatio < hRatio ? wRatio : hRatio,dest);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		private function onAdded(event:Event):void
		{
			
			event.target.removeEventListener(event.type,onAdded);
			
			
			_parent = event.target.parent;
				
			init();
			
			
			//_target.addEventListener(ResizeEvent.RESIZE,onResize);
			
		}
		
		/**
		 */
		
		private function init():void
		{
			////trace"INIT");
			
			staticWidth  = _target.width;
			staticHeight = _target.height;
			
			
			_parent.addEventListener(ResizeEvent.RESIZE,onResize);
			
			
			onResize();	
		}

		/**
		 */
		
		private function onResize(event:* = null):void
		{
			
			if(event != null && event.target == _target)
				return;
				
			if(!(event is TimerEvent) && _timer != null)
			{
				//the timer keeps the pumpkin to scale every 500 millisecond 5 times after the resizing has stopped
				_timer.reset();
				_timer.start();
			}
			
			//refresh(false);
			
			
			
		}
		
		/**
		 */
		
		private function resize(ratio:Number,dest:Boolean = false):void
		{
			//trace"KeepScale::resize("+ratio+")");
			////tracestaticWidth,staticHeight,_parent.height,ratio);
			
			ratio += _zoom / 10;
			
			
			
			if(!dest)
			{
				_target.width  = _staticWidth * (ratio - .1);
				_target.height = _staticHeight * (ratio - .1);
			}
			
			if(_useRatio)
			{
				_target.scaleX = ratio - .1;
				_target.scaleY = ratio - .1;
			}	
			
			
			
			
		}
		
		

	}
}