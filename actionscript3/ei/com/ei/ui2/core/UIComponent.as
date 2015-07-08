package com.ei.ui2.core
{
	import com.ei.display.decor2.LayoutManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class UIComponent extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _layoutManager:LayoutManager;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function UIComponent()
		{
			_layoutManager = new LayoutManager(this);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function set width(value:Number):void
		{
			super.width = value;
			
			//_layoutManager.width = value;
		}
		
		/**
		 */
		
		override public function set height(value:Number):void
		{
			super.height = value;

			//_layoutManager.height = value;
		}
		
		/**
		 */
		
		public function get layoutManager():LayoutManager
		{
			return _layoutManager;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		//--------------------
		// Add / Remove child
		//--------------------
		
		/**
		 */
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			
			if(child is UIComponent)
				_layoutManager.registerChild(child as UIComponent);
			
			var child:DisplayObject = super.addChild(child);
			
			
			this.refreshDecorators();
			
			
			return child;
			
		}
		
		/**
		 */
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			
			if(child is UIComponent)
				_layoutManager.registerChildAt(child as UIComponent,index);
			
			var child:DisplayObject = super.addChildAt(child,index);
			
			
			this.refreshDecorators();
			
			return child;
			
		}
		
		/**
		 */
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			if(child is UIComponent)
				_layoutManager.unregisterChild(child as UIComponent);
			
			return super.removeChild(child);
		}
		
		/**
		 */
		
		override public function removeChildAt(index:int):DisplayObject
		{
			_layoutManager.unregisterChildAt(index);
			
			return super.removeChildAt(index);
		}
		
		/**
		 */
		
		public function refreshDecorators():void
		{
			
			/*if(fromRoot)
			{
				var pparent:DisplayObject = parent;
				
				var oparent:DisplayObject = parent;
				while(pparent != null)
				{
					oparent = pparent;
					pparent = pparent.parent;
				}	
				
				oparent.dispatchEvent(new Event(Event.RESIZE));
			}*/
			
			_layoutManager.refreshDecorators();
		}
	}
}