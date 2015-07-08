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

package com.bridge.ui.layout.decor
{
	import com.bridge.ui.style.Style;
	import com.bridge.ui.core.ui_internal;
	
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
		
		public function AspectRatioDecorator(index:int = 0)
		{
			super(index);
			
			aspectRatioType = AspectRatioType.NONE;
			
		}
		
	
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		override public function get properties():Array
		{
			return ["aspectRatioType"];
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
		
		override protected function draw2():void
		{
			
			var wRatio:Number = 1;
			var hRatio:Number = 1;
			
			
			if(_ratioType == AspectRatioType.NONE)
				return;
			
			if((ui_internal::layoutManager.parentWidth < staticWidth || _ratioType == AspectRatioType.STRETCH) && ui_internal::layoutManager.parentWidth != 0)
			{
				
				wRatio = ui_internal::layoutManager.parentWidth / staticWidth;
			}
			
			if((ui_internal::layoutManager.parentHeight < staticHeight || _ratioType == AspectRatioType.STRETCH) && ui_internal::layoutManager.parentHeight != 0)
			{
				hRatio = ui_internal::layoutManager.parentHeight / staticHeight;
			}
			
			var controlRatio:Number = wRatio < hRatio ? wRatio : hRatio;
			
			
			/*if(_ratioType == AspectRatioType.NONE)
			{
				target.width = _staticWidth;
				target.height = _staticHeight;
				return;
			}*/
			
			currentTarget.width  = _staticWidth  * controlRatio;
			currentTarget.height = _staticHeight * controlRatio;
			
			if(_ratioType == AspectRatioType.KEEP_RATIO)
			{
				//currentTarget.scaleX = controlRatio;
				//currentTarget.scaleY = controlRatio;
			}
				
			
			
		}

	}
}