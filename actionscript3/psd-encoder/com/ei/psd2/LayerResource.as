package com.ei.psd2
{
	import com.ei.psd2.display.PSDDisplayObject;
	import com.ei.utils.info.ClassInfo;
	
	import flash.display.DisplayObject;
	import flash.utils.ByteArray;
	
	public class LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Singletons
        //
        //--------------------------------------------------------------------------
        
        private static var _resourceType:Object;
       
        //--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _tag:String;

	 	//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var data:ByteArray;
        
        
        
        //--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function LayerResource(reader:BinaryPSDReader)
		{
			
			
			var settingLength:int = reader.readUint32();
			
			
			data = reader.readBytes(settingLength);
			
			if(!(this is EffectBase))
				reader.jumpToEvenNthByte(2);
				
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function get dataReader():BinaryPSDReader
		{
			var pos:Number = data.position;
			var byteArray:ByteArray = new ByteArray();
			data.readBytes(byteArray,0,data.length);
			data.position = pos;
			byteArray.position = pos;
			
			return new BinaryPSDReader(byteArray);
		}
		
		
		/**
		 */
		
		public function get displayObject():DisplayObject
		{
			return null;
		}
		
		/**
		 */
		 
		public function set tag(value:String):void
		{
			_tag = value;
		}
		
		public function get tag():String
		{
			if(_tag == null)
			{
				_tag = this.extractTag();
				
			}
			
			return _tag;
		}
		
        //--------------------------------------------------------------------------
   	    //
        //  Public static methods
        //
        //--------------------------------------------------------------------------
        
        public static function readLayerResources(reader:BinaryPSDReader,type:Class):Array
        {
        	prepare();
        	
        	var result:Array = new Array();
        	
        	
        	while(true)
        	{
        		
        		var res:LayerResource = LayerResource.readLayerResource(reader,type);
        		
        		
        		if(res == null)
        			break;
        		
        			
        		result.push(res);
        	}
        	
        	return result;
        }
        
		public static function readLayerResource(reader:BinaryPSDReader,inheritsType:*):LayerResource
		{
			
			
			var posBefore:int = reader.position;
			var sHeader:String = reader.readPSDChars(4);
			
			if(sHeader != "8BIM")
			{
				reader.position = posBefore;
				return null;
			}
			
			var tag:String = reader.readPSDChars(4);
			
			
			var type:* = null;
			

			var usingDefault:Boolean = false;
			
			//trace(LayerType[tag],tag);
			
			//trace(reader.position,reader.baseStream.length,LayerType[tag]);
			
			
			if(LayerType[tag])
			{
				var cls:Class = LayerType[tag];
				
				var inst:LayerResource =  new cls(reader);
				
				
				inst.tag = tag;
				
				
				
				
			}
			else
			{
				
				
				inst = new LayerResource(reader);
				inst.tag = tag;
				
				
			}
			
			//trace(inst,tag);
			
			return inst;
		}
		
		public static function create(type:Class):Object
		{
			return new type();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		public function getFlatResources(resources:Object):Array
		{
			if(resources.Count == 0)
				return null;
			
			var res:Array = new Array();
			
			for each(var resource:LayerResource in resources.Values)
			{
				res.push(resource);
			}
			
			return res;
		}
		
		/**
		 */
		
		public function draw(displayObject:PSDDisplayObject):void
		{
			
		}
		

		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		protected function extractTag()
		{
			//AttributeCollection attribs = TypeDescriptor.GetAttributes(this.GetType());
            //DescriptionAttribute attr = (DescriptionAttribute)attribs[typeof(DescriptionAttribute)];
            //return attr.Description;
            
            var info:ClassInfo = new ClassInfo(this);
            return info.name;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Static Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		private static function prepare():void
		{
			//if(_resourceTypes != null)
			//	return;
				
				
			//_resourceTypes = new Object();
			
			
			//LOOK AS CS CODE
		}

	}
}