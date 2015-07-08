package com.bridge.ui.style
{
	import flash.filters.*;
	import flash.utils.getDefinitionByName;
	
	public class BridgeCSS extends CSS
	{
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BridgeCSS()
		{
			super();
			
			this._symbolTable.setVariable("getDefinitionByName",flash.utils.getDefinitionByName);
			this._symbolTable.setVariable("GlowFilter",GlowFilter);
			this._symbolTable.setVariable("BevelFilter",BevelFilter);
			this._symbolTable.setVariable("DropShadowFilter",DropShadowFilter);
			this._symbolTable.setVariable("BlurFilter",BlurFilter);
			this._symbolTable.setVariable("GradientBevelFilter",GradientBevelFilter);
			
		}

	}
}