package com.ei.ui.containers
{
	import com.ei.ui.core.EUIComponent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class EImage extends EUIComponent
	{
		//-----------------------------------------------------------
		// 
		// private function 
		//
		//-----------------------------------------------------------
		
		private var _child:Bitmap;
		private var _bmd:BitmapData;
		private var _width:Number;
		private var _height:Number;
		private var _source:DisplayObject;
		private var _proportional:Boolean;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		public function EImage(target:DisplayObject = null,proportional:Boolean = true)
		{
			
			super();
			_proportional = true;

			_child        = new Bitmap();
			
			if(target != null)
				source = target;
				
			addChild(_child);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		

		
		/**
		 */
		
		public function get proportional():Boolean
		{
			return _proportional;	
		}
		
		public function set proportional(isProp:Boolean):void
		{
			_proportional = isProp;
		}
		
		/**
		 */
		
		public function set source(value:DisplayObject):void
		{
			_source = value;
			
			_bmd = new BitmapData(value.width,value.height,true,0xFFFFFF);
			_bmd.draw(value);
			
			_child.bitmapData = _bmd;
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		public function get source():DisplayObject
		{
			return _source;
		}
		
		/**
		 */
		
		override public function set width(newWidth:Number):void
		{
			_width = newWidth;

			var percent:Number = _width / getDem("width");
			
			_child.width = _width;
			
			if(_proportional)
				_child.height = getDem("height") * percent;
				
			_child.smoothing = true;
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		
		/**
		 */
		 
		override public function set height(newHeight:Number):void
		{
			
			_height = newHeight;
			var percent:Number = _height / getDem("height");
			
			_child.height = _height;
			
			if(_proportional)
				_child.width = getDem("width") * percent;
			
			_child.smoothing = true;
			
			dispatchEvent(new Event(Event.RESIZE));
		}
		
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function getDem(dem:String):Number
		{
			if(_source != null)
				return _source[ dem ];
				
			else
				return 1;
		}
		
		
	}
}