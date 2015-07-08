package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.Layer;
	
	import flash.display.*;
	import flash.geom.*;
	import flash.utils.ByteArray;
	
	public class BitmapObject
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _displayObject:DisplayObject;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function BitmapObject(layer:Layer)
		{
			
			
			var channels:ColorChannels = new ColorChannels(layer);
		
			_displayObject = channels.bitmap;
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function get displayObject():DisplayObject
		{
			return _displayObject;
		}
	}
	
}
	import com.ei.psd2.BinaryPSDReader;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	import com.ei.psd2.Layer;
	import flash.display.Bitmap;
	import com.ei.psd2.Channel;
	


class ColorChannels
{
	
	public var r:ByteArray;
	public var g:ByteArray;
	public var b:ByteArray;
	public var a:ByteArray;
	public var width:Number;
	public var height:Number;
	
	public var bitmap:Bitmap;
	
	
	public function ColorChannels(layer:Layer)
	{
		var n:int;
		
		width = layer.width;
		height = layer.height;
		
		for each(var channel:Channel in layer.channels)
        {
        	
        	switch(channel.usage)
			{
				case 0:
					r = channel.data;
				break;
				case 1:
					g = channel.data;
				break;
				case 2:
					b = channel.data;
				break;
				case -1:
					a = channel.data;
				break;
			}
        }
        
 
        if(r == null)
			r = fillBytes(n,0);
			
		if(g == null)
			g = fillBytes(n,0);
		
		if(b == null)
			b = fillBytes(n,0);
		
		if(a == null)
		{
			a = fillBytes(n,255);
		}
		
		
		bitmap = makeImage(layer,r,g,b,a);
		
		
	}
	
	/**
		 */
		
		private function makeImage(layer:Layer,r:ByteArray,g:ByteArray,b:ByteArray,a:ByteArray):Bitmap
		{
			
			
			var bd:BitmapData = new BitmapData(layer.width,layer.height,true,0x000000);
			
			
			var n:int = layer.width * layer.height;
			var j:int = 0;
			
			var ac:int;
			var rc:int;
			var gc:int;
			var bc:int;
			
			var col:int = 0;
			var row:int = 0;
			
			var color:int;
			
			
			
			for(var y:int = 0; y < layer.height; y++)
			{
				for(var x:int = 0; x < layer.width; x++)
				{
					
					
					ac = a[j] & 0xff;
					rc = r[j] & 0xff;
					gc = g[j] & 0xff;
					bc = b[j] & 0xff;
					
					
					color = (((((ac << 8) | rc) << 8) | gc) << 8) | bc;
					
					bd.setPixel32(x,y,color);
					
					
					j++;
				}
			}
			
			return new Bitmap(bd);
		}
	
	
	
	/**
	 */
		
	private function fillBytes(size:int,value:int):ByteArray
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
}
