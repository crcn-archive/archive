
      package com.ei.net {

       

          import flash.display.Bitmap;
          import flash.geom.Rectangle;
          import flash.utils.ByteArray;

          public class BitmapBin extends ByteArray {

              public function BitmapBin( bitmap:Bitmap, filename:String ) {
   
                  while (filename.length < 32) {
                   filename += " ";
  
                  }
                  
  				
                  var pix:ByteArray = bitmap.bitmapData.getPixels(bitmap.bitmapData.rect);
  
                  writeShort(bitmap.width);
  
                  writeShort(bitmap.height);
  
                  writeShort(bitmap.bitmapData.transparent ? 1 : 0);
  
                  writeUTFBytes(filename.toLowerCase());
  
                  writeBytes(pix, 0, pix.bytesAvailable);
  
                              compress();
  
              }
 
       
  
          }
  
       
  
      } 