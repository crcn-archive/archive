package com.ei.psd2
{
	import flash.utils.ByteArray;
	
	public class ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var id:uint;
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variablies
        //
        //--------------------------------------------------------------------------
        
        private var _name:String;
        private var _data:ByteArray;
        private var _resID:int;
        private static var _resourceTypes:Object;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function ImageResource(imgRes:* = null)
		{
			if(imgRes == null)
				return;
			
			
			if(imgRes is ImageResource)
			{
				id   = imgRes.id;
				_name = imgRes.name;
				
				return;
			}
			
			if(imgRes is BinaryPSDReader)
			{
				id 				      = imgRes.readUint16();
				_name				  = imgRes.readPascalString();
				var settingLength:int = imgRes.readUint32();
				_data 				  = imgRes.readBytes(settingLength);
				
				
				if(imgRes.position % 2 == 1)
					imgRes.readByte();
					
				//_name = imgRes.
			}
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
		/**
		 */
		 
		public function get name():String
		{
			return _name;
		}
		
		/**
		 */
		
		public function getDataReader():BinaryPSDReader
		{
			var newReader:ByteArray = new ByteArray();
			var oldPos:int = _data.position;
			
			_data.position = 0;
			_data.readBytes(newReader);
			_data.position = oldPos;
			
			return new BinaryPSDReader(_data);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Static Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		 
		
		public static function readImageResources(reader:BinaryPSDReader):Array
		{
			var result:Array = new Array();
			var nBefore:int;
			var settingSig:String;
			
			
			while(true)
			{
				nBefore = reader.position;
				settingSig = reader.readPSDChars(4);
				
				
				if(settingSig != "8BIM")
				{
					reader.position = nBefore;
					break;
				}
				
				var imgRes:ImageResource = new ImageResource(reader);
				
				var resID:int = imgRes.id;
				
				
				if(ResourceID.hasID(resID)  || true)
				{
					trace("Image::condition var resId "+resID);
					if(imgRes.id > 2000 && imgRes.id <= 2999)
					{
						resID = ResourceID.getID("PathInfo");
					}
				}
				
				
				var cls:Class = ResourceID.getClass(resID);
				
				
				if(cls)
				{
					imgRes = new cls();
				}
				
				result.push(imgRes);
				
				
			}	
			
			
			return result;
				
			
			
		}
      
        public static function prepare():void
        {
        	if(_resourceTypes != null)
        		return;
        	
        	
        	_resourceTypes = new Object();
        	
        	
        	
        	for each(var i in ResourceID)
        	{
        		_resourceTypes[i] = "type";
        		
        	}
        	
        }
       
		
		

	}
}