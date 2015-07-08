package com.ei.psd2.effectResources
{
	import com.ei.psd2.ColorControl;
	import com.ei.psd2.DynVal;
	import com.ei.psd2.display.PSDDisplayObject;
	
	public class OuterGlowEffect extends Effect
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var color:int;
		public var alpha:Number;
		public var technique:String;
		public var blur:Number;
		public var noise:Number;
		public var chokeMatte:Number;
		public var shadingNoise:Number;
		public var enabled:Boolean;
		public var blendMode:String;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function OuterGlowEffect(displayObject:PSDDisplayObject,resource:DynVal)
		{
			super(displayObject,resource);	
			
			super.resource = resource;
			
		//	this.traceRoute(resource);
			
			
			var colorChildren:Array = resource.children[2].children;
			
			this.enabled = resource.children[0].value;
			
			if(!enabled)
				return;
			
			//trace(colorChildren[0],colorChildren[1],colorChildren[2],"GO");
			this.color 		  = ColorControl.fromRGB2(colorChildren[0].value,colorChildren[1].value,colorChildren[2].value);
			this.alpha 		  = resource.children[3].value / 100;
			this.technique    = resource.children[4].value;
			this.chokeMatte   = resource.children[5].value;
			this.blur 		  = resource.children[6].value;
			this.noise		  = resource.children[7].value;
			this.shadingNoise = resource.children[8].value;
			
		}

	}
}