package com.ei.display.decor
{

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	public class Box extends DisplayObjectDecorator implements IBox
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _margin:Number;
		private var _auto:Boolean;
		private var _align:String;
		private var _scaler:String;
		private var _shrinking:Number;
		private var _target:DisplayObjectContainer;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function Box(target:DisplayObjectContainer,align:String)
		{
			super(target);

			_target    = target;
			_margin    = 0;
			_shrinking = 0;
			alignment  = align;
			
			_target.addEventListener(Event.ADDED,onChildAdded);
			_target.addEventListener(Event.REMOVED,onChildAdded);
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function set alignment(value:String):void
		{

			if(value == AlignPolicy.HORIZONTAL)
			{
				_scaler = "width";
				_align  = "x"
			}
			else
			{
				_scaler = "height";
				_align  = "y"
			}
			
			align();
		}
		
		public function get alignment():String
		{
			return _align;
		}
		
		/**
		 */
		
		public function set margin(value:Number):void
		{
			_margin = value;
			
			align();
		}
		
		public function get margin():Number
		{
			return _margin;
		}
		
		/**
		 */
		
		public function set shrinking(value:Number):void
		{
			_shrinking = value;
			
			align();
		}
		
		public function get shrinking():Number
		{
			return _shrinking;
		}
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function align():void
		{
			var nextPosition:Number = 0;
			var child:DisplayObject;
			
			for(var i:int = 0; i < _target.numChildren; i++)
			{
				
				
				
				
				
			
				child = _target.getChildAt(i);
				
				
				var constraints:Array = getDisplayObjectDecorators(child,Constraints);
				
				
				
				child[ _align ] = nextPosition;
				//trace(_align,child,child[ _scaler ],nextPosition);
				nextPosition = nextPosition + child[ _scaler ] + margin - _shrinking;

				child.removeEventListener(Event.RESIZE,onChildChange,false);
				child.addEventListener(Event.RESIZE,onChildChange,false);

			
			}
		}
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function onChildAdded(event:Event):void
		{	
			align();
		}

		
		/**
		 */
		
		private function onChildChange(event:Event):void
		{
			align();
		}
	}
}