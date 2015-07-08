package com.ei.psd2.effectResources
{
	import com.ei.psd2.DynVal;
	import com.ei.psd2.display.PSDDisplayObject;
	
	public class Effect
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var resource:DynVal;
		public var displayObject:PSDDisplayObject;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Effect(displayObject:PSDDisplayObject,resource:DynVal)
		{
			this.resource = resource;
			this.displayObject = displayObject;
			
			displayObject.addLayerEffect(this);
			
			
		}


		public function traceRoute(desc:DynVal,tab:String="",index:int = 0):void
			{
				
				trace(tab,index,desc.value,desc.objectType,desc.specialChar,desc.name);
				index++;
				
				
				for each(var child:DynVal in desc.children)
				{
					//if(child.value != null || child.value != undefined)
						//trace(index+":"+tab+child.value);
						
					if(child.children)
						traceRoute(child,tab+"\t",index);
				}
			}
	}
}