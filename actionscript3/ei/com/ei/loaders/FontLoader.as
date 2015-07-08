package com.ei.loaders
{
	
	import flash.events.Event;
	import flash.text.Font;
	
	public class FontLoader extends MediaLoader
	{
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function FontLoader(name:String = "")
		{
			super(name);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function get fontName():String
		{
			var reg:RegExp = / (?=\/?) [^\/]*? (?=\.swf)  \/{0} /x;
			
			return request.url.match(reg).toString();
		}
		
		
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
			
			var FontLibrary:Class = event.target.applicationDomain.getDefinition(fontName) as Class;
			
			Font.registerFont(FontLibrary[ fontName ]);

			super.onLoadComplete(event);
			
		}

		
	}
		
}