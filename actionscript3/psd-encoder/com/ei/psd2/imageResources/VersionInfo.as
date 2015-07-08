package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class VersionInfo extends ImageResource
	{
		
        public var Version:uint = 1;
        
        public var HasRealMergedData:Boolean;
        public var WriterName:String;
        public var ReaderName:String;
        
        public var FileVersion:uint;

        public function VersionInfo(imgRes:ImageResource)
        {
        	super(imgRes);
        	
            var reader:BinaryPSDReader = imgRes.getDataReader();
            this.Version = reader.readUint32();
            this.HasRealMergedData = reader.readBoolean();
            this.WriterName = reader.readPSDUnicodeString();
            this.ReaderName = reader.readPSDUnicodeString();
            this.FileVersion = reader.readUint32();
        }

	}
}