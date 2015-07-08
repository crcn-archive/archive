package com.ei.psd2.layerResources
{
	import com.ei.psd2.BinaryPSDReader;
	import com.ei.psd2.DynVal;
	import com.ei.psd2.EffectType;
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.display.PSDDisplayObject;
	
	public class ObjectBasedEffects extends LayerResource
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var descriptor:DynVal;
		public var values:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function ObjectBasedEffects(reader:BinaryPSDReader)
		{
			super(reader);
			
			var r:BinaryPSDReader = this.dataReader;
			
			r.readUint32();
			
			descriptor = new DynVal(r,true);
			
			/*traceRoute(descriptor);
			
			
			
			function traceRoute(desc:DynVal,tab:String="",index:int = 0):void
			{
				trace(tab,index,desc.value,desc.name,desc.objectType,desc.unicodeName);
				
				index++;
				
				for each(var child:DynVal in desc.children)
				{
					//if(child.value != null || child.value != undefined)
						//trace(index+":"+tab+child.value);
						
					if(child.children)
						traceRoute(child,tab+"\t",index);
				}
			}*/
			
			
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		override public function draw(displayObject:PSDDisplayObject):void
		{
			//trace("DRAW FIRST");
			for each(var child:DynVal in descriptor.children)
			{
				var cls:Class = EffectType[child.objectType];
				
				
				if(child.objectType != null && cls != null)
				{
					
					new cls(displayObject,child);
				}
			}
		}

	}
}