 package com.ei.loaders{		import com.ei.events.FileEvent;		import flash.events.Event;	import flash.events.EventDispatcher;	import flash.events.ProgressEvent;	import flash.net.URLLoader;	import flash.net.URLRequest;		public class TextLoader extends EventDispatcher implements ILoader	{		//-----------------------------------------------------------		// 		//Private Variables		//		//-----------------------------------------------------------				private var _url:String;		private var _loaded:Boolean;		private var _data:String;				private var _initialized:Boolean;		private var _register:Boolean;				private var _name:String;				//--------------------------------------------------------------------------   	    //        //  Public Variables        //        //--------------------------------------------------------------------------				public var request:URLRequest;				protected var _loader:URLLoader;				//-----------------------------------------------------------		// 		//Constructor		//		//-----------------------------------------------------------				/**		*/				public function TextLoader(name:String = "",registerLoader:Boolean = true)		{			_name 		  = name;			_loader 	  = new URLLoader();			_register	  = registerLoader;			request = new URLRequest();		}				//-----------------------------------------------------------		// 		//Getters / Setters		//		//-----------------------------------------------------------				/**		*/				public function get loaded():Boolean		{			return _loaded;		}				/**		*/				public function get bytesLoaded():int		{			return _loader.bytesLoaded;		}				/**		*/				public function get bytesTotal():int		{			return _loader.bytesTotal;		}				/**		*/				public function get initialized():Boolean		{			return _initialized;		}				/**		*/				public function get data():Object		{			return _data;		}				/**		*/				public function get name():String		{			return _name;		}						//-----------------------------------------------------------		// 		//Public Methods		//		//-----------------------------------------------------------				/**		*/				public function startLoader():void		{			_loader.addEventListener(Event.COMPLETE,onLoadComplete);			_loader.addEventListener(ProgressEvent.PROGRESS,onProgressEvent);			_loader.load(request);			_initialized = true;		}				/**		*/		public function load(url:String):void		{			_url = url;			request.url = url;			startLoader();		}				//-----------------------------------------------------------		// 		// Protected		//		//-----------------------------------------------------------				/**		*/				protected function onLoadComplete(event:Event):void		{			_loaded = true;			_data = _loader.data;			dispatchEvent(new FileEvent(FileEvent.COMPLETE));						_loader.removeEventListener(Event.COMPLETE,onLoadComplete);			_loader.removeEventListener(ProgressEvent.PROGRESS,onProgressEvent);					}				/**		*/				protected function onProgressEvent(event:ProgressEvent):void		{			dispatchEvent(new FileEvent(FileEvent.PROGRESS));		}			}		}