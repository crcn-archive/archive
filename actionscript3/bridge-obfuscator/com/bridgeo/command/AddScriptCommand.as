package com.bridgeo.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.bridgeo.model.BridgeOModelLocator;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	
	public class AddScriptCommand implements ICommand
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
		 
		
		public function AddScriptCommand()
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
			
			var filter:FileFilter = new FileFilter("load file","*.zip;*.xml");
			
			_ref.addEventListener(Event.SELECT,onDirSelect);
			
			_ref.browseForDirectory("choose the script directory")
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		private function onDirSelect(event:Event):void
		{
			
			_model.scriptList.push(_ref);
			
			
			var scr:Array = _model.scriptList;
			
			_model.scriptList = null;
			_model.scriptList = scr;
		}
		

	}
}