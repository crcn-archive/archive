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
	import com.voidelement.images.psd.core.Rect;
	import com.voidelement.images.psd.core.VString;
	
	import flash.utils.ByteArray;
	
	public class Slices {
		private var _bounds:Rect;
		public function get bounds():Rect { return _bounds; }
		
		private var _name:VString;
		public function get name():VString { return _name; }
		
		private var _count:uint;
		public function get count():uint { return _count; }
		
		private var _slices:Array;
		public function get slices():Array { return _slices; }
		
		public function Slices( stream:ByteArray ) {
			parseHeader( stream );
			
			for ( var i:int = 0; i < count; ++i ) {
				PSDParser.log("  [slice" + i + "]");
				slices[i] = new Slice( stream );
			}
		}
		
		private function parseHeader( stream:ByteArray ):void {
			var version:int = stream.readInt();
			
			_bounds = new Rect( stream );
			_name = new VString( stream );
			_count = stream.readUnsignedInt();
			
			_slices = new Array( count );
			
			PSDParser.log("  bounds: " + bounds.left + ", " + bounds.top + ", " + bounds.width + ", " + bounds.height );
			PSDParser.log("  name: " + name );
			PSDParser.log("  count: " + count );
		}
	}
}