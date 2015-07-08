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


package com.voidelement.images.psd.compression.proto {
	import flash.utils.ByteArray;
	
	public class RLEParser {
		public function RLEParser() {
			
		}
		
		public function unpack( packed:ByteArray ):ByteArray {
			var i:int;
			var n:int;
			var byte:int;
			var unpacked:ByteArray = new ByteArray();
			var count:int;
			
			while ( packed.bytesAvailable ) {
				n = packed.readByte();
				
				if ( n >= 0 ) {
					count = n + 1;
					for ( i = 0; i < count; ++i ) {
						unpacked.writeByte( packed.readByte() );
					}
				} else {
					byte = packed.readByte();
					
					count = 1 - n;
					for ( i = 0; i < count; ++i ) {
						unpacked.writeByte( byte );
					}
				}
			}
			
			return unpacked;
		}
	}
}