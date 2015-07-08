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


package com.voidelement.images.psd.layer {
	import com.voidelement.images.psd.compression.ChannelRAWParser;
	import com.voidelement.images.psd.compression.ChannelRLEParser;
	import com.voidelement.images.psd.core.Rect;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	
	public class LayerPixelData {
		private const COMP_RAW:int = 0;
		private const COMP_RLE:int = 1;
		
		private var _channels:Array;
		public function get channels():Array { return _channels; }
		
		private var _image:BitmapData;
		public function get image():BitmapData { return _image; }
		
		
		public function LayerPixelData ( layer:LayerStructure, stream:ByteArray ) {
			var bounds:Rect = layer.bounds;
			var width:int = bounds.width;
			var height:int = bounds.height;
			var numChannels:int = layer.numChannels;
			
			_channels = new Array( numChannels );
				
			for ( var channel:int = 0; channel < numChannels; ++channel ) {
				var compression:int = stream.readShort();
				
				switch ( compression ) {
					case COMP_RAW:
						var raw:ChannelRAWParser = new ChannelRAWParser( width, height, stream );
						channels[ channel ] = raw.data;
						break;
					case COMP_RLE:
						var rle:ChannelRLEParser = new ChannelRLEParser( width, height, stream );
						channels[ channel ] = rle.data;
						break;
					default:
						throw new Error("invalid compression: " + compression );
						break;
				}
			}
			
			switch ( numChannels ) {
				case 3:
					setImage( width, height );
					break;
				case 4:
					setImage32( width, height );
					break;
				default:
					throw new Error("invalid number of channel: " + numChannels );
			}
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
		
		private function setImage32( width:int, height:int ):void {
			_image = new BitmapData( width, height, true, 0x00000000 );

			var a:ByteArray = channels[0];
			var r:ByteArray = channels[1];
			var g:ByteArray = channels[2];
			var b:ByteArray = channels[3];
			
			a.position = 0;
			r.position = 0;
			g.position = 0;
			b.position = 0;
							
			for ( var y:int = 0; y < height; ++y ) {
				for ( var x:int = 0; x < width; ++x ) {
					var argb:uint = a.readUnsignedByte() << 24 | r.readUnsignedByte() << 16 | g.readUnsignedByte() << 8 | b.readUnsignedByte();
					image.setPixel32( x, y, argb );
				}
			}
		}
		
		public function getImage():BitmapData {
			return image;
		}
	}
}
