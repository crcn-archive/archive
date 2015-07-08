package com.bridgeo.core
{
	import flash.utils.ByteArray;
	
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipOutput;
	
	public class BridgeOutput
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _zipOut:ZipOutput;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BridgeOutput()
		{
			clear();
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function clear():void
		{
			_zipOut = new ZipOutput();
		}
		
		/**
		 */
		public function addFile(name:String,wt:Object):void
		{
			
			var ze:ZipEntry = new ZipEntry(name);
			_zipOut.putNextEntry(ze);
			
			if(wt is String)
			{
				var data:ByteArray = new ByteArray();
				data.writeUTFBytes(String(wt));
				_zipOut.write(data);
				
			}
			else
			{
				_zipOut.write(wt as ByteArray);
			}
			
			
			_zipOut.closeEntry();
		}
		
		/**
		 */
		 
		public function addEntry(entry:ZipEntry):void
		{
			_zipOut.putNextEntry(entry);
			_zipOut.closeEntry();
		}
		
		/**
		 */
		public function get byteArray():ByteArray
		{
			return _zipOut.byteArray;
		}

	}
}