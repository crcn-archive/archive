package com.bridgeo.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.bridgeo.model.BridgeOModelLocator;
	import com.hurlant.eval.ast.Void;
	
	import flash.events.Event;
	import flash.filesystem.File;
	
	public class SelectOutputCommand implements ICommand
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
		 
		
		public function SelectOutputCommand()
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
			_ref = new File();
			_ref.addEventListener(Event.SELECT,onDirectorySelect);
			_ref.browseForDirectory("Output Directory");
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		private function onDirectorySelect(event:Event):void
		{
			event.target.removeEventListener(event.type,onDirectorySelect);
			
			_model.outputDir = _ref.url;
		}

	}
}