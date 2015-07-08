
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
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class SpriteUtils
	{
		//-----------------------------------------------------------
		// 
		// Public Static Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public static function clear(target:DisplayObjectContainer):void
		{
			for(var i:int = 0; i <= target.numChildren; i++)
			{
				
				try
				{
				target.removeChildAt(0);
				}catch(e:*)
				{
					trace(e);
				}
			}
			
			
		}
		
		/**
		 */
		
		public static function moveToTop(target:DisplayObjectContainer):void
		{
			
			var tp:DisplayObjectContainer = target.parent;
			var sc:DisplayObject= tp.getChildAt(tp.numChildren-1);
			
			if(sc != target)
				tp.swapChildren(target,sc);
		}
		
		/**
		 */
		
		public static function getAbsolutePosition(value:DisplayObject,root:DisplayObject = null):Point
		{
			if(value == null)
				return new Point(0,0);
				
			var position:Point = new Point(value.x,value.y);
			
			if(value is DisplayObjectContainer)
			{
				
				if(root != value.parent)
				{
					
					var absPar:Point = getAbsolutePosition(value.parent,root);
					
					
					position.x += absPar.x;
					position.y += absPar.y;
				}
			}
			
		//	trace(position);
			
			return position;
		}
		
		/**
		 */
		
		public static function getAbsoluteDimensions(value:DisplayObjectContainer,subChildren:Boolean = false):Rectangle
		{
			
			
			var furthestX:Number = 0;
			var furthestY:Number = 0;
		
			
			var clossestX:Number = 0;
			var clossestY:Number = 0;
			
			var posX:Number = 0;
			var posY:Number = 0;
			
			var posX2:Number = 0;
			var posY2:Number = 0;
			
			var child:DisplayObject;
			
			
			for(var i:int = 0; i < value.numChildren; i++)
			{
				
				child = value.getChildAt(i);
				
				trace(child,child.x,child.y,child.width,child.height);
				
				posX = child.x + child.width;
				posY = child.y + child.height;
				
				/*if(subChildren)
				{
					posX = posX + getAbsoluteDimensions(child as DisplayObjectContainer).width;
					posY = posY + getAbsoluteDimensions(child as DisplayObjectContainer).height;
				}*/
				
				if(child.x < clossestX)
					clossestX = child.x;
				
				if(child.y < clossestY)
					clossestY = child.y;
				
				if(clossestX == 0)
					clossestX = child.x;
					
				if(clossestY == 0)
					clossestY = child.y;
					
				
				
				if(posX > furthestX)
					furthestX = posX;
					
				if(posY > furthestY)
					furthestY = posY;
			}
			
			
			return new Rectangle(0,0,furthestX,furthestY);
		}
		
		/**
		 * returns false if any parent is not visible
		 */
		
		public static function isVisibleDeep(target:DisplayObject):Boolean
		{
			if(!target.root)
				return false;
			
			
			var cp:DisplayObject = target;
			var lp:DisplayObject = target;
			
			
			while(lp && lp.visible)
			{
				
				cp = lp;
				lp = lp.parent;
				
			}
			
			return cp.visible;
			
		}
		
		/**
		 */
		
		public static function waitForRoot(target:DisplayObject,callback:Function):void
		{
			
			if(target.root)
			{
				callback();
				return;
			}
			
			target.addEventListener(Event.ENTER_FRAME,onEnterFrame);
			
			
			function onEnterFrame(event:Event):void
			{
				if(target.root != null && target.stage != null)
				{
					event.target.removeEventListener(event.type,onEnterFrame);
					
					callback();
				}
			}
			
			
		}
		
		
		/**
		 */
		
		public static function mouseIsOver(target:DisplayObject):Boolean
		{
			return target.mouseX > 0 			&& 
			 	   target.mouseX  < target.width	&&
			  	  target.mouseY  > 0 			&&
			  	  target.mouseY  < target.height;
		}
		
		
		
	}
}