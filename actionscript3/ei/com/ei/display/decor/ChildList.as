package com.ei.display.decor
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public class ChildList
	{
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _target:DisplayObjectContainer;
		
		
		//-----------------------------------------------------------
		// 
		// Contructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		public function ChildList(target:DisplayObjectContainer)
		{
			_target = target;
		}
		
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function get width():Number
		{
			return furthestPoint.x;
		}
		
		/**
		 */
		
		public function get height():Number
		{
			return furthestPoint.y;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function get furthestPoint():Point
		{
			var furthestX:Number = 0;
			var furthestY:Number = 0;
			
			var currentX:Number;
			var currentY:Number;
			
			var child:DisplayObject;
			
			for(var i:int = 0; i < _target.numChildren; i++)
			{
				
				//errors are thrown for some reason so catch them 
				try
				{
					child = _target.getChildAt(i);

					currentX = child.x + child.width;
					currentY = child.y + child.height;
					
					if(currentX > furthestX)
						furthestX = currentX;
					
					if(currentY > furthestY)
						furthestY = currentY;
				}catch(e:*)
				{
					//trace(e,i);
				}
					
			}
			
			
			return new Point(furthestX,furthestY);
		}
	}
}