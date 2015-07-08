package com.bridgeo.command
{
	import com.adobe.cairngorm.commands.ICommand;
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.bridge.node.BridgeNode;
	import com.bridgeo.core.DirObfuscator;
	import com.bridgeo.model.BridgeOModelLocator;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.ByteArray;
	
	import mx.controls.Alert;
	
	public class ObfuscateCommand implements ICommand
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		[Bindable]
		private var _model:BridgeOModelLocator = BridgeOModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ObfuscateCommand()
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
			
			if(!_model.coreScriptPath)
			{
				Alert.show("Please load a core script. It should be something like bridgeCore.xml.");
				return;
			}
			
			/*if(_model.scriptList.length == 0)
			{
				Alert.show("Please provide a few scripts to obfuscate. They can either be zipped files or XML.");
				return;
			}*/
			
			/*if(!_model.outputDir)
			{
				Alert.show("Please select an output directory.");
				return;
			}*/
			
			
			var dec:BridgeNode = new BridgeNode();

			dec.nodeLibrary = _model.bridgeLibrary;
			dec.parseXML(_model.coreScript);
			
			
			var newCoreScript:String
			
			dec.restart();
			
			_model.output.clear();
			
			_model.output.addFile("bridgeCore.xml",dec.toString());
			
			
			var obf:DirObfuscator = new DirObfuscator(_model.scriptList[0],true);
			obf.addEventListener(Event.COMPLETE,onObComplete);
			obf.start();
			
			/*
			for each(var file:File in _model.scriptList)
			{
				
					trace(file.data.bytesAvailable);
				file.data.position = 0;
				switch(file.extension)
				{
					case "zip":
						new ZipObfuscator(file.data);
					break;
					case "xml":
						new XMLObfuscator(file.data.readUTFBytes(file.data.bytesAvailable));
					break;
				}
			}
			*/
			
			
			
			
		}
		
		
		/**
		 */
		
		private function onObComplete(event:Event):void
		{
			event.target.removeEventListener(event.type,onObComplete);
			
			
			var temp:File = new File();
			temp.addEventListener(Event.SELECT,onDirSave);
			
			temp.browseForSave("Save Bridge");
			
			
		}
		
		/**
		 */
		
		private function onDirSave(event:Event):void
		{
			var file:File = event.target as File;
			
			event.target.removeEventListener(event.type,onDirSave);
			
			var zip:ByteArray = _model.output.byteArray;
			
			var stream:FileStream = new FileStream();
			stream.open(file,FileMode.WRITE);
			stream.writeBytes(zip);
			stream.close();
			
		}

	}
}