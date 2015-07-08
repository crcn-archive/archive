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


package com.voidelement.images.psd.resources {
	import com.voidelement.images.psd.PSDParser;
	
	import flash.utils.ByteArray;
	
	public class PrintFlagsInfo {
		private var _version:uint;
		public function get version():uint { return _version; }
		
		private var _crop:uint;
		public function get crop():uint { return _crop; }
		
		private var _field:uint;
		public function get field():uint { return _field; }
		
		private var _bleedWidth:uint;
		public function get bleedWidth():uint { return _bleedWidth; }
		
		private var _bleedScale:uint;
		public function get bleedScale():uint { return _bleedScale; }
		
		
		public function PrintFlagsInfo( stream:ByteArray ) {
			_version = stream.readUnsignedShort();
			_crop = stream.readUnsignedByte();
			_field = stream.readUnsignedByte();
			_bleedWidth = stream.readUnsignedInt();
			_bleedScale = stream.readUnsignedShort();
			
			PSDParser.log("  version: " + version );
			PSDParser.log("  crop: " + crop );
			PSDParser.log("  field: " + field );
			PSDParser.log("  bleedWidth: " + bleedWidth );
			PSDParser.log("  bleedScale: " + bleedScale );
		}
	}
}