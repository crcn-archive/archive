package com.ei.psd2.imageResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.ImageResource;
	
	public class ColorHalftoneInfo extends ImageResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var screens:Array;
		public var curves:Array;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ColorHalftoneInfo(imgRes:ImageResource)
		{
			super(imgRes);
			
			var reader:BinaryPSDReader = imgRes.getDataReader();
			
			this.screens = new Array();
			
			for(var i:int = 0; i < 4; i++)
			{
				this.screens.push(new Screen(reader));
			}
			
			//reader.close();
		}

	}
}
	import com.ei.psd2.BinaryPSDReader;
	

class Screen
{
	public var frequenceValue:Number;
	public var frequenceScale:int;
	public var angle:Number;
	public var shapeCode:int;
	public var accurateScreens:Boolean;
	public var defaultScreens:Boolean;
	
	
	public function Screen(reader:BinaryPSDReader)
	{
		frequenceValue = reader.readSingle();
		frequenceScale = reader.readUint16();
		this.angle = reader.readSingle();
		this.shapeCode = reader.readInt16();
		reader.baseStream.position += 4;
		this.accurateScreens = reader.readBoolean();
		this.defaultScreens = reader.readBoolean();
	}
}