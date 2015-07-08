package com.ei.display.decor
{
	import com.ei.utils.ParentType;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class PercentRelativity
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _parentType:ParentType;
		private var _target:DisplayObject;
		
		private var _width:Number;
		private var _height:Number;
		private var _x:Number;
		private var _y:Number;
		//-----------------------------------------------------------
		// 
		// Components
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function PercentRelativity(target:DisplayObject)
		{
			_target     = target;
			
			_parentType = new ParentType(target);
			
			target.addEventListener(Event.ENTER_FRAME,waitForRoot);
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function set width(newWidth:*):void
		{
			if(newWidth is String)
				_width = getPercent(newWidth);
			else
				_target.width = newWidth;
				
			drawRelativity();
		}
		
		public function get width():Object
		{
			return _target.width;
			
		}
		
		/**
		 */
		 
		public function set height(newHeight:*):void
		{
			if(newHeight is String)
				_height = getPercent(newHeight);
			else
				_target.height = newHeight;
				
			drawRelativity();
		}
		
		public function get height():Object
		{
			return _target.height;
		}
		
		/**
		 */
		 
		public function set x(newX:*):void
		{
			if(newX is String)
				_x = getPercent(newX);
			else
				_target.x = newX;
				
			drawRelativity();
		}
		
		public function get x():Object
		{
			return _target.x;
		}
		
		/**
		 */
		 
		public function set y(newY:*):void
		{
			if(newY is String)
				_y = getPercent(newY);
			else
				_target.y = newY;
				
			drawRelativity();
		}
		
		public function get y():Object
		{
			return _target.y;
		}
		
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function waitForRoot(event:Event):void
		{
			if(_target.root != null && _target.stage != null)
			{
				_target.removeEventListener(Event.ENTER_FRAME,waitForRoot);
				_parentType.resizeableObject.addEventListener(Event.RESIZE,onParentResize);
				drawRelativity();
			}
		}
		
		/**
		 */
		
		private function drawRelativity():void
		{
			if(_target.root != null && _target.stage != null)
			{
			
				
				if(!isNaN(_width))
				{
					_target.width = _parentType.width * _width;
				}
				
				if(!isNaN(_height))
				{
					_target.height = _parentType.height * _height;
				}
				
				if(!isNaN(_x))
				{
					_target.x = (_parentType.width - _target.width) * _x;
				}
				
				if(!isNaN(_y))
				{
					_target.y = (_parentType.height - _target.height) * _y;
				}
				
				//setProperty("width",_width,_parent[ _widthType ] * _width);
				 	//setProperty("height",_height,_parent[ _heightType ] * _height);
				 	//setProperty("x",_x,(_parent[ _widthType ] - _scope.width) * _x);
				 	//setProperty("y",_y,(_parent[ _heightType ] - _scope.height) * _y);
			}
		}
		
		/**
		 */
		 
		 private function onParentResize(event:Event):void
		 {
			drawRelativity();
		 }
		 
		
		private function getPercent(perc:String):Number
		{
			var newPerc:String = new String(perc);
			newPerc = newPerc.replace("%","");
			var percNum:Number = new Number(newPerc);
			
			return percNum / 100;
		}
		 

	}
}