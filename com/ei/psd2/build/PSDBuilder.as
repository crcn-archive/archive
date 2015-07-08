package com.ei.psd2.build
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.Layer;
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.PSD;
	import com.ei.psd2.layerResources.TypeToolObject;
	import com.ei.utils.info.ClassInfo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	public class PSDBuilder extends Sprite
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function PSDBuilder(document:PSD)
		{
			var lr:LayerResource;
			var ci:ClassInfo;
			
			var layerDO:DisplayObject;
			
			for each(var layer:Layer in document.layers)
			{
				lr = layer.layerResource;
				
				
				ci = new ClassInfo(lr);
				
				
				trace(layer.name);
				
				switch(ci.name)
				{
					case "TypeToolObject":
						layerDO = createTextField(lr);
					break;
					default:
						//layerDO = createImage(documentlayer.channels);
					break;
				}
				
				
				if(layerDO != null)
				{
					addChild(layerDO);
				}
				
			}
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private 
        //
        //--------------------------------------------------------------------------
        
        //--------------------
		// Text Field Handler
		//--------------------
        
        /**
		 */
		
		private function createTextField(lr:LayerResource):DisplayObject
		{
			var textLayer:TypeToolObject = TypeToolObject(lr);
		
			var text:TextField = new TextField();
			
			
			return text;
		}
		
		//--------------------
		// Display Object Handler
		//--------------------
		
		/**
		 */
		 
		private function createImage(reader:BinaryPSDReader,layer:Layer):DisplayObject
		{
			var r:ByteArray;
        	var g:ByteArray;
        	var b:ByteArray;
        	var a:ByteArray;
        	var n:int;
        	
        	
			for(var i:String in layer.channels)
        	{
        		
        		var iInt:int = int(i);
        		
        		switch(iInt)
				{
					case 0:
						r = layer.channels[i].data;
					break;
					case 1:
						g = layer.channels[i].data;
					break;
					case 2:
						b = layer.channels[i].data;
					break;
					case -1:
						a = layer.channels[i].data;
					break;
				}
        	}
        		
        	n = layer.width * layer.height;
			
			if(r == null)
				r = fillBytes(reader,n,0);
				
			if(g == null)
				g = fillBytes(reader,n,0);
			
			if(b == null)
				b = fillBytes(reader,n,0);
			
			if(a == null)
			{
				a = fillBytes(reader,n,255);
			}
			
			
		
			return makeImage(layer,r,g,b,a);
		
		}
		
		/**
		 */
		
		private function fillBytes(reader:BinaryPSDReader,size:int,value:int):ByteArray
		{
			
			var b:ByteArray = new ByteArray();
			
			if(value != 0)
			{
				var v:int = value;
				
				for(var i:int = 0; i < size; i++)
				{
					b[i] = v;
				}
			}
			
			return b;
		}
		
		
		/**
		 */
		
		private function makeImage(layer:Layer,r:ByteArray,g:ByteArray,b:ByteArray,a:ByteArray):Bitmap
		{
			
			var bd:BitmapData = new BitmapData(layer.width,layer.height,false,0xFFFFFF);
			
			
			var n:int = layer.width * layer.height;
			var j:int = 0;
			
			var ac:int;
			var rc:int;
			var gc:int;
			var bc:int;
			
			var col:int = 0;
			var row:int = 0;
			
			var color:int;

			while(j < n)
			{

				try
				{
					ac = a[j] & 0xff;
					rc = r[j] & 0xff;
					gc = g[j] & 0xff;
					bc = b[j] & 0xff;
					
					
					color = (((((ac << 8) | rc) << 8) | gc) << 8) | bc;
					
					bd.setPixel(row,col,color);
					
					
					if(j > col * layer.width)
					{
					
						col++;
						row = 0;
						
						
					}
					
					row++;
					
					
				}catch(e:*)
				{
					//trace(e);
				}
				
				j++;
			}
			
			return new Bitmap(bd);
		}

	}
}