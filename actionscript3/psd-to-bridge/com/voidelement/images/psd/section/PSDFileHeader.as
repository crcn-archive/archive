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
	
	import flash.utils.ByteArray;
	
	public class PSDFileHeader {
		private static const FILE_ID:String = "8BPS";
		
		private static const MODE_BITMAP:int = 0;
		private static const MODE_GRAYSCALE:int = 1;
		private static const MODE_INDEXED:int = 2;
		private static const MODE_RGB:int = 3;
		private static const MODE_CMYK:int = 4;
		private static const MODE_MULTICHANNEL:int = 5;
		private static const MODE_DUOTONE:int = 6;
		private static const MODE_LAB:int = 7;
		
				
		// File ID "8BPS"
		private var _signature:String;
		public function get signature():String { return _signature; }
		
		// Version number, always 1
		private var _version:int;
		public function get version():int { return _version; }
		
		// Number of color channels ( 1 - 24 )
		private var _channel:int;
		public function get channel():int { return _channel; }
		
		// Height of image in pixels ( 1 - 30000 )
		private var _rows:int;
		public function get rows():int { return _rows; }
		
		// Width of image in pixels ( 1 - 30000 )
		private var _columns:int;
		public function get columns():int { return _columns; }
		
		// Number of bits per channel
		private var _depth:int;
		public function get depth():int { return _depth; }
		
		// Color mode
		private var _mode:int;
		public function get mode():int { return _mode; }
		
		
		public function PSDFileHeader( stream:ByteArray ) {
			_signature = stream.readUTFBytes( 4 );
			
			if ( signature != FILE_ID ) {
				throw new Error("invalid signature: " + signature );
			}
			
			_version = stream.readUnsignedShort();
			
			// Reserved, must be zeroed
			stream.position += 6;
			
			_channel = stream.readUnsignedShort();
			_rows = stream.readInt();
			_columns = stream.readInt();
			_depth = stream.readUnsignedShort();
			_mode = stream.readUnsignedShort();
			
			PSDParser.log("---- PSD HEADER ----");
			PSDParser.log("version: " + version );
			PSDParser.log("channnel: " + channel );
			PSDParser.log("rows: " + rows );
			PSDParser.log("columns: " + columns );
			PSDParser.log("depth: " + depth );
			PSDParser.log("mode: " + mode );
		}
	}
}