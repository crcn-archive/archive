/******************************************************************
 * 
 * Author: Craig Condon
 * 
 * copyright © 2008 - 2009 Craig Condon
 * 
 * You are permited to modify, and distribute this file in
 * accordance with the terms of the license agreement accompanying
 * it.
 * 
 ******************************************************************/

package com.bridge.ui.layout2.decor
{
	import com.addicted2flash.layout.LayoutEventType;
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.bridge.ui.core.UIComponent;
	
	import flash.geom.Rectangle;
	
	public class AspectRatioDecorator extends DisplayObjectDecorator
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _ratioType:String;
		private var _staticWidth:Number;	
		private var _staticHeight:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function AspectRatioDecorator()
		{
			aspectRatioType = AspectRatioType.NONE;
			
		}
		
	
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get acceptedProperties():Array
		{
			return ["aspectRatioType","gap"];
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		 
		public function set aspectRatioType(value:String):void
		{
			_ratioType = value;
			
			ready = true;
			
		}
		
		public function get aspectRatioType():String
		{
			return _ratioType;
		}
		
		/**
		 */
		
		public function set staticWidth(value:Number):void
		{
			_staticWidth = value;
			
		}
		
		public function get staticWidth():Number
		{
			return _staticWidth;
		}
		
		/**
		 */
		
		public function set staticHeight(value:Number):void
		{
			_staticHeight = value;
			
		}
		
		public function get staticHeight():Number
		{
			return _staticHeight;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		override public function layoutComponent(c:ILayoutComponent):void
		{
			
			if(isNaN(_staticWidth) || isNaN(_staticHeight))
				return;
				
			
			var target:UIComponent = UIComponent(c);
			
			var layoutBounds:Rectangle = c.layoutBounds;
			
			var wRatio:Number = 1;
			var hRatio:Number = 1;
			
			
			if(_ratioType == AspectRatioType.NONE)
				return;
			
			if((layoutBounds.width < staticWidth || _ratioType == AspectRatioType.STRETCH) && layoutBounds.width != 0)
			{
				
				wRatio = layoutBounds.width / staticWidth;
			}
			
			if((layoutBounds.height || _ratioType == AspectRatioType.STRETCH) && layoutBounds.height != 0)
			{
				hRatio = layoutBounds.height / staticHeight;
			}
			
			var controlRatio:Number = wRatio < hRatio ? wRatio : hRatio;
			
			
			/*if(_ratioType == AspectRatioType.NONE)
			{
				target.width = _staticWidth;
				target.height = _staticHeight;
				return;
			}*/
			
			target.width  = _staticWidth  * controlRatio;
			target.height = _staticHeight * controlRatio;
			
			
			if(_ratioType == AspectRatioType.KEEP_RATIO)
			{
				//target.scaleX = controlRatio;
				//target.scaleY = controlRatio;
			}
				
			
			
		}

	}
}