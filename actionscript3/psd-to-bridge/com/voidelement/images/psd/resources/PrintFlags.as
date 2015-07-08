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
	
	public class PrintFlags {
		private var _labels:int;
		public function get labels():int { return _labels; }
		
		private var _crop:int;
		public function get crop():int { return _crop; }
		
		private var _colorBars:int;
		public function get colorBars():int { return _colorBars; }
		
		private var _registration:int;
		public function get registration():int { return _registration; }
		
		private var _negative:int;
		public function get negative():int { return _negative; }
		
		private var _flip:int;
		public function get flip():int { return _flip; }
		
		private var _interpolate:int;
		public function get interpolate():int { return _interpolate; }
		
		private var _caption:int;
		public function get caption():int { return _caption; }
		
		
		public function PrintFlags( stream:ByteArray ) {
			_labels = stream.readUnsignedByte();
			_crop = stream.readUnsignedByte();
			_colorBars = stream.readUnsignedByte();
			_registration = stream.readUnsignedByte();
			_negative = stream.readUnsignedByte();
			_flip = stream.readUnsignedByte();
			_interpolate = stream.readUnsignedByte();
			_caption = stream.readUnsignedByte();
			stream.readUnsignedByte();
			
			PSDParser.log("  labels: " + labels );
			PSDParser.log("  crop: " + crop );
			PSDParser.log("  colorBars: " + colorBars );
			PSDParser.log("  registration: " + registration );
			PSDParser.log("  negative: " + negative );
			PSDParser.log("  flip: " + flip );
			PSDParser.log("  interpolate: " + interpolate );
			PSDParser.log("  caption: " + caption );
		}
	}
}