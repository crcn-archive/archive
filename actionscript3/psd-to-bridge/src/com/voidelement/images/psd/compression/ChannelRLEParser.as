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


package com.voidelement.images.psd.compression {
	import com.voidelement.images.psd.compression.proto.RLEParser;
	
	import flash.utils.ByteArray;
	
	public class ChannelRLEParser extends RLEParser {
		private var _data:ByteArray = new ByteArray();
		public function get data():ByteArray { return _data; }
		
		public function ChannelRLEParser( width:int, height:int, stream:ByteArray ) {
			var lines:Array = new Array( height );
			var i:int;
			
			for ( i = 0; i < height; ++i ) {
				lines[i] = stream.readUnsignedShort();
			}
			
			for ( i = 0; i < height; ++i ) {
				var line:ByteArray = new ByteArray();
				stream.readBytes( line, 0, lines[i] );
				data.writeBytes( unpack( line ) );
			}
		}
	}
}