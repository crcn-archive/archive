package com.ei.ui3.scroll
{
	import com.ei.display.decor.Dragger;
	import com.ei.events.DragEvent;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	internal class ScrollHandler
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		private var _XorY:String;
		//private var _policy:String;
		private var _resize:Boolean;
		private var _dragger:Dragger;
		private var _bounds:Rectangle;
		private var _scrollBar:ScrollBar;
		private var _scrollDimension:String;
		private var _targetDimension:String;
		
		
		
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
		private var Sbd:Number; //scroll boundary (content boundary - scroll more height - scroll less height)

		//-----------------------------------------------------------
		// 
		// Constructor
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		public function ScrollHandler(scrollBar:ScrollBar)
		{
			_scrollBar = scrollBar;
			
			//start the dragger class for the scroll bar
			_dragger   			 = new Dragger(_scrollBar.scroller);
			
			//"boundToSize" takes the width and the height of the item dragged
			//instead of a point
			_dragger.boundToSize = true;
			
			_resize = true;
			
			//set the bounds to the mask width and height
			//bounds     = new Rectangle(0,0,scrollBar.target.width,scrollBar.target.height);
			_scrollBar.scroller.addEventListener(DragEvent.DRAGGING,onDragging);
			
			//listen for when any components change in the scroll bar (buttons)
			//_scrollBar.addEventListener(Event.ADDED,onTargetResize);
			_scrollBar.target.addEventListener(Event.CHANGE,onTargetResize);
			//_scrollBar.target.addEventListener(Event.RESIZE,onTargetResize);
		

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

			refresh();
			
			
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
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function refresh():void
		{
			
			if(!_scrollBar.target.content || !_scrollBar.scroller)
				return;
				
			drawBounds();
			drawScroller();
			changeScrollerPosition();
			
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
			
			if(!_scrollBar.target.content)
				return 0;
				
			return _scrollBar.target.content[ dim ];
		}
		
		
		/**
		 * returns the scroll bar's bounds, subtracting both more and less buttons
		 */
		 
		private function get scrollBarBounds():Rectangle
		{
			//var rect:Rectangle = new Rectangle();
			//rect.width = _bounds
			//rect[ _scrollDimension ] = _bounds[ _scrollDimension ] - _scrollBar.scrollLess[ _scrollDimension ] - _scrollBar.scrollMore[ _scrollDimension ];
			
			return _bounds;//rect;
		}
		
		//-----------------------------------------------------------
		// 
		// Private Methods
		//
		//-----------------------------------------------------------
		
		/**
		 */
		
		private function onTargetResize(event:Event):void
		{
			bounds = new Rectangle(0,0,_scrollBar.target.width,_scrollBar.target.height);
		}
		
		/**
		 */
		 
		private function onChildAdded(event:Event):void
		{
			drawScroller();	
		}
		
		/**
		 */
		 
		private function onDragging(event:DragEvent):void
		{
			changeContentPosition();
		}
		
		/**
		 */
		
		
		/**
		 */
		
		public function drawBounds():void
		{
			var newBounds:Rectangle;
			
			newBounds = new Rectangle(0,0, _scrollBar.scrollBackground.width,_scrollBar.scrollBackground.height);
				
			
			_dragger.bounds 		 = newBounds;
			
			//_box.align();
			
		}
		
		private function drawScroller():void
		{

			setPosition("x","width");
			setPosition("y","height");
		}
		
		
		
		/**
		 */
		
		
		
		private function setPosition(XorY:String,dim:String):void
		{
			
			var targetSize:Number = getTargetSize(dim);
			
			
			if(targetSize > 0)
			{
				Sh = Sb*(Bh / Ch);
				//var cs = Sh;
				_scrollBar.scroller[ dim ] = Sh;
			}
			
			if(bounds[ dim ] <= 0)
				return;
			
			var diff:Number = targetSize / scrollBarBounds[ dim ];

			if(_resize)
			{
				var Cy:Number = _scrollBar.target.content[ XorY ];
				var Ch:Number = targetSize;
				var Bh:Number = _scrollBar.target[ dim ];
			
				var Sy:Number = _scrollBar.scroller[ XorY ];
				var Sh:Number = _scrollBar.scroller[ dim ];
				
				var Mh:Number = getScrollMorePos(dim);
				var Lh:Number = getScrollLessPos(dim);
				
				var Sb:Number = Bh - Mh - Lh;
			
			}
			else
			{
				_scrollBar.scroller.scaleX = 1;
				_scrollBar.scroller.scaleY = 1;
			}
			if(_scrollBar.target[ _scrollDimension ] >= targetSize)
			{

				_scrollBar.visible = false;
				_scrollBar.target.content[ XorY ] = 0;
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
			changeContentPosition2("x","width");
			changeContentPosition2("y","height");
		
		}
		
		private function changeContentPosition2(XorY:String,dim:String):void
		{
			
			//make sure the scroll bar is not null because 0/{num} does not work
			if(_scrollBar.scroller[ dim ] == 0 || _scrollBar.scroller[ dim ] == Infinity)
				return;
			
			//drawBounds();
			
			var Cy:Number;
			var Ch:Number = getTargetSize(dim);
			var Bh:Number = _scrollBar.target[ dim ];//_scrollBar.target[ dim ];
		//	var hH:Number = _scrollBar.scrollBackground[ dim ];
			
			var Sy:Number = _scrollBar.scroller[ XorY ];
			var Sh:Number = _scrollBar.scroller[ dim ];
			
			var Mh:Number = getScrollMorePos(dim);
			var Lh:Number = getScrollLessPos(dim);
			
			var Sb:Number = Bh - Mh - Lh;
			
			
			

			Cy = ( ((Ch - Bh) * Sy)/(Sb - Sh) );
			trace(Cy,Ch,Bh,Sy,Sh,Mh,Lh,Sb);
			
			
			//trace(XorY,Sy,Sh,Bh);
			
			_scrollBar.target.content[ XorY ] = -Cy;
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
			if(_scrollBar.scroller[ dim ] == 0 || _scrollBar.scroller[ dim ] == Infinity)
				return;
				
			var Cy:Number = _scrollBar.target.content[ XorY ];
			var Ch:Number = getTargetSize(dim);
			var Bh:Number = _scrollBar.target[ dim ];
			
			var Sy:Number = _scrollBar.scroller[ XorY ];
			var Sh:Number = _scrollBar.scroller[ dim ];
			
			
			var Mh:Number = getScrollMorePos(dim);
			var Lh:Number = getScrollLessPos(dim);
			var Sb:Number = Bh - Mh - Lh;
			
			if(Sh + Sy >= Sb && _scrollBar.visible)
			{
				_scrollBar.scroller[ XorY ] = Sb - Sh;
				changeContentPosition();
				
			}
			else
			{
				Sy = ( ((Sb - Sh) * Cy)/(Ch - Bh));

			
				_scrollBar.scroller[ XorY ] = -Sy;
			}
			
			
			
		}
		
		/**
		 */
		
		private function getScrollMorePos(dim:String):Number
		{
			if(dim == "width")
			{
				return _scrollBar.scrollMoreX[ dim ];
			}
			else
			{
				return  _scrollBar.scrollMoreY[ dim ];
			}
		}
		
		/**
		 */
		
		private function getScrollLessPos(dim:String):Number
		{
			if(dim == "width")
			{
				return _scrollBar.scrollLessX[ dim ];
			}
			else
			{
				return  _scrollBar.scrollLessY[ dim ];
			}
		}
		
		
		
	}
}