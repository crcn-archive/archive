package com.bridge.modules
{
	import com.bridge.core.EvaluableModule;
	import com.bridge.core.ModuleType;
	import com.ei.utils.*;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.FileReferenceList;
	import flash.net.URLRequest;
	
	public class FileUploadModule extends EvaluableModule
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        
        private var _handler:String;

		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function FileUploadModule(ns:String = "")
		{
			super(ns);
			
			_handler = "";
			
			nodeEvaluator.addHandler("browse",browse);
			nodeEvaluator.addHandler("service",service);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		override public function get moduleType():Array
		{
			return [ModuleType.NODE_NAME];
		}

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
  		/**
  		 */
  		
  		private function browse():void
  		{
  			
  			//var type:Array = evaluatedNode.attributes.type;
  			
  			var fileRefList:FileReferenceList = new FileReferenceList();
  			
  			//funny stuff happens when adding an event listener to a method and not a function
			fileRefList.addEventListener(Event.SELECT, selectHandler);
			fileRefList.browse();


			function selectHandler(event:Event):void
			{
				var req:URLRequest = new URLRequest(_handler);
  				var file:FileReference;
  				var files:FileReferenceList = FileReferenceList(event.target);
  				var selectedFileArray:Array = files.fileList;
  			
  				for(var i:int = 0; i < selectedFileArray.length; i++)
  				{
  					file = FileReference(selectedFileArray[i]);

  					file.addEventListener(Event.COMPLETE,completeHandler);
  					try
  					{
  						file.upload(req);
  					
  					}
  					catch(error:Error)
  					{
  						trace("unable to upload files");
  					}
  				}
  				function completeHandler(event:Event):void
				{
    				trace("uploaded");
				}
  			}
   
			
  		}

  		
  		/**
  		 */
  		
  		private function service():void
  		{
  			_handler = evaluatedNode.attributes.handler;
  		}
	}
}