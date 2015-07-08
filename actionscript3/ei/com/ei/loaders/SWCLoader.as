package com.ei.loaders
{
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.URLLoaderDataFormat;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import nochump.util.zip.ZipFile;
	
	public class SWCLoader extends TextLoader
	{
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function SWCLoader(name:String = "")
		{
			super(name);
			
			_loader.dataFormat = URLLoaderDataFormat.BINARY;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
	
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		/**
		*/
		override public function load(url:String):void
		{
			
			
			super.load(url);
		}
		
		//-----------------------------------------------------------
		// 
		// Protected Methods
		//
		//-----------------------------------------------------------
		
		/**
		*/
		
		override protected function onLoadComplete(event:Event):void
		{
			
			_ev = event;
			trace("WHAT THE FUCK?");
			
						
			var zip:ZipFile = new ZipFile(event.target.data);
			
			for(var i:int = 0; i < zip.entries.length; i++)
			{
				if(zip.entries[i] == "library.swf")
				{
					var swf:ByteArray = zip.getInput(zip.entries[i]);
					
					var loader:Loader = new Loader();
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
					loader.loadBytes(swf);
					
					break;
				}
			}
			
			
			
			
		}
		
		private var _ev:Event;
		
		/**
		 */
		
		private function onComplete(event:Event):void
		{
			
			event.target.removeEventListener(event.type,onComplete);
			
			super.onLoadComplete(_ev);
		}

		
	}
		
}