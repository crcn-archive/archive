package com.ei.psd2
{
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	
	public class DynVal
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _fourCCs:Dictionary;

        
        //--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var name:String;
		public var unicodeName:String;
		public var value:*;
		public var children:Array;
		public static var fourCCs:Object;
		public var objectType:String;
		public var specialChar:String;
		
		[Embed(source="com/ei/psd2/FourCC.txt",mimeType="application/octet-stream")]
		public static var _fourCCFile:Class;
	
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function DynVal(reader:BinaryPSDReader = null,aDescriptor:Boolean = false)
		{
			
			children = new Array();
			
			
			if(reader == null)
				return;
			
			
				
			if(aDescriptor)
			{
				var version:int = reader.readUint32();
				var unknown:String = reader.readBytes(6).toString();
				
			}
			
			
			
			
			
			specialChar = readSpecialString(reader);
			
			objectType = getMeaningOfFourCC(specialChar);
			
			
			children   = DynVal.readValues(reader);
			
			
			
			
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Static Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		 public static function readSpecialString(reader:BinaryPSDReader):String
		 {
		 	var length:int = reader.readUint32();
		 	
		 	
		 	
		 	if(length == 0)
		 		length = 4;
		 	
		 	return new String(reader.readPSDChars(length));
		 }
		 
		 public static function readValues(r:BinaryPSDReader):Array
		 {
		 	var numValues:int = r.readUint32();
		 	
		 	
		 	var values:Array = new Array();
		 	
		 	for(var i:int = 0; i < numValues; i++)
		 	{
		 		var vt:DynVal = readValue(r,false);
		 		
		 		if(vt != null)
		 			values.push(vt);
		 	}
		 	
		 	return values;
		 }
		 
		 public static function readValue(r:BinaryPSDReader,ignoreName:Boolean):DynVal
		 {
		 	var vt:DynVal = new DynVal();
		 	
		 	if(!ignoreName)
		 	{
		 		vt.name = getMeaningOfFourCC(readSpecialString(r));
		 	}
		 		
		 	var type:String = r.readPSDChars(4);
		 	
		 	switch(type)
		 	{
		 		case "tdta":
		 			//  vt.Value = Endogine.Serialization.ReadableBinary.CreateHexEditorString(r.ReadBytes(9));
		 			vt.value = r.readBytes(9);
		 			vt.children = new Array();
		 			
		 			while(true)
		 			{
		 				var child:DynVal = new DynVal();
		 				vt.children.push(child);
		 				if(child.readIdtaItem(r) == false)
		 					break;
		 			}
		 		break;
		 		case "Objc":
		 		case "GlbO":
		 			
		 			var uniName:String = r.readPSDUnicodeString();
		 			
		 			
		 			vt = new DynVal(r,false);
		 			
		 			if(uniName.length > 0)
		 				vt.unicodeName = uniName;
		 				
		 		break;
		 		case "VlLs":
		 			vt.children = new Array();
		 			var numValues:int = r.readUint32();
		 			
		 			for(var i:int = 0; i < numValues; i++)
		 			{
		 				var ob:DynVal = readValue(r,true);
		 				
		 				
		 				if(ob != null)
		 					vt.children.push(ob);
		 				
		 			} 
		 		break;
		 		case "doub":
		 			vt.value = r.readPSDDouble();
		 			
		 			
		 		break;
		 		case "UntF":
		 			var tst:String = getMeaningOfFourCC(r.readPSDChars(4));
		 			var d:int = r.readPSDDouble();
		 			tst += ": "+d;
		 			vt.value = d;
		 			
		 		break;
		 		case "enum":
		 			var namesp:String = readSpecialString(r);
		 			
		 			var item:String = readSpecialString(r);
		 			
		 			vt.value = getMeaningOfFourCC(namesp)+"."+getMeaningOfFourCC(item);
		 			
		 			
		 			
		 		break;
		 		case "long":
		 			vt.value = r.readInt32();
		 			
		 		break;
		 		case "bool":
		 			vt.value = r.readBoolean();
		 		break;
		 		case "TEXT":
		 			vt.value = r.readPSDUnicodeString();
		 		break;
		 		default:
		 			throw new Error("Unknown type: "+ type);
		 		break;
		 	}
		 	
		 	
		 	if(vt.value == null && vt.children == null)
		 	{
		 	
		 		return null;
		 		
		 	}
		 	
		 	
		 	return vt;
		 }
		 
		 /**
		 */
		
		public function readIdtaItem(r:BinaryPSDReader):Boolean
		{
			trace("CHECK CODE @ DynVal::readIdtaItem");
			name = "";
			
			while(r.bytesToEnd > 0)
			{
				var c:String = r.readChar();
				if(c == String(0x0a))
					break;
					
				name += c;
			}
			
			var buffer:ByteArray = new ByteArray();
			
			var bufPos:int = 0;
			var nearEndCnt:int = 0;
			
			while(r.bytesToEnd > 0)
			{
				var b:int = r.readByte();
				
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
			var index:int = name.indexOf(" ");
			if(index > -1)
			{
				var val:String = name.substring(index+1);
				
				if(val.charAt(0) == "(" && val.charAt(val.length -1) == ")")
				{
					var unicode:Boolean = true;
					
					for(var i:int = 0; i < val.length; i++)
					{
						if(val[i] != 0 && val[i] <= 31)
						{
							unicode = false;
							break;
						}
					}
					
					if(unicode)
					{
						var uniVal:String = "";
						for(var i:int = 2; i < val.length; i+= 2)
						{
							uniVal += val[i];
							
						}
						
						val = uniVal;
					}
					else
					{
						var tmp:ByteArray = new ByteArray;
						var i:int = 0; 
						for each(var char:String in val)
						{
							tmp[i++] = char;
						}
						
						val = val.replace("\r\n"," ");
					}
				}
				
				value = val;
				
				name = name.replace(index,""); //name.remove(index);
			}
			
			var endPos:int = bufPos - nearEndCnt - 1;
			
			for(var i:int = 0; i < endPos; i++)
			{
				if(buffer[i] != 0x09)
				{
					 //TODO: this.Data = Endogine.Serialization.ReadableBinary.CreateHexEditorString(buffer, 0, endPos);
					break;
				}
			}
			
			return nearEndCnt == 0 && r.bytesToEnd > 0;
		}
		 
		 /**
		  */
		 
		 public static function getMeaningOfFourCC(fourCC:String):String
		 {
		 	if(fourCCs == null)
		 	{
		 		loadFourCC();
		 	}
		 	
		 	if(fourCC.length != 4)
		 		return fourCC;
		 	
		 	
		 	if(fourCCs[fourCC])
		 	{
		 		
		 		return fourCCs[fourCC];
		 	}
		 	
		 	return fourCC;
		 }
		 
		 /**
		  */
		 
		 public static function loadFourCC():void
		 {
		 	//trace("LOADING FOUR CC");
		 	var prefixes:Array = ["Key","Enum","Event","Class","Type"];
		 	
		 	var cls:Class = DynVal._fourCCFile;
		 	
		 	var contents:String = new String(new cls());
		 	
		 	fourCCs = new Object();
		 	
		 	
		 	
		 	var lines:Array = contents.split("\n");
		 	
		 	for each(var line:String in lines)
		 	{
		 		var items:Array = line.split("\t");
		 		
		 		
		 		if(items.length <= 1)
		 			continue;
		 		
		 		if(items[1].length ==0)
		 			continue;
		 		
		 		var name:String = items[0].substring(2);

		 		for each(var prefix:String in prefixes)
		 		{
		 			if(name.search(prefix) == 0) //name.StartsWith(prefix)
		 			{
		 				
		 				name = name.substring(prefix.length);
		 				
		 				break;
		 			}
		 			
		 			
		 			
		 		}
		 		
		 		
		 		//trace(items[1],name);
		 		
		 		fourCCs[items[1]] = name; //items[1].PadRight(4, ' ')
		 		
		 		
		 	}
		 	
		 	
		 }
		  

	}
}