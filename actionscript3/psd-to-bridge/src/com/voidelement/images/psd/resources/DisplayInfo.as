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
	
	public class DisplayInfo {
		private var _colorSpace:int;
		public function get colorSpace():int { return _colorSpace; }
		
		private var _color:uint;
		public function get color():uint { return _color; }
		
		private var _opacity:uint;
		public function get opacity():uint { return _opacity; }
		
		private var _kind:uint;
		public function get kind():uint { return _kind; }
		
				
		public function DisplayInfo( stream:ByteArray ) {
			_colorSpace = stream.readUnsignedShort();
			_color = stream.readUnsignedShort();
			_opacity = stream.readUnsignedShort();
			_kind = stream.readUnsignedByte();
			
			stream.readUnsignedByte(); // padding
			
			PSDParser.log("  colorSpace: " + colorSpace );
			PSDParser.log("  color: " + color );
			PSDParser.log("  opacity: " + opacity );
			PSDParser.log("  kind: " + kind );
		}
	}
}