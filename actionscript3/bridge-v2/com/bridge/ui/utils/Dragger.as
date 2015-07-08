package com.bridge.ui.utils
{
	import com.ei.events.DragEvent;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class Dragger extends EventDispatcher
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------

		private var _stage:*;
		private var _lockX:Number;
		private var _lockY:Number;
		private var _bounds:Rectangle;
		private var _lockCenter:Boolean;
		private var _dragging:Boolean;
		
		//target could be proxy
		private var _target:Object;
		private var _boundToSize:Boolean;
		private var _allowedChildren:Array;
		

		private var _currentTarget:Object;
		
		
		private var _dragX:String;
		private var _dragY:String;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------
		
		public var dragType:String;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function Dragger(target:Object = null,type:String = DragType.DRAG_ALL,lockCenter:Boolean = false,objBounds:Rectangle = null,dragXProperty:String = "x",dragYProperty:String = "y")
		{
			
			_dragX 			   = dragXProperty;
			_dragY			   = dragYProperty;
			_target 	       = target;
			_lockCenter		   = lockCenter;
			_lockX      	   = 0;
			_lockY      	   = 0;
			dragType          = type;
			_bounds			   = objBounds;
			
			
			_allowedChildren = new Array();
			
			this.target = target;

			if(target != null)
			{
				bounds 		= objBounds;
			}
			
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		
		public function set bounds(value:Rectangle):void
		{
			
			_bounds = value;

			var pt:Point = new Point(_target.x,_target.y);
			

			if(_bounds != null)
			{
				pt = evalBounds(new Rectangle(_target.x,_target.y,_target.width,_target.height),_bounds);
			}
			_target.x = pt.x;
			_target.y = pt.y;
		}
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		/**
		 */
		
		public function set boundToSize(value:Boolean):void
		{
			_boundToSize = value;
		}
		
		public function get boundToSize():Boolean
		{
			
			
			return _boundToSize;
		}
		
		/**
		 */
		
		public function set target(value:*):void
		{
			
			//remove the event listener for the current target
			//if it is present
			if(_target != null)
			{
				_target.removeEventListener(Event.ENTER_FRAME,onStageSearch);
				stopDragger();
			}
			
			_target = value;
			
			if(_target != null)
				if(target.stage != null)
				{
					onStageSearch(null);
				}
				else
				{
					_target.addEventListener(Event.ENTER_FRAME,onStageSearch);
				}
		}
		
		public function get target():Object
		{
			return _target;
		}
		
		//-----------------------------------------------------------
		// 
		// Public Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function startDragger():void
		{
			//make sure that there are no double drags
			stopDragger();
			
			_stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp);
			_target.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
		}
		
		
		/**
		 */
		
		public function stopDragger():void
		{
			if(_stage != null)
				_stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
				
				
			if(_target == null)
				return;
				
			_target.removeEventListener(MouseEvent.MOUSE_DOWN,onMouseDown);
			_target.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		}
		
		/**
		 */
		
		public function allowChildDrag(object:Object):void
		{
			_allowedChildren.push(object);
		}
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		 private function onStageSearch(event:Event):void
		 {
		 	
		 	if(_target.stage != null)
		 	{
		 		_target.removeEventListener(Event.ENTER_FRAME,onStageSearch);
		 		_stage = _target.stage;
				startDragger();
		 	}
		 	
		 }
		 
		/**
		 */
		 
		 private function onMouseDown(event:MouseEvent):void
		 {
		 	_dragging = true;
		 	
		 	if(dragType == DragType.DRAG_ALL)
		 	{
		 		_currentTarget = _target;
		 	}
		 	else
		 	if(dragType == DragType.DRAG_CHILDREN)
		 	{
		 		_currentTarget = event.target;
		 	}
		 	
		 	
		 	if(!_lockCenter)
		 	{
		 		_lockX = _currentTarget.mouseX * _currentTarget.scaleX;
		 		_lockY = _currentTarget.mouseY * _currentTarget.scaleY;
		 	}
		 	
		 	
		 	dispatchEvent(new DragEvent(DragEvent.START));
		 	
		 	_target.addEventListener(Event.ENTER_FRAME,onEnterFrame);
		 }
		 
		 
		/**
		 */
		 
		 private function onEnterFrame(event:Event):void
		 {
		 	
		 	var newPosition:Point  = new Point(_currentTarget.parent.mouseX - _lockX, _currentTarget.parent.mouseY - _lockY);
		 	var compRect:Rectangle = new Rectangle(newPosition.x,newPosition.y,_currentTarget.width,_currentTarget.height);
		 	
		 	
		 	
		 	
		 	if(_bounds != null)
		 	{
		 		var newBounds:Rectangle = _bounds.clone();
		 			
			 	if(_boundToSize)
			 	{
			 		
			 		newBounds.width	 -= _currentTarget.width;
			 		newBounds.height -= _currentTarget.height;
			 		
			 		if(newBounds.width  < 0) newBounds.width  = 0;
			 		if(newBounds.height < 0) newBounds.height = 0;
			 	}
			 	
			 	newPosition = evalBounds(compRect,newBounds);
			 	
			 	
		 	}
		 	//trace(_bounds);
			
		 	_currentTarget.x = newPosition.x;
			_currentTarget.y = newPosition.y;
			
			_currentTarget.dispatchEvent(new DragEvent(DragEvent.DRAGGING,true));
			dispatchEvent(new DragEvent(DragEvent.DRAGGING,true));
		 	
		 }
		 
		 
		/**
		 */
		 
		 private function onMouseUp(event:MouseEvent):void
		 {
		 	_target.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
		 	
		 	
		 	
		 	//needed or else the dragger wil dispatch an event on root mouse up everytime 
		 	if(_dragging)
		 	{	
		 		_dragging = false;
		 		dispatchEvent(new DragEvent(DragEvent.STOP));
		 	}
		 	
		 }
		 
		 
		/**
		 */
		 
		 private function evalBounds(pointPosition:Rectangle,pointBounds:Rectangle):Point
		 {
		 	
		 	var newX:Number = pointPosition.x;
		 	var newY:Number = pointPosition.y;
		 	
		 	
		 	
		 	var maxX:Number = pointBounds.width  + pointBounds.x;
		 	var maxY:Number = pointBounds.height + pointBounds.y;

		 	
		 	/*if(maxX < 0)
		 	{
		 		//maxX = 0;
		 	}
		 	if(maxY < 0)
		 	{
		 		//maxY = 0;
		 	}*/
		 	
		 	if(pointBounds.x != Infinity && pointPosition.x < pointBounds.x)
		 	{
		 		
		 		newX = pointBounds.x;
		 	}
		 	
		 	
		 	if(pointBounds.y != Infinity && pointPosition.y < pointBounds.y)
		 	{
		 		
		 		newY = pointBounds.y;
		 	}
		 	
		 	if(pointBounds.width != Infinity && pointPosition.x > maxX)
		 	{
		 		newX = maxX;
		 	}
		 	else
		 	if(pointBounds.width != Infinity && pointPosition.x > pointBounds.width)
		 	{
		 		//PROBLEMS IN PAST
		 		newX = pointBounds.x;
		 	}
		 	
		 	if(pointBounds.height != Infinity && pointPosition.y > maxY)
		 	{
		 		newY = maxY;
		 	}
		 	else
		 	if(pointBounds.height != Infinity && pointPosition.y > pointBounds.height)
		 	{
		 		//PROBLEMS IN PAST
		 		newY = pointBounds.y;
		 	}
	
		 	return new Point(newX,newY);
		 }
	}
}