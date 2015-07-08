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
	
	public class ResolutionInfo {
		private var _hRes:uint;
		public function get hRes():uint { return _hRes; }
		
		private var _hResUnit:uint;
		public function get hResUnit():uint { return _hResUnit; }
		
		private var _widthUnit:uint;
		public function get widthUnit():uint { return _widthUnit; }
		
		private var _vRes:uint;
		public function get vRes():uint { return _vRes; }
		
		private var _vResUnit:uint;
		public function get vResUnit():uint { return _vResUnit; }
		
		private var _heightUnit:uint;
		public function get heightUnit():uint { return _heightUnit; }
		
		
		public function ResolutionInfo( stream:ByteArray ) {
			_hRes = stream.readUnsignedInt();
			_hResUnit = stream.readUnsignedShort();
			_widthUnit = stream.readUnsignedShort();
			_vRes = stream.readUnsignedInt();
			_vResUnit = stream.readUnsignedShort();
			_heightUnit = stream.readUnsignedShort();
			
			PSDParser.log("  hRes: " + hRes );
			PSDParser.log("  hResUnit: " + hResUnit + " [ pixel/" + ["inch", "cm"][hResUnit-1] + " ]");
			PSDParser.log("  widthUnit: " + widthUnit + " [ " + ["in", "cm", "pt", "picas", "columns"][widthUnit-1] + " ]");
			PSDParser.log("  vRes: " + vRes );
			PSDParser.log("  vResUnit: " + vResUnit + " [ pixel/" + ["inch", "cm"][vResUnit-1] + " ]");
			PSDParser.log("  heightUnit: " + heightUnit + " [ " + ["in", "cm", "pt", "picas", "columns"][heightUnit-1] + " ]");
		}
	}
}