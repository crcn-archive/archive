package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.ByteArray;
	
	public class TypeToolObject extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _textDescriptor:Descriptor;
        private var _matrix2D:Matrix2D;
        private var _data:ByteArray;

        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function TypeToolObject(areader:BinaryPSDReader)
		{
			
			super(areader);
			
			var reader:BinaryPSDReader = this.dataReader;
			
			
			
			var version:int = reader.readUint16();
			
			_matrix2D = new Matrix2D(reader);
			
			
			var textDescriptorVersion:int = reader.readUint16();
			
			var xTextDescriptorVersion:int = reader.readUint32();
			
			
			_textDescriptor = new Descriptor(reader);
			
			_data = reader.readBytes(reader.bytesToEnd);
			
			
			//this is a test
			
			//s o m e  t e x t
			//trace(reader.readBytes(reader.baseStream.bytesAvailable));
			//peek(reader,100);
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function get displayObject():DisplayObject
		{
			var text:TextField = new TextField();
			
			text.text = _textDescriptor.text;
			text.autoSize = "left";
			
			var format:TextFormat = new TextFormat();
			
			format.size = _textDescriptor.properties.FontSize;
			
			
			text.setTextFormat(format);
			
			//text.
			//trace(_textDescriptor.properties.FontSize);
			//trace(_textDescriptor.properties);
			
			
			
			
			return text;
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	import flash.utils.ByteArray;
	

class Descriptor
{
	public var properties:Object;
	public var text:String;
	
	public function Descriptor(reader:BinaryPSDReader)
	{
		var version:int = reader.readUint32();
		reader.position += 6;
		
		var type:String = reader.readPSDChars(4);
		
		var unknown1:int = reader.readUint32();
		var unknown2:int = reader.readUint32();
		var resType1:String = reader.readPSDChars(4);
		var resType2:String = reader.readPSDChars(4);
		
		text = reader.readPSDUnicodeString();
		
		
		
		while(reader.readByte() != 0x2f);
		
		properties = new Object();
		
		while(true)
		{
			var item:Item = new Item();
			
			
			
			
			var result:* = item.read(reader);
			
			//!!!!FIX ME!!!!
			if(properties[item.id] == undefined)
				properties[item.id] = item.value;
			
			//trace(item.id,item.value);
			
			if(result == false)
				break;
		}
	}
}

class Item
{
	public var id:String;
	public var value:String;
	public var data:String;
	
	public function read(reader:BinaryPSDReader)
	{
		id = "";
		
		while(true)
		{
			var c:int = reader.readByte();
			
			if(c == 0x0a)
				break;
			
			id += String.fromCharCode(c);
			
		}
		
	
		
		var buffer:ByteArray = new ByteArray();
		buffer.length = 255;
		
		var bufPos:int = 0;
		var nearEndCnt:int = 0;
		
		while(true)
		{
			var b:int = reader.readByte();
			
			buffer[bufPos++] = b;
			
			if(b == 0x2f)
				break;
				
			if(b <= 0x00)
			{
				nearEndCnt++;
				
				if(nearEndCnt == 12)
					break;
			}
			else
				nearEndCnt = 0;
		}
		
		if(id.indexOf(" ") > -1)
		{
			var index:int = id.indexOf(" ");
			value = id.substring(index + 1);
			id = id.substring(0,index);
		}
		
		var endPos:int = bufPos - nearEndCnt - 1;
		
		for(var i:int = 0; i < endPos;i++)
		{
			if(buffer[i] != 0x09)
			{
				//trace(buffer,endPos);
				//Endogine.Serialization.ReadableBinary.CreateHexEditorString(buffer, 0, endPos);
				break;
			}
		}
		
		
		return nearEndCnt == 0;
	}
}

class Matrix2D
{
	
	public var M11:Number;
	public var M12:Number;
	public var M13:Number;
	public var M21:Number;
	public var M22:Number;
	public var M23:Number;
	
	public function Matrix2D(reader:BinaryPSDReader)
	{
		M11 = reader.readPSDDouble();
		M12 = reader.readPSDDouble();
		M13 = reader.readPSDDouble();
		M21 = reader.readPSDDouble();
		M22 = reader.readPSDDouble();
		M23 = reader.readPSDDouble();
		
	}
}