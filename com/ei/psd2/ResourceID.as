package com.ei.psd2
{
	import com.ei.psd2.imageResources.*;
	
	public class ResourceID
	{
		
		private static const IDs:Object = 
		
		{
			
		
			Undefined:[0,null],
			MacPrintInfo:[1001,null],
			ResolutionInfo:[1005,ResolutionInfo],
			AlphaChannelNames:[1006,AlphaChannelNames],
			DisplayInfo:[1007,DisplayInfo],
			Caption:[1008,null],
			BorderInfo:[1009,null],
			BgColor:[1010,null],
			PrintFlags:[1011,PrintFlags],
			MultiChannelHalftoneInfo:[1012,null],
			ColorHalftoneInfo:[1013,ColorHalftoneInfo],
			DuotoneHalftoneInfo:[1014,null],
			MultiChannelTransferFunctions:[1015,null],
			ColorTransferFunctions:[1016,ColorTransferFunctions],
			DuotoneTransferFunctions:[1017,null],
			DuotoneImageInfo:[1018,null],
			BlackWhiteRange:[1019,null],
			EPSOptions:[1021,null],
			QuickMaskInfo:[1022,null],
			LayerStateInfo:[1024,LayerStateInfo],
			WorkingPathUnsaved:[1025,null],
			LayersGroupInfo:[1026,LayersGroupInfo],
			IPTC_NAA:[1028,IPTC_NAA],
			RawFormatImageMode:[1029,null],
			JPEGQuality:[1030,null],
			GridGuidesInfo:[1032,null],
			Thumbnail1:[1033,null],
			CopyrightInfo:[1034,CopyrightInfo],
			URL:[1035,URL],
			Thumbnail2:[1036,null],
			GlobalAngle:[1037,GlobalAngle],
			ColorSamplers:[1038,null],
			ICCProfile:[1039,null],
			Watermark:[1040,null],
			ICCUntagged:[1041,ICCUntagged],
			EffectsVisible:[1042,null],
			SpotHalftone:[1043,null],
			DocumentSpecificIds:[1044,DocumentSpecificIds],
			UnicodeAlphaNames:[1045,UnicodeAlphaNames],
			IndexedColorTableCount:[1046,null],
			TransparentIndex:[1047,null],
			GlobalAltitude:[1049,GlobalAltitude],
			Slices:[1050,Slices],
			WorkflowURL:[1051,null],
			JumpToXPEP:[1052,null],
			AlphaIdentifiers:[1053,AlphaIdentifiers],
			URLList:[1054,URLList],
			VersionInfo:[1057,VersionInfo],
			Unknown4:[1058,null],
			XMLInfo:[1060,XMLInfo],
			Unknown:[1061,null],
			Unknown2:[1062,null],
			Unknown3:[1064,null],
			PathInfo:[2000,PathInfo],
			ClippingPathName:[2999,null],
			PrintFlagsInfo:[10000,PrintFlagsInfo]
		}
		
		
		
		
		public static function hasID(id:int):Boolean
		{
			for each(var item:Array in IDs)
			{
				if(item[0] == id)
					return true;
			}
			
			return false;
		}
		
		public static function getID(name:String):int
		{
			return IDs[name][0];
		}
		
		public static function getClass(id:int):Class
		{
			for each(var item:Array in IDs)
			{
				
				if(item[0] == id)
					return item[1];
			}
			
			return null;
		}
		
		
		
	}
}