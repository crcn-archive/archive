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
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class BoxDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _gap:Number;
		private var _align:String;
		private var _scaler:String;
		private var _alignment:String;
		private var _curChild:DisplayObject;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BoxDecorator(priority:int = -1)
		{
			super(priority);
			_gap = 0;
		}
		
		
		/**
		 */
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		override public function get refreshTypes():Array
		{
			return [RefreshType.CHILD_ADDED];
		}
		
		
		
		
		/**
		 */
		override public function get properties():Array
		{
			return ["alignment","gap"];
		}
		
		/**
		 */
		override public function findProperties(style:Style):Array
		{
			
			if(style.containsKey("alignment"))
				return properties;
				
			return null;
		}
		
		/**
		 */
		
		public function set alignment(value:String):void
		{
			if(value ==  "horizontal")
			{
				_scaler = "width";
				_align  = "x"
			}
			else
			if(value == "vertical")
			{
				_scaler = "height";
				_align  = "y"
			}
			
			_alignment = value;
			
			
			
			
			
		}
		
		public function get alignment():String
		{
			return _alignment;
		}
		
		/**
		 */
		
		public function set gap(value:Number):void
		{
			_gap = value;
			
		}
		
		public function get gap():Number
		{
			return _gap;
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
			if(!currentTarget)
				return;
				
			//trace("BOX THAT shit. DOG :D");
			var nextPosition:Number = 0;
			var child:DisplayObject;
			
			
			//some of the children could have values that exceed 100%
			//for instance 3 children all with 100% should be split up to
			//33.333% 
			//sumPercentWidth = (sumPercentWidth-100)/numChildrenPercW;
			//trace(_align);
			
			
			for(var i:int = 0; i < currentTarget.numChildren; i++)
			{
				
				child = currentTarget.getChildAt(i);
				
				child.removeEventListener(Event.RESIZE,onChildResize);
				child.addEventListener(Event.RESIZE,onChildResize);
				
					
				if(!child.visible)
					continue;
				
				child[ _align ] = nextPosition;
				
				//trace(child[_scaler],child);
				
				//trace(_align,child,child[ _scaler ],nextPosition);
				nextPosition = Math.round(nextPosition + child[ _scaler ] + _gap);
				
				//trace("BoxDecorator::"+child.name,nextPosition);
				
			}
			
		}
		
		/**
		 */
		
		private function onChildResize(event:Event):void
		{
			
			draw2();
			
		}
		
		
	}
}