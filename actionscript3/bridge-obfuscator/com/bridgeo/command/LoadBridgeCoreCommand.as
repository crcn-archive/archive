package com.bridgeo.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.bridgeo.model.BridgeOModelLocator;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	public class LoadBridgeCoreCommand implements ICommand
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _ref:File;
		
		[Bindable]
		private var _model:BridgeOModelLocator = BridgeOModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function LoadBridgeCoreCommand()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function execute(event:CairngormEvent):void
		{
			_ref= new File();
			
			
			trace("LoadBridgeCoreCommand::execute()");
			
			var filter:FileFilter = new FileFilter("bridge core script","*.xml");
			
			_ref.addEventListener(Event.SELECT,onFileSelect);
			_ref.addEventListener(Event.COMPLETE,onFileOpen);
			_ref.browse([filter]);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onFileSelect(event:Event):void
		{
			event.target.removeEventListener(event.type,onFileSelect);
			
			_ref.load();
		}
		
		/**
		 */
		 
		private function onFileOpen(event:Event):void
		{
			
			_model.coreScriptPath = _ref.url;
			_model.coreScript 	  = _ref.data.readUTFBytes(_ref.data.bytesAvailable);
		}
	}
}