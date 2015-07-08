package com.bridgeo.core
{
	import com.bridge.node.BridgeNode;
	import com.bridgeo.model.BridgeOModelLocator;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.filesystem.File;
	
	public class XMLObfuscator extends EventDispatcher implements IObfuscator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _item:File;
		private var _root:File;
		
		private var _model:BridgeOModelLocator = BridgeOModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function XMLObfuscator(item:File,root:File = null)
		{
			_item = item;
			_item.addEventListener(Event.COMPLETE,onOpen);
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
			
			var script:String = _item.data.readUTFBytes(_item.data.bytesAvailable);
			
			var newPath:String = _item.nativePath;
			
			if(_root)
			{
				var tes:RegExp = new RegExp("^"+_root.nativePath);
				newPath = newPath.replace(tes,"");
			}
			
			var node:BridgeNode = new BridgeNode();
			node.parsingEnabled = false;
			node.nodeLibrary = _model.bridgeLibrary;
			node.parseXML(script);
			node.restart();
			
			trace(node.toString());
			
			_model.output.addFile(newPath,node.toString());
			
			dispatchEvent(new Event(Event.COMPLETE));
		}

	}
}