package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.LayerResource;
	
	public class Patterns extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		
		public var records:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Patterns(reader:BinaryPSDReader)
		{
			super(reader);
			
			return;
			
			var r:BinaryPSDReader = this.dataReader;
			
		
			r.position = 0;
			
			records = new Array();
			
			
			//while(r.bytesToEnd > 0)
			{
				records.push(new Pattern(r));
			}
			
			data = null;
			
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	import flash.geom.Point;
	import com.ei.psd2.ColorModes;
	import flash.utils.ByteArray;
	

class Pattern
        {

            public var ColorMode:int;
            
            private var loc:Point; //TODO: crashes on Xml serialization
            
            public var Name:String;
            
            public var Id:String;
            public var PaletteForXml:String;
            public var ImageData:String;
            

            public function Pattern(r:BinaryPSDReader)
            {
                var startPos:int = r.baseStream.position;
				
                var length:uint = r.readUint32();
                var version:uint = r.readUint32();
                this.ColorMode = r.readUint32();
                
                
                
                this.loc = new Point(r.readUint16(), r.readUint16()); //TODO: signed??
                this.Name = r.readPSDUnicodeString();
                this.Id = r.readPascalString(); //?
                
                
                return;
                //trace(ColorMode,length,version,loc,Name,Id,this.ColorMode == ColorModes.Indexed);
                
                if (this.ColorMode == ColorModes.Indexed)
                {
                    this.PaletteForXml = "";
                    for (var i:int = 0; i < 256; i++)
                    {
                        var s:String = "";
                        for (var j:int = 0; j < 3; j++)
                            s += r.readByte().toString();
                        this.PaletteForXml += s;
                    }
                }
              // trace(length,r.baseStream.position,startPos);
                
               //	var imageData:ByteArray = r.readBytes((length - r.baseStream.position - startPos) as int);
               	
                //TODO: what is the format?
                //System.IO.MemoryStream stream = new System.IO.MemoryStream(imageData);
                //System.Drawing.Bitmap bmp = new System.Drawing.Bitmap(stream);
                //this.ImageData = Endogine.Serialization.readableBinary.CreateHexEditorString(imageData);

                //TODO: length isn't correct! By 6 bytes always??
                
                
                //NOTE: the byte length is 20... go to end
                
                //if (r.bytesToEnd < 20)
                    r.baseStream.position = r.baseStream.length;
            }
        }