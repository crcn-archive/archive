package com.ei.display.decor
{
	import com.ei.utils.*;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class Constraints implements IConstrainable
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _left:Number;
		private var _right:Number;
		private var _top:Number;
		private var _bottom:Number;
		private var _verticalCenter:Number;
		private var _horizontalCenter:Number;
		private var _restrictBounds:Boolean;
		
		private var _parentType:ParentType;
		private var _constrain:Boolean;
		private var _target:DisplayObject;
		
		private var _alreadyInvisible:Boolean;
		
		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function Constraints(target:DisplayObject,newLeft:Number=NaN,newRight:Number=NaN,newTop:Number=NaN,newBottom:Number=NaN)
		{
			
			
			
			
			_target = target;
			
			
		
			
			this.left   = newLeft;
			this.right  = newRight;
			this.top    = newTop;
			this.bottom = newBottom;

			_parentType = new ParentType(target);
			
			
		
			target.addEventListener(Event.ENTER_FRAME,waitForRoot);
			//target.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function get left():Number
		{
			return _left;
		}

		public function set left(pos:Number):void
		{
			_left = pos;
			//trace(_target,"LEFT",pos);
			drawConstraints();
		}
		
		/**
		 */
		
		public function get right():Number
		{
			return _right;
		}
		
		public function set right(pos:Number):void
		{
			_right = pos;
			//trace(_target,"RIGHT",pos);
			drawConstraints();
		}
		
		/**
		 */
		
		public function get top():Number
		{
			return _top;
		} 
		
		public function set top(pos:Number):void
		{
			_top = pos;
			//trace(_target,"TOP",pos);
			drawConstraints();
		}
		
		
		/**
		 */
		
		public function get bottom():Number
		{
			return _bottom;
		}
		
		public function set bottom(pos:Number):void
		{
			_bottom = pos;
			//trace(_target,"POS",pos);
			drawConstraints();
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
		
		/**
		 */
		
		public function set restrictBounds(value:Boolean):void
		{
			_restrictBounds = value;
		}
		
		public function get restrictBounds():Boolean
		{
			return _restrictBounds;
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
		
		
		//--------------------
		// Enable
		//--------------------
		
		/**
		 */
		
		public function set constrain(value:Boolean):void
		{
			
			_constrain = value;
			
			if(_target.root == null)
				return;
			
			_parentType.resizeableObject.removeEventListener(Event.RESIZE,onParentResize);
			
			if(_constrain)
			{
				
				_parentType.resizeableObject.addEventListener(Event.RESIZE,onParentResize);
				_target.addEventListener(Event.ADDED,onAdded);
				drawConstraints();
			}
		}
		
		public function get constrain():Boolean
		{
			return _constrain;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		
		
		private function waitForRoot(event:Event):void
		{
			
			if(_target.root != null && _target.stage != null)
			{
				
				_target.removeEventListener(Event.ENTER_FRAME,waitForRoot);

				constrain = true;
				
			}
		}
		
		/**
		 */
		
		/*private function onAddedToStage(event:Event):void
		{
			_target.removeEventListener(Event.ENTER_FRAME,onAddedToStage);
			
			constrain = true;
		}*/
		
		
		/**
		 */

		
		private function onParentResize(event:Event):void
		{

			//trace(event.target,"RESIZING");
			//Bubbles can throw things out of wack, so make sure that if the
			//parent is resizing, it isn't any of its children that are resizing
			//this also increases the speed of the application
			if(event.target == _parentType.resizeableObject)
			{
				drawConstraints();
			}
		}
		
		/**
		 */
		
		private function onAdded(event:Event):void
		{
			drawConstraints();
		}
		
		
		
		//-----------------------------------------------------------
		// 
		// Protected Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		protected function drawConstraints():void
		{
			
			if(_target.root == null  || _parentType == null)
				return;
			
			//trace(_target,_parentType.resizeableObject,left,right,top,bottom);
			
			if(!isNaN(_left))
			{
				_target.x = _left;
			}
			
			//STRETCH if left and right are specified
			if(!isNaN(_right) && !isNaN(_left))
			{
				var newWidth:Number =  _parentType.width - _right - _target.x;
					
				if(newWidth < 0)
					newWidth = 0;
							
				_target.width = newWidth;
			}
			else
			if(!isNaN(_right))
			{
				_target.x = _parentType.width - _right - _target.width;
			}

			if(!isNaN(_top))
			{
				_target.y = _top;
			}
			
			if(!isNaN(_top) && !isNaN(_bottom))
			{
				var newHeight:Number = _parentType.height - _bottom - _target.y;
				
				if(newHeight < 0)
					newHeight = 0;
					
				_target.height = newHeight;
			}
			else
			if(!isNaN(_bottom))
			{
				_target.y = _parentType.height - _bottom - _target.height;
			}
			
			//set the center part now
			
			var newPosition:Number;
			
			if(!isNaN(_horizontalCenter))
			{
				newPosition = _parentType.width/2 - _target.width/2 + _horizontalCenter;
				
				if(_restrictBounds && (newPosition < 0 || newPosition > _parentType.width))
					return;
					
				_target.x = newPosition;
			}
			
			if(!isNaN(_verticalCenter))
			{
				newPosition =  _parentType.height/2 - _target.height/2 + _verticalCenter;
				
				if(_restrictBounds && (newPosition < 0 || newPosition > _parentType.height))
					return;
					
				_target.y = newPosition;
			}
			
			
			
		}
		
		
		
		
		
	}
}