package com.ei.psd2.display
{
	import com.ei.psd2.LayerResource;
	import com.ei.psd2.effectResources.Effect;
	
	import flash.display.Sprite;
	
	public class PSDDisplayObject extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _layerResources:Array;
		private var _layerEffect:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function PSDDisplayObject()
		{
			_layerResources = new Array();
			_layerEffect = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function addLayerResource(resource:LayerResource):void
		{
			_layerResources.push(resource);
		}
		
		/**
		 */
		
		public function addLayerEffect(effect:Effect):void
		{
			_layerEffect.push(effect);	
		}
		
		/**
		 */
		
		public function getLayerEffect(type:Class):Effect
		{
			
			for each(var eff:Effect in _layerEffect)
			{
				if(eff is type)
					return eff;
			}
			
			return null;
		}
	}
}