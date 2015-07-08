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
	import com.voidelement.images.psd.PSDParser;
	import com.voidelement.images.psd.core.PStringB4;
	import com.voidelement.images.psd.core.Rect;
	
	import flash.utils.ByteArray;
	
	public class LayerStructure {
		private var _bounds:Rect;
		public function get bounds():Rect { return _bounds; }
		
		private var _numChannels:uint;
		public function get numChannels():uint { return _numChannels; }
		
		private var _info:Array;
		public function get info():Array { return _info; }
		
		private var _signature:String;
		public function get signature():String { return _signature; }
		
		private var _blendModeKey:String;
		public function get blendModeKey():String { return _blendModeKey; }
		
		private var _opacity:uint;
		public function get opacity():uint { return _opacity; }
		
		private var _clipping:uint;
		public function get clipping():uint { return _clipping; }
		
		private var _flags:uint;
		public function get flags():uint { return _flags; }
		
		private var _ranges:Array;
		public function get ranges():Array { return _ranges; }
		
		private var _name:PStringB4;
		public function get name():PStringB4 { return _name; }
		
		private var _extra:ByteArray;
		public function get extra():ByteArray { return _extra; }
		
		
		public function LayerStructure( stream:ByteArray ) {
			_bounds = new Rect( stream );
			_numChannels = stream.readUnsignedShort();
			_info = new Array( numChannels );
			
			for ( var i:uint = 0; i < numChannels; ++i ) {
				info[i] = new ChannelLengthInfo( stream );
			}
			
			_signature = stream.readUTFBytes( 4 );
			
			if ( signature != "8BIM") {
				throw new Error("invalid signature: " + signature );
			}
			
			_blendModeKey = stream.readUTFBytes( 4 );
			_opacity = stream.readUnsignedByte();
			_clipping = stream.readUnsignedByte();
			_flags = stream.readUnsignedByte();
			
			stream.position += 1; // padding
			
			PSDParser.log("blendMode: " + blendModeKey );
			PSDParser.log("opacity: " + opacity );
			PSDParser.log("clipping: " + clipping );
			PSDParser.log("flags: " + ("0000000" + flags.toString( 2 ) ).substr( -8 ) );
			
			parseExtraData( stream );
		}
		
		private function parseExtraData( stream:ByteArray ):void {
			var size:uint = stream.readUnsignedInt();
			PSDParser.log("Extra Data size: " + size );
			
			if ( size > 0 ) {
				var pos:uint = stream.position;
				
				parseLayerMaskData( stream );
				parseLayerBlendingRanges( stream );
				
				_name = new PStringB4( stream );
				PSDParser.log("name: " + name );
				
				PSDParser.log("extra available: " + ( pos + size - stream.position ) );
				stream.position += pos + size - stream.position;
			}
		}
		
		private function parseLayerMaskData( stream:ByteArray ):void {
			var size:uint = stream.readUnsignedInt();
			PSDParser.log("Layer Mask Data size: " + size );
			
			if ( size > 0 ) {
				var bounds:Rect = new Rect( stream );
				var defaultColor:uint = stream.readUnsignedByte();
				var flags:uint = stream.readUnsignedByte();
				
				stream.position += 2; // padding
				
				PSDParser.log("  bounds: " + bounds.toString() );
				PSDParser.log("  defaultColor: " + defaultColor );
				PSDParser.log("  flags: " + ("0000000" + flags.toString( 2 ) ).substr( -8 ) ); 
			}
		}
		
		private function parseLayerBlendingRanges( stream:ByteArray ):void {
			var size:uint = stream.readUnsignedInt();
			PSDParser.log("Layer Blending Ranges size: " + size );
			
			if ( size > 0 ) {
				var pos:uint = stream.position;
				
				var grayBlendSource:uint = stream.readUnsignedInt();
				var grayBlendDest:uint = stream.readUnsignedInt();
				
				PSDParser.log("  grayBlendSource: " + ("0000000" + grayBlendSource.toString( 16 ) ).substr( -8 ) );
				PSDParser.log("  grayBlendDest: " + ("0000000" + grayBlendDest.toString( 16 ) ).substr( -8 ) );
				
				_ranges = new Array( numChannels );
				
				for ( var i:uint = 0; i < numChannels; ++i ) {
					ranges[i] = new ChannelSourceRange( stream );
					PSDParser.log("  " + ["red", "green", "blue", "alpha"][i] + "BlendSource: " + ("0000000" + ranges[i].source.toString( 16 ) ).substr( -8 ) );
					PSDParser.log("  " + ["red", "green", "blue", "alpha"][i] + "BlendDest: " + ("0000000" + ranges[i].dest.toString( 16 ) ).substr( -8 ) );
				}
			}
		}
	}
}