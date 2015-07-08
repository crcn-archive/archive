package com.bridge.ui.controls
{
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.layout2.ConstraintLayout;
	import com.bridge.ui.layout2.decor.AspectRatioDecorator;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	
	
	public class Image extends UIComponent
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _source:Object;
		private var _child:Bitmap;
		private var _width:Number;
		private var _height:Number;
		private var _widthSet:Boolean;
		private var _heightSet:Boolean;
		private var _proportional:Boolean;
		private var _scaler:AspectRatioDecorator;
		private var _container:Sprite;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function Image()
		{
			super();
			
			_child        = new Bitmap();
			
			_width  = 1;
			_height = 1;
			
			
			_scaler = new AspectRatioDecorator();
			
			var lay:ConstraintLayout = this.layout as ConstraintLayout;
			
			lay.registerConstraint(_scaler);
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		/**
		 */
		 
		override public function set width(value:Number):void
		{
			
			super.width = value;
			_widthSet = true;
			
			_width = value;
			
			setSize();
			
		}
		
		override public function get width():Number
		{
			return _width;
		}
		
		override public function set height(value:Number):void
		{
			super.height = value;
			
			_heightSet = true;
			//_child.height = value;
			
			_height = value;
			
			setSize();
		}
		
		override public function get height():Number
		{
			return _height;
		}
		
		
		/**
		 */
		 
		public function set source(value:*):void
		{
			_source = value;
			
			
			if(value is DisplayObject)
			{
				
				setImage(value);
				
			}
			else
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onLoaderComplete);
				loader.load(new URLRequest(value.toString()),new LoaderContext(true));
			}
		}
		
		/**
		 */
		 
		public function get source():Object
		{
			return _source;
		}
		/**
		 */
		
		ui_internal function set container(value:Sprite):void
		{
			_container = value;
			
			
			ui_internal::view = value;
		}
		
		/**
		 */
		
		ui_internal function get container():Sprite
		{
			return _container;
		}
		
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
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        
		
		/**
		 */
		override protected function init():void
		{
			super.init();
			
			setSize();
			
		}
			
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		private function setImage(value:DisplayObject):void
		{
			
			
			_scaler.staticHeight = value.height;
			_scaler.staticWidth  = value.width;
			
			_width = value.width;
			_height = value.height;
			
			
			var bmd:BitmapData = new BitmapData(value.width,value.height,true,0xFFFFFF);
			bmd.draw(value);
			
			
			
			_child.bitmapData = bmd;
			
			
			setSize();
			this.width = _width;
			this.height = _height;
			
			
			this.update();
			
		}
		
		/**
		 */
		 
		private function setSize():void
		{
			
			if(!_child.bitmapData)
				return;
				
			if(_widthSet)
				_child.width = _width;
		
			if(_heightSet)
				_child.height = _height;
				
			
			if(this._container)
			{
				trace("CONT");
				_container.addChild(_child);
			}
			
			
		}
		
		/**
		 */
		 
		private function onLoaderComplete(event:Event):void
		{
			event.target.removeEventListener(event.type,onLoaderComplete);
			
			var loader:Loader = event.target.loader;
			
			
			setImage(loader);
		}
	}
}