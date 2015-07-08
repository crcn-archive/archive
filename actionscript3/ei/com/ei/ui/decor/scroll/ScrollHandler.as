package com.ei.ui.decor.scroll
{
	import com.ei.display.decor.AlignPolicy;
	import com.ei.display.decor.Box;
	import com.ei.display.decor.Dragger;
	import com.ei.events.DragEvent;
	import com.ei.events.ScrollBarEvent;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	
	internal class ScrollHandler
	{
		
		//-----------------------------------------------------------
		// 
		// Private Variables
		//
		//-----------------------------------------------------------
		
		
		private var _box:Box;
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
			
			//set the box up to align the scroll bar vertically or horizontally
			_box      			 = new Box(scrollBar.buttonHolder,scrollBar.scrollPolicy);
			
			//start the dragger class for the scroll bar
			_dragger   			 = new Dragger(_scrollBar.scroller);
			
			//"boundToSize" takes the width and the height of the item dragged
			//instead of a point
			_dragger.boundToSize = true;
			
			//decide what type of scroll bar to use
			switch(scrollBar.scrollPolicy)
			{
				case AlignPolicy.HORIZONTAL:
					_XorY 			  = "x";
					_scrollDimension  = "width";
					_targetDimension  = "actualWidth";
				break;
				case AlignPolicy.VERTICAL:
					_XorY 			  = "y";
					_scrollDimension  = "height";
					_targetDimension  = "actualHeight";
				break;
			}
			
			_resize = true;
			
			//set the bounds to the mask width and height
			bounds     = new Rectangle(0,0,scrollBar.target.width,scrollBar.target.height);
			_scrollBar.scroller.addEventListener(DragEvent.DRAGGING,onDragging);
			
			//listen for when any components change in the scroll bar (buttons)
			_scrollBar.addEventListener(Event.ADDED,onTargetResize);
			_scrollBar.target.addEventListener(Event.ADDED,onTargetResize);
			_scrollBar.target.addEventListener(Event.RESIZE,onTargetResize);
		

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

			drawBounds();
			drawScroller();
			changeScrollerPosition();
			
			
			
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

		
		//-----------------------------------------------------------
		// 
		// Private Getters / Setters
		//
		//-----------------------------------------------------------
		
		/**
		 * returns the size of the content
		 */
		
		private function get targetSize():Number
		{
			return _scrollBar.target.target[ _targetDimension ];
		}
		
		
		/**
		 * returns the scroll bar's bounds, subtracting both more and less buttons
		 */
		 
		private function get scrollBarBounds():Rectangle
		{
			var rect:Rectangle = new Rectangle();
			rect[ _scrollDimension ] = _bounds[ _scrollDimension ] - _scrollBar.scrollLess[ _scrollDimension ] - _scrollBar.scrollMore[ _scrollDimension ];
			
			return rect;
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
		
		private function drawBounds():void
		{
			var newBounds:Rectangle;
			
			if(_scrollBar.scrollPolicy == AlignPolicy.HORIZONTAL)
			{
				newBounds = new Rectangle(0,0,_scrollBar.target.width - _scrollBar.scrollLess.width - _scrollBar.scrollMore.width,0);
				
				with(_scrollBar.scrollHolder.graphics)
				{
					clear();
					drawRect(0,0,newBounds.width,0);
				}
			
				_dragger.bounds 	    = newBounds;

			}
			else
			{

				newBounds = new Rectangle(0,0,0,_scrollBar.target.height - _scrollBar.scrollLess.height - _scrollBar.scrollMore.height);
				
				with(_scrollBar.scrollHolder.graphics)
				{
					clear();
					
					
					drawRect(0,0,0,newBounds.height);
				}

				_dragger.bounds 		 = newBounds;
			}
			
			
			_box.align();
			
		}
		
		private function drawScroller():void
		{

			if(bounds[ _scrollDimension ] <= 0)
				return;
			
			var diff:Number = targetSize / scrollBarBounds[ _scrollDimension ];

			if(_resize)
			{
				
				var Cy:Number = _scrollBar.target.target[ _XorY ];
				var Ch:Number = targetSize;
				var Bh:Number = _scrollBar.target[ _scrollDimension ];
			
				var Sy:Number = _scrollBar.scroller[ _XorY ];
				var Sh:Number = _scrollBar.scroller[ _scrollDimension ];
				var Mh:Number = _scrollBar.scrollMore[ _scrollDimension ];
				var Lh:Number = _scrollBar.scrollLess[ _scrollDimension ];
				var Sb:Number = Bh - Mh - Lh;
				
				
				if(targetSize > 0)
				{
					Sh = Sb*(Bh / Ch);
					//var cs = Sh;
					_scrollBar.scroller[ _scrollDimension ] = Sh;
				}
				

				

			}
			else
			{
				_scrollBar.scroller.scaleX = 1;
				_scrollBar.scroller.scaleY = 1;
			}
			if(_scrollBar.target[ _scrollDimension ] >= targetSize)
			{

				_scrollBar.visible = false;
				_scrollBar.target.target[ _XorY ] = 0;
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
			//make sure the scroll bar is not null because 0/{num} does not work
			if(_scrollBar.scroller[ _scrollDimension ] == 0 || _scrollBar.scroller[ _scrollDimension ] == Infinity)
				return;
			
			//drawBounds();
			
			var Cy:Number;
			var Ch:Number = targetSize;
			var Bh:Number = _scrollBar.target[ _scrollDimension ];
			
			var Sy:Number = _scrollBar.scroller[ _XorY ];
			var Sh:Number = _scrollBar.scroller[ _scrollDimension ];
			var Mh:Number = _scrollBar.scrollMore[ _scrollDimension ];
			var Lh:Number = _scrollBar.scrollLess[ _scrollDimension ];
			var Sb:Number = Bh - Mh - Lh;

			Cy = ( ((Ch - Bh) * Sy)/(Sb - Sh) );
			
			
			_scrollBar.target.target[ _XorY ] = -Cy;
		
		}

		
		/**
		 * change the position of the scroller if it exceeds the bounds (when resizing usually)
		 */
		
		private function changeScrollerPosition():void
		{
			
			if(_scrollBar.scroller[ _scrollDimension ] == 0 || _scrollBar.scroller[ _scrollDimension ] == Infinity)
				return;
				
			var Cy:Number = _scrollBar.target.target[ _XorY ];
			var Ch:Number = targetSize;
			var Bh:Number = _scrollBar.target[ _scrollDimension ];
			
			var Sy:Number = _scrollBar.scroller[ _XorY ];
			var Sh:Number = _scrollBar.scroller[ _scrollDimension ];
			var Mh:Number = _scrollBar.scrollMore[ _scrollDimension ];
			var Lh:Number = _scrollBar.scrollLess[ _scrollDimension ];
			var Sb:Number = Bh - Mh - Lh;
			
			
			if(Sh + Sy >= Sb && _scrollBar.visible)
			{
				_scrollBar.scroller[ _XorY ] = Sb - Sh;
				changeContentPosition();
				
			}
			else
			{
				Sy = ( ((Sb - Sh) * Cy)/(Ch - Bh));

			
				_scrollBar.scroller[ _XorY ] = -Sy;
			}
			
			
			

		}
		
		
		
	}
}