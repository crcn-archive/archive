package com.bridgeo.core
{
	import com.bridgeo.model.BridgeOModelLocator;
	
	import deng.fzip.FZip;
	import deng.fzip.FZipFile;
	
	import flash.utils.ByteArray;
	
	import nochump.util.zip.ZipFile;
	
	public class ZipObfuscator
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _zipFile:ZipFile;
		
		[Bindable]
		private var _model:BridgeOModelLocator = BridgeOModelLocator.getInstance();
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ZipObfuscator(data:ByteArray)
		{
			
			var zip:FZip = new FZip();
			
		
			zip.loadBytes(data);
			
			var ext:RegExp = /\w+$/;
			
			for(var i:int = 0;i < zip.getFileCount(); i++)
			{
				var entry:FZipFile = zip.getFileAt(i);
				
				
				var match:Array = entry.filename.match(ext);
				
				var extension:String = "";
				
				if(match)
					extension = match[0];
				
				
				
				extension = extension.toLowerCase();
				
				var data:ByteArray = entry.content;
					
				if(extension == "xml")
				{
					
					new XMLObfuscator(data.readUTFBytes(data.bytesAvailable));
				}
				else
				{
					trace(entry.filename);
					
					//_model.output.addFile(entry.name,data);
				}
			}
		}

	}
}