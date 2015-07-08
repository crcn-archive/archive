package com.bridge.ui.layout2
{
	import com.addicted2flash.layout.LayoutType;
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.addicted2flash.layout.core.ILayoutContainer;
	import com.addicted2flash.layout.display.UILayoutContainer;
	import com.addicted2flash.layout.layouts.ILayout;
	
	import flash.display.DisplayObject;
	
	public class NoLayout implements ILayout
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _target:UILayoutContainer;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function NoLayout()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get type():String
		{
			return LayoutType.PRE;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function layoutContainer(c:ILayoutContainer):void
		{
			for(var i:int = 0; i < c.componentCount; i++)
			{
				
				var ch:ILayoutComponent = c.getComponentAt(i);
				ch.setLayoutBounds(DisplayObject(ch).x,DisplayObject(ch).y,c.layoutBounds.width,c.layoutBounds.height);
			}	
		}

	}
}