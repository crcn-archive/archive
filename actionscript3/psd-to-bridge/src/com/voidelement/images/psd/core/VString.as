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


package com.voidelement.images.psd.core {
	import flash.utils.ByteArray;
	
	public class VString {
		private var _length:uint;
		public function get length():uint { return _length; }
		
		private var _value:String;
		public function get value():String { return _value; }
		
		public function VString( stream:ByteArray ) {
			var size:uint = stream.readUnsignedInt() << 1;
			
			_length = size + 4;
			_value = ( size > 0 ) ? stream.readMultiByte( size, "shift-jis") : "";
		}
		
		public function toString():String {
			return value;
		}
	}
}