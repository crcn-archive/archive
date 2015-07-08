package com.ei.display
{

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class Content extends Sprite implements IDisplaceable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Included Methods
        //
        //--------------------------------------------------------------------------
        
        include 'displaceChildren.as';
        
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _mask:Sprite;
		private var _width:Number;
		private var _height:Number;
		private var _content:Sprite;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function Content(target:DisplayObject):void
		{
			
			
			super.addChild(target);

		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
        
        public function get target():Sprite
        {
        	return _content;
        }


	}
}