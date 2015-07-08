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
	import com.voidelement.images.psd.core.Rect;
	import com.voidelement.images.psd.layer.LayerPixelData;
	import com.voidelement.images.psd.layer.LayerStructure;
	
	import flash.utils.ByteArray;
	
	public class PSDLayerAndMask {
		private var _layers:Array;
		public function get layers():Array { return _layers; }
		
		private var _pixels:Array;
		public function get pixels():Array { return _pixels; }
		
		
		public function PSDLayerAndMask( stream:ByteArray ) {
			var size:uint = stream.readUnsignedInt();
			PSDParser.log("\n\n---- PSD Layer and Mask Information Block ----");
			PSDParser.log("size: " + size );
			
			if ( size > 0 ) {
				var pos:uint = stream.position;
				
				parseLayerInfo( stream );
				parseMaskInfo( stream );
				
				stream.position += pos + size - stream.position;
			}			
		}
		
		private function parseLayerInfo( stream:ByteArray ):void {
			var i:int;
			var size:uint = stream.readUnsignedInt();
			PSDParser.log("Layer Info size: " + size );
			
			var pos:int = stream.position;
			
			if ( size > 0 ) {
				var numLayers:int = Math.abs( stream.readShort() );
				PSDParser.log("Layer Records num: " + numLayers );
				
				_layers = new Array( numLayers );
				_pixels = new Array( numLayers );
				
				for ( i = 0; i < numLayers; ++i ) {
					PSDParser.log("\n-- layer" + i + " --");
					_layers[i] = new LayerStructure( stream );
				}
				
				for ( i = 0; i < numLayers; ++i ) {
					_pixels[i] = new LayerPixelData( layers[i], stream );
				}
			} else {
				_layers = [];
				_pixels = [];
			}
			
//			PSDParser.trace( size + " <-> " + ( stream.position - pos ) );
			stream.position += pos + size - stream.position;
		}
		
		private function parseMaskInfo( stream:ByteArray ):void {
			PSDParser.log("\nMask Info");
			
			var size:uint = stream.readUnsignedInt();
			PSDParser.log("Mask Data size: " + size );
			
			var overlay:uint = stream.readUnsignedShort();
			var color1:uint = stream.readUnsignedInt();
			var color2:uint = stream.readUnsignedInt();
			var opacity:uint = stream.readUnsignedShort();
			var kind:uint = stream.readUnsignedByte();
			
			stream.position += 1; // padding
			
			PSDParser.log("overlay: " + overlay );
			PSDParser.log("color1: " + ("0000000" + color1.toString( 16 ) ).substr( -8 ) );
			PSDParser.log("color2: " + ("0000000" + color2.toString( 16 ) ).substr( -8 ) );
			PSDParser.log("opacity: " + opacity );
			PSDParser.log("kind: " + kind );
		}
	}
}

