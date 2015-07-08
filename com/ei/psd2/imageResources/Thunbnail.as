package com.ei.psd2.imageResources
{
	import com.ei.psd2.ImageResource;
	
	import flash.display.Bitmap;
	
	public class Thunbnail extends ImageResource
	{
		
		public var Format:int;
        
		public var Width:int;
        
        public var Height:int;
        
        public var WidthBytes:int;
        
        public var Size:int;
        
        public var CompressedSize:int;
        
        public var BitPerPixel:int;
        
        public var Planes:int;

        var bitmap:Bitmap;
        
        
        

        /*public override ResourceIDs[] AcceptedResourceIDs
        {
            get { return new ResourceIDs[] { ResourceIDs.Thumbnail1, ResourceIDs.Thumbnail2 }; }
        }*/

     
        public Thumbnail(imgRes:ImageResource)
        {
        	super(imgRes);
        	
            var reade:BinaryPSDReader = imgRes.GetDataReader();

            //m_bThumbnailFilled = true;

            this.Format = reader.readInt32();
            this.Width = reader.readInt32();
            this.Height = reader.readInt32();
            this.WidthBytes = reader.readInt32(); //padded row bytes (
            this.Size = reader.readInt32(); //Total size widthbytes * height * planes
            this.CompressedSize = reader.readInt32(); //used for consistancy check
            this.BitPerPixel = reader.readInt16();
            this.Planes = reader.readInt16();

            int numBytes = (int)reader.BytesToEnd;
            byte[] buffer = reader.readBytes(numBytes);

            if (this.ID == 1033)
            {
                // BGR
                for (int n = 0; n < numBytes - 2; n += 3)
                {
                    byte tmp = buffer[n + 2];
                    buffer[n + 2] = buffer[n];
                    buffer[n] = tmp;
                }
            }
            System.IO.MemoryStream stream = new System.IO.MemoryStream(buffer);
            this.Bitmap = new System.Drawing.Bitmap(stream);

            reader.Close();
        }

	}
}