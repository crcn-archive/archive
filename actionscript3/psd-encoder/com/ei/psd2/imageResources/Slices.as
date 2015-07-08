package com.ei.psd2.imageResources
{
	import com.ei.psd2.DynVal;
	import com.ei.psd2.ImageResource;
	import com.ei.psd2.BinaryPSDReader;
	import flash.geom.Rectangle;
	
	public class Slices extends ImageResource
	{
		
        public var version:uint;
        public var rectangle:Rectangle;
        
        public var slicesName:String;
        public var sliceList:Array;

        public var values:Array;

        

        public function Slices(imgRes:ImageResource)
        {
        	super(imgRes);
        	
        	
        	
            var reader:BinaryPSDReader = imgRes.getDataReader();
            this.version = reader.readUint32();
            this.rectangle = reader.readPSDRectangle(); // new Rectangle(reader).ToERectangle();
            this.slicesName = reader.readPSDUnicodeString();

            var cnt:int = reader.readUint32();
            
            sliceList = new Array();
            
            for (var i:int = 0; i < cnt; i++)
                sliceList.push(new Slice(reader));

            var unknown1:int = reader.readUint32() as int;
            var unknown2:int = reader.readUint32() as int;
            var unknown3:uint = reader.readUint16();
            var unknown4:String = DynVal.readSpecialString(reader);
            var unknown5:int = reader.readUint32() as int;

            this.values = new Array();
            
            while (reader.bytesToEnd > 0)
            {
                var val:DynVal = DynVal.readValue(reader, false);
                this.values.push(val);
            }
            //this.Values = DynVal.readValues(reader);
            //this.Data = reader.readBytes((int)reader.BytesToEnd);
           
        }

	}
}
	import com.ei.psd2.BinaryPSDReader;
	import flash.geom.Rectangle;
	

class Slice
{
    
    public var ID:uint;
    
    public var GroupID:uint;
    
    public var Origin:uint;
    
    public var Name:String;
    
    public var Type:uint;
    public var rectangle:Rectangle;
    
    public var URL:String;
    public var Target:String;
    public var Message:String;
    public var AltTag:String;
    
    public var CellTextIsHtml:Boolean;
    public var CellText:String;
    
    public var HorizontalAlignment:uint;
    
    public var VerticalAlignment:uint;
    public var color:uint;

    
    public function Slice(reader:BinaryPSDReader)
    {
        this.ID = reader.readUint32();
        this.GroupID = reader.readUint32();
        this.Origin = reader.readUint32();
        this.Name = reader.readPSDUnicodeString();
        this.Type = reader.readUint32();
        this.rectangle = reader.readPSDRectangle(); //NOT CORRECT!! use reversed AS version
        //this.rectangle = reader.readPSDRectangleReversed(); //new Rectangle(reader).ToERectangle();
        this.URL = reader.readPSDUnicodeString();
        this.Target = reader.readPSDUnicodeString();
        this.Message = reader.readPSDUnicodeString();
        this.AltTag = reader.readPSDUnicodeString();
        this.CellTextIsHtml = reader.readBoolean();
        this.CellText = reader.readPSDUnicodeString();
        this.HorizontalAlignment = reader.readUint32();
        this.VerticalAlignment = reader.readUint32();
        this.color = reader.readPSDColor(8, true);

        //TODO: same info seems to follow in another format!
    }
}