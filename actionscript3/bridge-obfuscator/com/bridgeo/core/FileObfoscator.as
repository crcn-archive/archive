package com.bridgeo.core
{
	import com.bridgeo.model.BridgeOModelLocator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	public class FileObfoscator extends EventDispatcher implements IObfuscator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable]
		private var _model:BridgeOModelLocator = BridgeOModelLocator.getInstance();
		private var _item:File;
		private var _root:File;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function FileObfoscator(item:File,root:File = null)
		{
			item.addEventListener(Event.COMPLETE,onOpen);
			_item = item;
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
			_item.load();
		}
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function onOpen(event:Event):void
		{
			
			event.target.removeEventListener(event.type,onOpen);
			
			var newPath:String = _item.nativePath;
			
			if(_root)
			{
				var tes:RegExp = new RegExp("^"+_root.nativePath);
				newPath = newPath.replace(tes,"");
			}
			
			_model.output.addFile(newPath,_item.data);
			
			dispatchEvent(new Event(Event.COMPLETE));
			
		}

	}
}