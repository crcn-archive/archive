/**
 * com.voidelement.images.psd.PSDParser  Class for ActionScript 3.0 
 *  
 * @author       Copyright (c) 2007 munegon
 * @version      0.2
 *  
 * @link         http://www.voidelement.com/
 * @link         http://void.heteml.jp/blog/
 * 
 * Licensed under the Apache License, Version 2.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at 
 *  
 * http://www.apache.org/licenses/LICENSE-2.0 
 *  
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,  
 * either express or implied. See the License for the specific language 
 * governing permissions and limitations under the License. 
 */


package com.voidelement.images.psd.section {
	import com.voidelement.images.psd.PSDParser;
	import com.voidelement.images.psd.compression.ImageRAWParser;
	import com.voidelement.images.psd.compression.ImageRLEParser;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	public class PSDImageData {
		private const COMP_RAW:int = 0;
		private const COMP_RLE:int = 1;
		
		private var _compression:uint;
		public function get compression():uint { return _compression; }
		
		private var _channels:Array;
		public function get channels():Array { return _channels; }
		
		private var _image:BitmapData;
		public function get image():BitmapData { return _image; }
		
				
		public function PSDImageData( header:PSDFileHeader, stream:ByteArray ) {
			var width:int = header.columns;
			var height:int = header.rows;
			var numChannels:int = header.channel;
			
			_compression = stream.readUnsignedShort();
			
			PSDParser.log("\n\n---- PSD Image Data ----");
			PSDParser.log("compression: " + compression );
			
			switch ( compression ) {
				case COMP_RAW:
					var raw:ImageRAWParser = new ImageRAWParser( numChannels, width, height, stream );
					_channels = raw.channelsData;
					break;
				case COMP_RLE:
					var rle:ImageRLEParser = new ImageRLEParser( numChannels, width, height, stream );
					_channels = rle.channelsData;
					break;
				default:
					throw new Error("invalid compression: " + compression );
					break;
			}
			
			setImage( width, height );
		}
		
		private function setImage( width:int, height:int ):void {
			_image = new BitmapData( width, height, false, 0x000000 );
			
			var r:ByteArray = channels[0];
			var g:ByteArray = channels[1];
			var b:ByteArray = channels[2];
			
			r.position = 0;
			g.position = 0;
			b.position = 0;
			
			for ( var y:int = 0; y < height; ++y ) {
				for ( var x:int = 0; x < width; ++x ) {
					var rgb:uint = r.readUnsignedByte() << 16 | g.readUnsignedByte() << 8 | b.readUnsignedByte();
					image.setPixel( x, y, rgb );
				}
			}
		}
		
		public function getImage():BitmapData {
			return image;
		}
	}
}