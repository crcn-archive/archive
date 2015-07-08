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
	
	public class Rect {
		private var _top:int;
		public function get top():int { return _top; }
		public function set top( value:int ):void { _top = value; }
		
		private var _left:int;
		public function get left():int { return _left; }
		public function set left( value:int ):void { _left = value; }
		
		private var _bottom:int;
		public function get bottom():int { return _bottom; }
		public function set bottom( value:int ):void { _bottom = value; }
		
		private var _right:int;
		public function get right():int { return _right; }
		public function set right( value:int ):void { _right = value; }
		
		public function get width():int {
			return _right - _left;
		}
		
		public function get height():int {
			return _bottom - _top;
		}
		
		
		public function Rect( stream:ByteArray ) {
			_top = stream.readInt();
			_left = stream.readInt();
			_bottom = stream.readInt();
			_right = stream.readInt();
		}
		
		public function toString():String {
			return left + ", " + top + ", " + width + ", " + height;
		}
	}
}