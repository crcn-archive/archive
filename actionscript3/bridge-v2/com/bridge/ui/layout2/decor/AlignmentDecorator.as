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
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.addicted2flash.layout.core.ILayoutObserver;
	import com.bridge.ui.core.UIComponent;
	
	import flash.geom.Rectangle;
	
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
		
		public function AlignmentDecorator()
		{
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
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
			
			ready = true;
			
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
			
			ready = true;
		}
		
		override public function get acceptedProperties():Array
		{
			return ["horizontalCenter","verticalCenter"];
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
			
			var layoutBounds:Rectangle = c.layoutBounds;
			
		
		
			
			var newPosition:int;
			
			if(!isNaN(_horizontalCenter))
			{
				newPosition = layoutBounds.width/2 - target.width/2 + _horizontalCenter;
				
				//if(_restrictBounds && (newPosition < 0 || newPosition > manager.parentWidth))
				//	return;
					
				target.controlX = newPosition;
			}
			
			if(!isNaN(_verticalCenter))
			{
				
				newPosition =  layoutBounds.height/2 - target.height/2 + _verticalCenter;
				
				//if(_restrictBounds && (newPosition < 0 || newPosition > manager.parentHeight))
				//	return;
					
				target.controlY = newPosition;
			}
			
		}

	}
}