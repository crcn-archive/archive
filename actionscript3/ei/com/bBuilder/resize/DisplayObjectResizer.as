

package com.bBuilder.resize
{
	import com.ei.display.decor.Dragger;
	import com.ei.events.DragEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class DisplayObjectResizer extends Sprite
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Constants
        //
        //--------------------------------------------------------------------------
        
        private const N_POINT:String   = "North";
      	private const NE_POINT:String  = "NorthEast";
        private const E_POINT:String   = "East";
        private const SE_POINT:String  = "SouthEast";
        private const S_POINT:String   = "South";
        private const SW_POINT:String  = "SouthWest";
        private const W_POINT:String   = "West";
        private const NW_POINT:String  = "NorthWest";
        
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
        
        private var _points:Object;
        private var _dragger:Dragger;
        private var _target:DisplayObject;
        
        private var _storedWidth:Number;
        private var _storedHeight;Number;
        private var _storedX:Number;
        private var _storedY:Number;
        
        //drag mask is a hit state over the object being sized so the object itself isn't getting
        //resized
        private var _dragMask:Sprite;
        
        
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function DisplayObjectResizer(target:DisplayObject)
		{
			//_dragger = new Dragger(this);
			
			_target   = addChild(target);
			_dragMask = Sprite(addChild(new Sprite()));
			_dragMask.buttonMode = true;
			
			var dragger:Dragger = new Dragger(this,false);
			dragger.allowChildDrag(_dragMask);
			
			_points = new Object();
			
			_points[N_POINT]  = addChild(drawPoint(N_POINT));
			_points[NE_POINT] = addChild(drawPoint(NE_POINT));
			_points[E_POINT]  = addChild(drawPoint(E_POINT));
			_points[SE_POINT] = addChild(drawPoint(SE_POINT));
			_points[S_POINT]  = addChild(drawPoint(S_POINT));
			_points[SW_POINT] = addChild(drawPoint(SW_POINT));
			_points[W_POINT]  = addChild(drawPoint(W_POINT));
			_points[NW_POINT] = addChild(drawPoint(NW_POINT));
			
			_storedX 	  = _target.x;
			_storedY	  = _target.y;
			_storedWidth  = _target.width;
			_storedHeight = _target.height;
			
			drawDragMask();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function getPointPosition(point:String,pt:DisplayObject):Point
		{
			switch(point)
			{
				case N_POINT:
					return new Point(_target.x + _target.width/2,_target.y);
				break;
				case NE_POINT:
					return new Point(_target.x + _target.width - pt.width,_target.y);
				break;
				case E_POINT:
					return new Point(_target.x + _target.width - pt.width,_target.height/2+_target.y);
				break;
				case SE_POINT:
					return new Point(_target.x + _target.width - pt.width,_target.height+_target.y - pt.height);
				break;
				case S_POINT:
					return new Point(_target.x + _target.width/2,_target.height+_target.y - pt.height);
				break;
				case SW_POINT:
					return new Point(_target.x,_target.height+_target.y - pt.height);
				break;
				case W_POINT:
					return new Point(_target.x,_target.height/2+_target.y);
				break;
				case NW_POINT:
					return new Point(_target.x,_target.y);
				break;
			}
			
			return null;
		}
		
		/**
		 */
		
		private function repositionBox(position:String,point:DisplayObject):void
		{

			switch(position)
			{
				case N_POINT:
					_storedY = point.y;
					_target.height = _storedHeight - _storedY;
				break;
				case NE_POINT:
					_storedY = point.y;
					_storedWidth  = point.x + point.width;
					
					_target.height = _storedHeight - _storedY;
					_target.width  = _storedWidth  - _storedX;
				break;
				case E_POINT:
					_storedWidth  = point.x + point.width;
					
					_target.width  = _storedWidth  - _storedX;
				break;
				case SE_POINT:
					_storedWidth  = point.x + point.width;
					_storedHeight = point.y + point.height;
					
					_target.width  = _storedWidth  - _storedX;
					_target.height = _storedHeight - _storedY;
				break;
				case S_POINT:
					_storedHeight = point.y + point.height;
					
					_target.height = _storedHeight;
				break;
				case SW_POINT:
					_storedX      = point.x;
					_storedHeight = point.y + point.height;

					_target.width  = _storedWidth  - point.x;
					_target.height = _storedHeight - _storedY;
					_target.x      = _storedX;
					
				break;
				case W_POINT:
					_storedX      = point.x;
					_target.width  = _storedWidth  - point.x;
					_target.x      = _storedX;
				break;
				case NW_POINT:
					_storedY = point.y;
					_target.height = _storedHeight - _storedY;
					_storedX      = point.x;
					_target.width  = _storedWidth  - point.x;
					_target.x      = _storedX;
				break;
			}
			
			
			_target.y = _storedY;
			
			
		}
		
		/**
		 */
		
		private function drawPoint(position:String):Sprite
		{
			var sp:Sprite = new Sprite();
			sp.buttonMode = true;
			with(sp.graphics)
			{
				lineStyle(1,0xFFFFFF);
				beginFill(0);
				drawRect(0,0,10,10);
			}
			
			var pos:Point = getPointPosition(position,sp);
			
			sp.x = pos.x;
			sp.y = pos.y;
			
			
			sp.name = position;
			
			var dragger:Dragger = new Dragger(sp);
			sp.addEventListener(DragEvent.DRAGGING,onPointDrag);
			
			
			return sp;
		}
		
		
		/**
		 */
		
		private function onPointDrag(event:DragEvent):void
		{
			
			repositionBox(event.target.name,event.target as DisplayObject);

			
			var getPoint:Point;
			
			for each(var point:DisplayObject in _points)
			{
				if(point != event.target)
				{
					getPoint = getPointPosition(point.name,point);
					
					point.x  = getPoint.x;
					point.y  = getPoint.y;
				}
			}
			
			drawDragMask();
		}
		
		/**
		 */
		
		private function drawDragMask():void
		{
			_dragMask.alpha = 0;
			_dragMask.x = _target.x;
			_dragMask.y = _target.y;
			with(_dragMask.graphics)
			{
				clear();
				beginFill(0);
				drawRect(0,0,_target.width,_target.height);
			}
		}
	}
}