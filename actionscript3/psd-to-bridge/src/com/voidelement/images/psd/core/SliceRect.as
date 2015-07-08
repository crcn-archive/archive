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
	
	public class SliceRect {
		private var _top:int;
		public function get top():int { return _top; }
		
		private var _left:int;
		public function get left():int { return _left; }
		
		private var _bottom:int;
		public function get bottom():int { return _bottom; }
		
		private var _right:int;
		public function get right():int { return _right; }
		
		public function get width():int {
			return _right - _left;
		}
		
		public function get height():int {
			return _bottom - _top;
		}
		
		public function SliceRect( stream:ByteArray ) {
			_left = stream.readInt();
			_top = stream.readInt();
			_right = stream.readInt();
			_bottom = stream.readInt();
		}
		
		public function toString():String {
			return left + ", " + top + ", " + width + ", " + height;
		}
	}
}