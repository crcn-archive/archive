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
	import flash.display.DisplayObjectContainer;
	import com.bridge.ui.core.ui_internal;
	
	public class AlignmentDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _verticalCenter:Number;
		private var _horizontalCenter:Number;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function AlignmentDecorator(index:int=-1)
		{
			super(index);
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
			return ["verticalCenter","horizontalCenter"];
		}
		/**
		 */
		 
		public function get verticalCenter():Number
		{
			return _verticalCenter;
		}
		
		public function set verticalCenter(pos:Number):void
		{
			//trace(_target,"VERTICALCENTER",pos);
			_verticalCenter = pos;	
			
		}
		
		/**
		 */
		
		public function get horizontalCenter():Number
		{
			return _horizontalCenter;
		}
		
		public function set horizontalCenter(pos:Number):void
		{
			//trace(_target,"HORIZONTALCENTER",pos);
			_horizontalCenter = pos;
			
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
			
			var newPosition:Number;
			
			if(!isNaN(_horizontalCenter))
			{
				newPosition = ui_internal::layoutManager.parentWidth/2 - currentTarget.width/2 + _horizontalCenter;
				
				//if(_restrictBounds && (newPosition < 0 || newPosition > manager.parentWidth))
				//	return;
					
				currentTarget.x = newPosition;
			}
			
			if(!isNaN(_verticalCenter))
			{
				newPosition =  ui_internal::layoutManager.parentHeight/2 - currentTarget.height/2 + _verticalCenter;
				
				//if(_restrictBounds && (newPosition < 0 || newPosition > manager.parentHeight))
				//	return;
					
				currentTarget.y = newPosition;
			}
			
		}

	}
}