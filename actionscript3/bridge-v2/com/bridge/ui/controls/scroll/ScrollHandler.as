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

package com.bridge.ui.controls.scroll
{
	import com.addicted2flash.layout.LayoutEventType;
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.addicted2flash.layout.core.ILayoutObserver;
	import com.bridge.ui.core.ui_internal;
	import com.ei.display.decor.Dragger;
	import com.ei.events.DragEvent;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	internal class ScrollHandler implements ILayoutObserver
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _type:String;
		//private var _policy:String;
		private var _resize:Boolean;
		private var _dragger:Dragger;
		private var _bounds:Rectangle;
		private var _scrollBar:ScrollBar;
		private var _scrollDimension:String;
		private var _targetDimension:String;
		private var _startTime:int;

		
		
		/*
				
		!!if the scroll bar's position is initially zero, subtract the scrollMore
			
		Cy = ( ((Ch - Bh) * (Sy - Mh))/(Sb - Sh) )
			
		in this class, the scroller is in a container and iSy is 0
			
		*/
		
		private var Cp:Number; //content position (width/height)
		private var Cd:Number; //content dimension (width/height)
		private var Bd:Number; //content boundary dimension (width/height)
		private var Sp:Number; //scroll bar position (x/y)
		private var Sd:Number; //scroll bar (width/height)
		private var Md:Number; //scroll more (width/height)
		private var Ld:Number; //scroll less (width/height)
		private var Sb:Number; //scroll boundary (content boundary - scroll more height - scroll less height)

		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function ScrollHandler(scrollBar:ScrollBar,type:String)
		{
			_scrollBar = scrollBar;
			
			_type = type;
			
			//else both
			
			//start the dragger class for the scroll bar
			_dragger   			 = new Dragger(_scrollBar.ui_internal::scroller);
			
			//"boundToSize" takes the width and the height of the item dragged
			//instead of a point
			_dragger.boundToSize = true;
			
			_resize = true;
			
			//set the bounds to the mask width and height
			//bounds     = new Rectangle(0,0,scrollBar.target.width,scrollBar.target.height);
			_dragger.addEventListener(DragEvent.START,onDragStart);
			
			_scrollBar.target.addLayoutObserver(this);
		}
		//-----------------------------------------------------------
		// 
		// Getters / Setters
		//
		//-----------------------------------------------------------
		
		
		/**
		 * sets the bounds specifically for the dragger
		 */
		
		public function set bounds(value:Rectangle):void
		{
			_bounds = value;
			
			
		}
		
		public function get bounds():Rectangle
		{
			return _bounds;
		}
		
		/**
		 * sets the scroll bar to a static dimension
		 */
		
		public function set resizeScrollBar(value:Boolean):void
		{
			_resize = value;
			
			drawScroller();
			
		}
		
		public function get resizeScrollBar():Boolean
		{
			return _resize;
		}
		
		/**
		 */
		public function get acceptedLayoutEvents():int
		{
			return LayoutEventType.POSITION|LayoutEventType.SIZE;
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
			
			
			if(!_scrollBar.target.ui_internal::content || !_scrollBar.ui_internal::scroller)
				return;
			
			
			bounds = new Rectangle(0,0,_scrollBar.target.width,_scrollBar.target.height);
			
			drawBounds();
			drawScroller();
			changeScrollerPosition();
			
		}
		
		/**
		 */
		
		public function processLayoutEvent( type: int, c: ILayoutComponent ): void
		{
			this.refresh();
		}
		
		//-----------------------------------------------------------
		// 
		// Private Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 * returns the size of the content
		 */
		
		private function getTargetSize(dim:String):Number
		{
			if(!_scrollBar.target.ui_internal::content)
				return 0;
				
			//trace(_scrollBar.target.height,_scrollBar.target.ui_internal::content.y,_scrollBar.target.ui_internal::content.numChildren,_scrollBar.target.ui_internal::content.height);
			//trace(_scrollBar.target.ui_internal::content,_scrollBar.target.ui_internal::content.layoutBounds[dim]);
			//new ScrollableContent
			return _scrollBar.target.ui_internal::content[ dim ];
		}
		
		
		/**
		 * returns the scroll bar's bounds, subtracting both more and less buttons
		 */
		 
		private function get scrollBarBounds():Rectangle
		{
			
			return _bounds;//rect;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		 
		private function onChildAdded(event:Event):void
		{
			drawScroller();	
		}
		
		/**
		 */
		 
		private function onDragStart(event:DragEvent):void
		{
			_scrollBar.target.addEventListener(Event.ENTER_FRAME,onDragging);
		}
		 
		private function onDragging(event:Event):void
		{
			changeContentPosition();
			
		}
		
		/**
		 */
		
		private function stopDragging():void
		{
			_scrollBar.target.removeEventListener(Event.ENTER_FRAME,onDragging);
		}
		
		
		
		
		/**
		 */
		
		public function drawBounds():void
		{
			var newBounds:Rectangle;
			
			newBounds = new Rectangle(0,0, _scrollBar.ui_internal::scrollBackground.width,_scrollBar.ui_internal::scrollBackground.height);
				
			
			_dragger.bounds 		 = newBounds;

			
		}
		
		/**
		 */
		
		private function drawScroller():void
		{
			
			if(_type == ScrollType.BOTH || _type == ScrollType.HORIZONTAL) setPosition("x","width");
			if(_type == ScrollType.BOTH || _type == ScrollType.VERTICAL)   setPosition("y","height");
		}
		
		
		
		/**
		 */
		
		
		
		private function setPosition(XorY:String,dim:String):void
		{
			
			var targetSize:Number = getTargetSize(dim);
			
			if(!bounds || bounds[ dim ] <= 0)
				return;
			
			var diff:Number = targetSize / scrollBarBounds[ dim ];

			if(_resize)
			{
				var Cy:Number = _scrollBar.target.ui_internal::content[ XorY ];
				var Ch:Number = targetSize;
				var Bh:Number = _scrollBar.target[ dim ];
			
				var Sy:Number = _scrollBar.ui_internal::scroller[ XorY ];
				var Sh:Number = _scrollBar.ui_internal::scroller[ dim ];
				
				var Mh:Number = getScrollMorePos(dim);
				var Lh:Number = getScrollLessPos(dim);
				
				var Sb:Number = Bh - Mh - Lh;
				
				if(targetSize > 0)
				{
					Sh = Sb*(Bh / Ch);
					
					//var cs = Sh;
					_scrollBar.ui_internal::scroller[ dim ] = Sh;
				}
			
			}
			else
			{
				_scrollBar.ui_internal::scroller.scaleX = 1;
				_scrollBar.ui_internal::scroller.scaleY = 1;
				
			}
			if(_scrollBar.target[ dim ] >= targetSize)
			{
				//trace("ScrollHandler::"+_scrollBar.target.ui_internal::content[dim],targetSize);
				
				//_scrollBar.visible = false;
				_scrollBar.target.ui_internal::content[ XorY ] = 0;
			}
			else
			{
				_scrollBar.visible = true;
			}
		}
		
		
		/**
		 */
		
		private function changeContentPosition():void
		{
			if(_type == ScrollType.BOTH || _type == ScrollType.HORIZONTAL) changeContentPosition2("x","width");
			if(_type == ScrollType.BOTH || _type == ScrollType.VERTICAL)   changeContentPosition2("y","height");
		
		}
		
		private function changeContentPosition2(XorY:String,dim:String):void
		{
			
			
			//make sure the scroll bar is not null because 0/{num} does not work
			if(_scrollBar.ui_internal::scroller[ dim ] == 0 || _scrollBar.ui_internal::scroller[ dim ] == Infinity)
				return;
			
			
			drawBounds();
			this.drawScroller();
			
			var Cy:Number;
			var Ch:Number = getTargetSize(dim);
			var Bh:Number = _scrollBar.target[ dim ];//_scrollBar.target[ dim ];
		//	var hH:Number = _scrollBar.scrollBackground[ dim ];
			
			var Sy:Number = _scrollBar.ui_internal::scroller[ XorY ];
			var Sh:Number = _scrollBar.ui_internal::scroller[ dim ];
			
			var Mh:Number = getScrollMorePos(dim);
			var Lh:Number = getScrollLessPos(dim);
			
			var Sb:Number = Bh - Mh - Lh;
			
			
			
			//start the easing
			Cy = ( ((Ch - Bh) * Sy)/(Sb - Sh) );
			
			var sX:Number = _scrollBar.target.ui_internal::content[ XorY ];
			var d:Number = Cy - Math.abs(sX);
			
			
			var nd:Number = d/_scrollBar.dragging;
			
			var nY:Number = Cy - nd;	
			
			if(isNaN(nY))
			{
				nY = Cy;
			}
				
			if(!isNaN(nY))
			{
				
				_scrollBar.target.ui_internal::content[ XorY ] = -nY;
				
			}
			
			if(!_dragger.dragging && Math.ceil(nY) == Math.ceil(Cy))
			{
				this.stopDragging();
			}
				
		}
		
		
		
		/**
		 * change the position of the scroller if it exceeds the bounds (when resizing usually)
		 */
		
		private function changeScrollerPosition():void
		{
			
			changeScrollerPosition2("x","width");
			changeScrollerPosition2("y","height");
		}
		
		/**
		 */
		
		private function changeScrollerPosition2(XorY:String,dim:String):void
		{
			if(_scrollBar.ui_internal::scroller[ dim ] == 0 || _scrollBar.ui_internal::scroller[ dim ] == Infinity)
				return;
				
			var Cy:Number = _scrollBar.target.ui_internal::content[ XorY ];
			var Ch:Number = getTargetSize(dim);
			var Bh:Number = _scrollBar.target[ dim ];
			
			var Sy:Number = _scrollBar.ui_internal::scroller[ XorY ];
			var Sh:Number = _scrollBar.ui_internal::scroller[ dim ];
			
			
			var Mh:Number = getScrollMorePos(dim);
			var Lh:Number = getScrollLessPos(dim);
			var Sb:Number = Bh - Mh - Lh;
			
			if(Sh + Sy >= Sb && _scrollBar.visible)
			{
				_scrollBar.ui_internal::scroller[ XorY ] = Sb - Sh;
				changeContentPosition();
				
			}
			else
			{
				Sy = ( ((Sb - Sh) * Cy)/(Ch - Bh));

			
				_scrollBar.ui_internal::scroller[ XorY ] = -Sy;
			}
			
			
			
		}
		
		/**
		 */
		
		private function getScrollMorePos(dim:String):Number
		{
			if(dim == "width")
			{
				return _scrollBar.ui_internal::scrollMoreX[ dim ];
			}
			else
			{
				return  _scrollBar.ui_internal::scrollMoreY[ dim ];
			}
		}
		
		/**
		 */
		
		private function getScrollLessPos(dim:String):Number
		{
			if(dim == "width")
			{
				return _scrollBar.ui_internal::scrollLessX[ dim ];
			}
			else
			{
				return  _scrollBar.ui_internal::scrollLessY[ dim ];
			}
		}
		
		
		
	}
}