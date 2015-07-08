/**
 * com.voidelement.images.psd.PSDParser  Class for ActionScript 3.0 
 *  
 * @author       Copyright (c) 2007 munegon
 * @version      0.2
 *  
 * @link         http://www.voidelement.com/
 * @link         http://void.heteml.jp/blog/
 *  
 * @link         http://blog.alternativagame.com/en/2007/07/09/parser-psd-formata/
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


package com.voidelement.images.psd {
	import com.voidelement.images.psd.section.*;
	
	import flash.utils.ByteArray;
	
	
	public class PSDParser {
		private static var _verbose:Boolean = false;
		private static function get verbose():Boolean { return _verbose; }
		private static function set verbose( value:Boolean ):void { _verbose = value; }
		
		private var _header:PSDFileHeader;
		public function get header():PSDFileHeader { return _header; }
		
		private var _colorMode:PSDColorMode;
		public function get colorMode():PSDColorMode { return _colorMode; }
		
		private var _imageResources:PSDImageResources;
		public function get imageResources():PSDImageResources { return _imageResources; }
		
		private var _layerAndMask:PSDLayerAndMask;
		public function get layerAndMask():PSDLayerAndMask { return _layerAndMask; }
		
		private var _imageData:PSDImageData;
		public function get imageData():PSDImageData { return _imageData; }
		
		
		public function PSDParser( stream:ByteArray ) {
			_header = new PSDFileHeader( stream );
			_colorMode = new PSDColorMode( stream );
			_imageResources = new PSDImageResources( stream );
			_layerAndMask = new PSDLayerAndMask( stream );
			_imageData = new PSDImageData( header, stream );
		}
		
		public static function log( message:String ):void {
			if ( verbose ) {
				trace( message );
			}
		}
	}
}