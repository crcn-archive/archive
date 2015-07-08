package com.ei.net
{
	import flash.net.FileFilter;
	import flash.net.FileReferenceList;
	
	public class FileManager
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _fileRef:FileReferenceList;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function FileManager()
		{
			_fileRef = new FileReferenceList();
			
		}
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function browser(fileType:Array = null):Boolean
		{
			_fileRef.browse(fileType);
			_fileRef.fileList
			return false;
		}
	}
}