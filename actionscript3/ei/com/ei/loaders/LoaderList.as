package com.ei.loaders{		import com.ei.events.FileEvent;
	import com.ei.events.LoaderListEvent;
	
	import flash.events.EventDispatcher;		public class LoaderList extends EventDispatcher implements ILoadProgress,ILoaderList	{				//-----------------------------------------------------------		//		//Private Variables		//		//-----------------------------------------------------------				private var _stack:Array;		private var _initialized:Boolean;		private var _lastLoader:ILoadProgress;		private var _name:String;		//-----------------------------------------------------------		//		//Constructor		//		//-----------------------------------------------------------				/**		*/				public function LoaderList(name:String ="")		{			_stack = new Array();			_name = name;		}				//-----------------------------------------------------------		// 		//Getters / Setters		//		//-----------------------------------------------------------				/**		 */				public function get length():int		{			return _stack.length;		}				/**		*checks if all of the files have been loaded and returns TRUE if they have		*/				public function get loaded():Boolean		{			//default val is true so anything can switch it to false			var loaded:Boolean = true;						//once one file has been found that isn't loaded, break the loop			for each(var comp:ILoadProgress in _stack)			{				//get the loaded boolean value				loaded = comp.loaded;								//if not loaded, then break				if(!loaded)				{					break;				}							}			//return the result			return loaded;		}				/**		*/				public function get bytesLoaded():int		{			var bytes:int;			for each(var comp:ILoadProgress in _stack)			{				bytes += comp.bytesLoaded;			}						return bytes;						}				/**		*/				public function get bytesTotal():int		{			var bytes:int;						for each(var comp:ILoadProgress in _stack)			{				bytes += comp.bytesTotal;			}						return bytes;		}				/**		*/				public function get initialized():Boolean		{			return _initialized;		}								//-----------------------------------------------------------		// 		//Public Methods		//		//-----------------------------------------------------------				/**		*adds a new loader object to the list and adds a load complete listener		*/				public function addLoader(newLoader : ILoadProgress):void		{			//add the loaded to the stack so it can be read			_stack.push(newLoader);						//listen for when the loader is complete			newLoader.addEventListener(FileEvent.COMPLETE,onLoadComplete);			newLoader.addEventListener(FileEvent.PROGRESS,onLoadProgress);					}				/**		 */				public function getLoader(index:int):ILoader		{						return _stack[ index ] as ILoader;		}				/**		*starts the load in all the loader objects		*/				public function startLoader():void		{			//do NOT initialize the loader again			if(!_initialized)			{				//go through each loader and initialize them				for each(var comp:ILoadProgress in _stack)				{										//start the loaded					comp.startLoader();				}								//signal that the list has been initialized				_initialized = true;			}		}				//-----------------------------------------------------------		// 		//Private Methods		//		//-----------------------------------------------------------				/**		*caught whenever a file is done loaded		*/			private function onLoadComplete(event : FileEvent):void		{						var currentTarget:ILoadProgress = ILoadProgress(event.currentTarget);						//dispatch the current file for the Que so the LoadManager knows when a file is loaded			dispatchEvent(new FileEvent(event.type,true,true));						//if all of the files have been loaded then dispatch the final event			if(loaded)			{				//remove this listener so it isn't caught again for any reason				currentTarget.removeEventListener(FileEvent.COMPLETE,onLoadComplete);				currentTarget.removeEventListener(FileEvent.PROGRESS,onLoadProgress);												dispatchEvent( new LoaderListEvent(LoaderListEvent.COMPLETE) );												//reset the class so it can be used again				_stack 		 = new Array();				_initialized = false;				_lastLoader  = null;							}		}				private function onLoadProgress(event : FileEvent):void		{			var target:ILoader = event.currentTarget as ILoader;			dispatchEvent(new FileEvent(event.type,true,true));		}	}}	