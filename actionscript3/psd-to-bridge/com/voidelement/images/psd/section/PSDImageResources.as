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


package com.voidelement.images.psd.section {
	import com.voidelement.images.psd.PSDParser;
	import com.voidelement.images.psd.core.PStringB2;
	import com.voidelement.images.psd.resources.*;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	
	public class PSDImageResources {
		private var resources:Dictionary = new Dictionary();
		
		public function PSDImageResources( stream:ByteArray ) {
			var size:uint = stream.readUnsignedInt();
			var readed:uint = 0;
			
			PSDParser.log("\n\n---- PSD Image Resources Block ----");
			PSDParser.log("size: " + size );
			
			while ( readed < size ) {
				var type:String = stream.readUTFBytes( 4 );
				if ( type != "8BIM") {
					throw new Error("invalid osType: " + type );
				}
				readed += 4;
				
				var id:int = stream.readUnsignedShort();
				PSDParser.log("\nid: " + ("000" + id.toString( 16 ) ).substr( -4 ) );
				readed += 2;
				
				var name:PStringB2 = new PStringB2( stream );
				readed += name.length;
				PSDParser.log("name: " + name.value );
				
				var sizeResource:uint = stream.readUnsignedInt();
				readed += 4;
				PSDParser.log("size: " + sizeResource );
				
				readResource( sizeResource, id, stream );
				readed += sizeResource;
				
				if ( sizeResource % 2 == 1 ) {
					stream.readByte();
					readed++;
				}
			}
		}
		
		private function readResource( size:int, id:int, stream:ByteArray ):void {
			var current:uint = stream.position;
			
			switch ( id ) {
				case 0x03e8:
					// Photoshop v2.0
					PSDParser.log("channels, rows, columns, depth, and mode");
					stream.position += size;
					break;
				case 0x03e9:
					PSDParser.log("Optional. Macintosh print manager information");
					stream.position += size;
					break;
				case 0x03eb:
					// Photoshop v2.0
					PSDParser.log("Indexed color table");
					stream.position += size;
 					break;
 				case 0x03ed:
 					PSDParser.log("Resolution information");
 					resources[ id ] = new ResolutionInfo( stream );
//					stream.position += size;
 					break;
 				case 0x03ee:
 					PSDParser.log("Alpha channel names");
					stream.position += size;
 					break;
 				case 0x03ef:
 					PSDParser.log("Display information for each channel");
					stream.position += size;
 					break;
 				case 0x03f0:
 					PSDParser.log("Optional. Pascal-format caption string");
					stream.position += size;
 					break;
 				case 0x03f1:
 					PSDParser.log("Fixed-point border width, border units");
					stream.position += size;
 					break;
 				case 0x03f2:
 					// not documented
 					PSDParser.log("Background color");
					stream.position += size;
 					break;
 				case 0x03f3:
 					// Print Flags
 					PSDParser.log("Print Flags");
 					resources[ id ] = new PrintFlags( stream );
//					stream.position += size;
 					break;
 				case 0x03f4:
 					// not documented
 					PSDParser.log("Gray-scale and halftoning information");
					stream.position += size;
 					break;
 				case 0x03f5:
 					// not documented
 					PSDParser.log("Color halftoning information");
					stream.position += size;
 					break;
 				case 0x03f6:
 					// not documented
 					PSDParser.log("Duotone halftoning information");
					stream.position += size;
 					break;
 				case 0x03f7:
 					// not documented
 					PSDParser.log("Gray-scale and multichannel transfer function");
					stream.position += size;
 					break;
 				case 0x03f8:
 					// not documented
 					PSDParser.log("Color transfer functions");
					stream.position += size;
 					break;
 				case 0x03f9:
 					// not documented
 					PSDParser.log("Duotone transfer functions");
					stream.position += size;
 					break;
 				case 0x03fa:
 					// not documented
 					PSDParser.log("Duotone image information");
					stream.position += size;
 					break;
 				case 0x03fb:
 					PSDParser.log("Effective black and white value for dot range");
					stream.position += size;
 					break;
 				case 0x03fc:
 					// not documented
 					PSDParser.log("Obsolete Photoshop Tag1");
					stream.position += size;
 					break;
 				case 0x03fd:
 					// not documented
 					PSDParser.log("EPS options");
					stream.position += size;
 					break;
 				case 0x03fe:
 					PSDParser.log("Quick Mask channel ID, flag for mask initially empty");
					stream.position += size;
 					break;
 				case 0x03ff:
 					PSDParser.log("Obsolete Photoshop Tag2");
					stream.position += size;
 					break;
 				case 0x0400:
 					PSDParser.log("Index of target layer");
 					PSDParser.log("  index: " + stream.readUnsignedShort() );
//					stream.position += size;
 					break;
 				case 0x0401:
 					PSDParser.log("Working path");
					stream.position += size;
 					break;
 				case 0x0402:
 					PSDParser.log("Layers group info, group ID for dragging groups");
					stream.position += size;
 					break;
 				case 0x0403:
 					PSDParser.log("Obsolete Photoshop Tag3");
					stream.position += size;
 					break;
 				case 0x0404:
 					PSDParser.log("IPTC-NAA record");
 					resources[ id ] = new IPTCData( stream );
//					stream.position += size;
 					break;
 				case 0x0405:
 					// not documented
 					PSDParser.log("Image mode for raw-format files");
					stream.position += size;
 					break;
 				case 0x0406:
 					// not documented
 					PSDParser.log("JPEG quality");
					stream.position += size;
 					break;
 				case 0x0408:
 					// Grid and Guides Info
 					PSDParser.log("Grid and Guides Info");
 					stream.position += size;
 					break;
 				case 0x0409:
 					// Photoshop BGR Thumbnail
 					PSDParser.log("Photoshop BGR Thumbnail");
 					stream.position += size;
 					break;
 				case 0x040a:
 					// Copyright Flag
 					PSDParser.log("Copyright Flag");
 					resources[ id ] = new CopyrightFlag( stream );
//					stream.position += size;
 					break;
 				case 0x040b:
 					// URL
 					PSDParser.log("URL");
 					stream.position += size;
 					break;
 				case 0x040c:
 					// Thumbnail Resource
 					PSDParser.log("Thumbnail Resource");
 					PSDParser.log("  signature: " + stream.readUnsignedInt().toString( 16 ) );
// 					stream.position += size;
 					break;
 				case 0x040d:
 					// Global Angle
 					PSDParser.log("Global Angle");
 					stream.position += size;
 					break;
 				case 0x040e:
 					// Color Samplers Resource
 					PSDParser.log("Color Samplers Resource");
 					stream.position += size;
 					break;
 				case 0x040f:
 					// ICC Profile
 					PSDParser.log("ICC Profile");
 					resources[ id ] = new ICCProfile( stream );
// 					stream.position += size;
 					break;
 				case 0x0410:
 					// Watermark
 					PSDParser.log("Watermark");
 					stream.position += size;
 					break;
 				case 0x0411:
 					// ICC Untagged
 					PSDParser.log("ICC Untagged");
 					stream.position += size;
 					break;
 				case 0x0412:
 					// Effects Visible
 					PSDParser.log("Effects Visible");
 					stream.position += size;
 					break;
 				case 0x0413:
 					// Spot Halftone
 					PSDParser.log("Spot Halftone");
 					stream.position += size;
 					break;
 				case 0x0414:
 					// Document specific IDs
 					PSDParser.log("Document specific IDs");
 					stream.position += size;
 					break;
 				case 0x0415:
 					// Unicode Alpha Names
 					PSDParser.log("Unicode Alpha Names");
 					stream.position += size;
 					break;
 				case 0x0416:
 					// Indexed Color Table Count
 					PSDParser.log("Indexed Color Table count");
 					stream.position += size;
 					break;
 				case 0x0417:
 					// Transparent Index
 					PSDParser.log("Transparent Index");
 					stream.position += size;
 					break;
 				case 0x0419:
 					// Global Altitude
 					PSDParser.log("Global Altitude");
 					stream.position += size;
 					break;
 				case 0x041a:
					PSDParser.log("Slices");
					resources[ id ] = new Slices( stream );
					break;
				case 0x041b:
					// Workflow URL
					PSDParser.log("Workflow URL");
					stream.position += size;
 					break;
 				case 0x041c:
 					// Jump To XPEP
 					PSDParser.log("Jump To XPEP");
 					stream.position += size;
 					break;
 				case 0x041d:
 					// Alpha IDs
 					PSDParser.log("Alpha IDs");
 					stream.position += size;
 					break;
 				case 0x041e:
 					// URL List
 					PSDParser.log("URL List");
 					stream.position += size;
 					break;
 				case 0x0421:
 					// Version Info
 					PSDParser.log("Version Info");
 					stream.position += size;
 					break;
 				case 0x0422:
 					// EXIF Info
 					PSDParser.log("EXIF Info");
 					stream.position += size;
 					break;
 				case 0x0424:
 					// XMP
 					PSDParser.log("XMP");
 					stream.position += size;
 					break;
 				case 0x0bb7:
 					// not documented
 					PSDParser.log("Clipping pathname");
					stream.position += size;
 					break;
 				case 0x2710:
 					// Print Flags Info
 					PSDParser.log("Print flags Info");
 					resources[ id ] = new PrintFlagsInfo( stream );
//					stream.position += size;
 					break;
				default:
					if ( ( 0x07d0 <= id ) && ( id <= 0x0bb6 ) ) {
						PSDParser.log("Saved path information: " + ("000" + id.toString( 16 ) ).substr( -4 ) );
						resources[ id ] = new PathInfo( stream );
					} else {
						PSDParser.log("Unknown: " + ("000" + id.toString( 16 ) ).substr( -4 ) );
						stream.position += size;
					}
			}
			
			stream.position += current + size - stream.position;
		}
		
		public function getResource( type:int ):Object {
			return resources[ type ];
		}
	}
}