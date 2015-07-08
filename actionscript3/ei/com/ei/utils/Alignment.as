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

package com.ei.utils
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	import mx.events.ResizeEvent;
	
	public class Alignment
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _horizontalCenter:Number;
		private var _verticalCenter:Number;
		
		private var _parentType:ParentType;
		private var _target:DisplayObject;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function Alignment(target:DisplayObject)
		{
			
			_target = target;
			
		
			_horizontalCenter = NaN;
			_verticalCenter   = NaN;
			
			if(target.parent)
			{
				setAlignment();
			}
			else
			{
				target.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			}
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		
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
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function refresh():void
		{
			setPosition();
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		private function onAdded(event:Event):void
		{
			event.target.removeEventListener(event.type,onAdded);
		}
		
		/**
		 */
		
		private function setAlignment():void
		{
			
			
			_parentType = new ParentType(_target);
			
			setPosition();
			//_target.addEventListener(Event.ENTER_FRAME,onResize);
			_target.addEventListener(ResizeEvent.RESIZE,onResize);
			//_target.parent.addEventListener(ResizeEvent.RESIZE,onResize);
		}
		
		/**
		 */
		
		private function onResize(event:*):void
		{
			setPosition();
		}
		
		/**
		 */
		
		private function setPosition():void
		{
			
			//set the center part now
			
			var newPosition:Number;
			
			if(!isNaN(_horizontalCenter))
			{
				
				newPosition = _parentType.width/2 - _target.width/2 + _horizontalCenter;
				
				if((/*newPosition < 0 || */newPosition > _parentType.width))
					return;
					
				_target.x = newPosition;
			}
			
			if(!isNaN(_verticalCenter))
			{
				newPosition =  _parentType.height/2 - _target.height/2 + _verticalCenter;
				
				if((/*newPosition < 0 ||*/ newPosition > _parentType.height))
					return;
					
				_target.y = newPosition;
			}
		}
	}
}