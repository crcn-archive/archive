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
	import com.voidelement.images.psd.core.SliceRect;
	import com.voidelement.images.psd.core.VString;
	
	import flash.utils.ByteArray;
	
	public class Slice {
		private var _id:uint;
		public function get id():uint { return _id; }
		
		private var _groupID:uint;
		public function get groupID():uint { return _groupID; }
		
		private var _origin:uint;
		public function get origin():uint { return _origin; }
		
		private var _name:VString;
		public function get name():VString { return _name; }
		
		private var _type:uint;
		public function get type():uint { return _type; }
		
		private var _rect:SliceRect;
		public function get rect():SliceRect { return _rect; }
		
		private var _url:VString;
		public function get url():VString { return _url; }
		
		private var _target:VString;
		public function get target():VString { return _target; }
		
		private var _message:VString;
		public function get message():VString { return _message; }
		
		private var _allTag:VString;
		public function get allTag():VString { return _allTag; }
		
		private var _cellIsHtml:Boolean;
		public function get cellIsHtml():Boolean { return _cellIsHtml; }
		
		private var _cellText:VString;
		public function get cellText():VString { return _cellText; }
		
		private var _hAlign:uint;
		public function get hAlign():uint { return _hAlign; }
		
		private var _vAlign:uint;
		public function get vAlign():uint { return _vAlign; }
		
		private var _aColor:uint;
		public function get aColor():uint { return _aColor; }
		
		private var _rColor:uint;
		public function get rColor():uint { return _rColor; }
		
		private var _gColor:uint;
		public function get gColor():uint { return _gColor; }
		
		private var _bColor:uint;
		public function get bColor():uint { return _bColor; }
		
		
		public function Slice( stream:ByteArray ) {
			_id = stream.readUnsignedInt();
			_groupID = stream.readUnsignedInt();
			_origin = stream.readUnsignedInt();
			_name = new VString( stream );
			_type = stream.readUnsignedInt();
			_rect = new SliceRect( stream );
			_url = new VString( stream );
			_target = new VString( stream );
			_message = new VString( stream );
			_allTag = new VString( stream );
			
			_cellIsHtml = stream.readBoolean();
			_cellText = new VString( stream );
			
			_hAlign = stream.readUnsignedInt();
			_vAlign = stream.readUnsignedInt();
			
			_aColor = stream.readUnsignedByte();
			_rColor = stream.readUnsignedByte();
			_gColor = stream.readUnsignedByte();
			_bColor = stream.readUnsignedByte();
			
			
			PSDParser.log("    id: " + id );
			PSDParser.log("    groupID: " + groupID );
			PSDParser.log("    origin: " + origin );
			PSDParser.log("    name: " + name );
			PSDParser.log("    type: " + type );
			PSDParser.log("    rect: " + rect );
			PSDParser.log("    url: " + url );
			PSDParser.log("    target: " + target );
			PSDParser.log("    message: " + message );
			PSDParser.log("    allTag: " + allTag );
			
			PSDParser.log("    cellIsHtml: " + cellIsHtml );
			PSDParser.log("    cellText: " + cellText );
			
			PSDParser.log("    hAlign: " + hAlign );
			PSDParser.log("    vAlign: " + vAlign );
			
			PSDParser.log("    aColor: " + aColor );
			PSDParser.log("    rColor: " + rColor );
			PSDParser.log("    gColor: " + gColor );
			PSDParser.log("    bColor: " + bColor );
		}
	}
}