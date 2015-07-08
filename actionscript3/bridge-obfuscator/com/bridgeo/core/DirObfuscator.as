package com.bridgeo.core
{
	import com.ei.utils.Cue;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.FileListEvent;
	import flash.filesystem.File;
	
	public class DirObfuscator extends EventDispatcher implements IObfuscator
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _cue:Cue;
		private var _dir:File;
		private var _root:File;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DirObfuscator(dir:File,isRoot:Boolean = false,root:File = null)
		{
			_dir = dir;
			
			if(isRoot)
				_root = dir;
			else
				_root = root;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function start():void
		{
			_dir.addEventListener(FileListEvent.DIRECTORY_LISTING,onFileListing);
			_dir.getDirectoryListingAsync();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		

		private function onFileListing(event:FileListEvent):void
		{
			_cue = new Cue(Event.COMPLETE,onDirComplete);
			
			event.target.removeEventListener(event.type,onFileListing);
			
			
			var dirs:Array = new Array();
			
			for each(var item:File in event.files)
			{
				if(item.isDirectory)
				{
					dirs.push(new DirObfuscator(item,false,_root));
					
				}
				else
				if(item.extension == "xml")
				{
					dirs.push(new XMLObfuscator(item,_root));
				}
				else
				{
					dirs.push(new FileObfoscator(item,_root));
				}
			}
			
			_cue.setStack(dirs);
			_cue.addEventListener(Event.COMPLETE,onCueComplete);
			_cue.start();
		}
		
		/**
		 */
		private function onDirComplete(item:IObfuscator):void
		{
			item.start();
		}
		/**
		 */
		private function onCueComplete(event:Event):void
		{
			event.target.removeEventListener(event.type,onCueComplete);
			
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}