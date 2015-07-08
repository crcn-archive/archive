package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	import flash.utils.ByteArray;
	
	public class TypeTool extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _fontInfo:Array;
        private var _data:ByteArray;
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function TypeTool(areader:BinaryPSDReader)
		{
			super(areader);
			//new TypeToolObject(areader);
			
			
			
			
			
			var reader:BinaryPSDReader = this.dataReader;
			
			
			
			var version:int = reader.readUint16();
			
			
			
			for(var i:int = 0; i < 6; i++)
			{
				reader.readPSDDouble();
				
			}
			
			var fontVersion:int = reader.readUint16();
			var faceCount:int  = reader.readUint16();
			
			
			
			_fontInfo = new Array();
			
			for(var i:int = 0; i < faceCount; i++)
			{
				_fontInfo.push(new FontInfo(reader));
			}
			
			
			var styleCount:int = reader.readUint16();
			
			
			for(var i:int = 0; i < styleCount; i++)
			{
				
				var mark:int = reader.readUint16();
				var faceMark:int = reader.readUint16();
				var size:int = reader.readUint32();
				var tracking:int = reader.readUint32();
				var kerning:int = reader.readUint32();
				var leading:int = reader.readUint32();
				var baseShift:int = reader.readUint32();
				
				
				var autoKern:int = reader.readByte();
				
				var extra:int = 0;
				
				if(version <= 5)
					extra = reader.readByte();
				
				
				var rotate:int = reader.readByte();
				
			
			}
			
			
			
			
			
			
			var type:int = reader.readUint16();
			var scalingFactor:int = reader.readUint32();
			var characterCount:int = reader.readUint32();
			
			var horizontalPlacement:int = reader.readUint32();
			var verticalPlacement:int = reader.readUint32();
			
			var selectStart:int = reader.readUint32();
			var selectEnd:int = reader.readUint32();
			
			var lineCount:int = reader.readUint16();
			
			
			for(var i:int = 0; i < lineCount; i++)
			{
				var characterCountLine:int = reader.readUint32();
				var orientation:int = reader.readUint16();
				var alignment:int = reader.readUint16();
				
				var doubleByteChar:int = reader.readUint16();
				var style:int = reader.readUint16();
			}
			
			var colorSpace:int = reader.readUint16();
			
			for(var i:int = 0; i < 4; i++)
			{
				reader.readUint16();
			}
			
			var antiAlias:int = reader.readByte();
			
			
			
			
		}
		
		public function peek(reader:BinaryPSDReader,length:Number):void
		{
			
			reader.position -= length;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------

	}
}

import com.ei.psd2.BinaryPSDReader;
	

class FontInfo
{
	
	//--------------------------------------------------------------------------
   	//
    //  Public Variablies
    //
    //--------------------------------------------------------------------------
    
    public var mark:int;
    public var fontType:int;
    public var fontName:String;
    public var fontFamilyName:String;
    public var fontStyleName:String;
    public var script:int;
    public var designVectors:Array;
    
    //--------------------------------------------------------------------------
   	//
    //  Constructor
    //
    //--------------------------------------------------------------------------
    
    /**
     */
     
	public function FontInfo(reader:BinaryPSDReader)
	{
		mark = reader.readUint16();
		fontType = reader.readUint32();
		fontName = reader.readPascalString();
		fontFamilyName = reader.readPascalString();
		fontStyleName = reader.readPascalString();
		script = reader.readUint16();
		

		var numDesignAxesVectors = reader.readUint16();
		
		designVectors = new Array();
		
		for(var i:int = 0; i < numDesignAxesVectors; i++)
		{
			designVectors.push(reader.readUint32());
		}
		
	}
}