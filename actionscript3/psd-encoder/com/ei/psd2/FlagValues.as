package com.ei.psd2
{
	public class FlagValues
	{
		 public static const TransparencyProtected:int = 1;
         public static const Invisible:int = 2;
         public static const Obsolete:int = 4;
         public static const Bit4Used:int = 8; //1 for Photoshop 5.0 and later, tells if bit 4 has useful information
         public static const PixelDataIrrelevant:int = 16; //pixel data irrelevant to appearance of document
	}
}