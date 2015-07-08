package com.ei.display.decor2
{
	import com.ei.ui.core.EUIComponent;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	public class BoxDecorator extends DisplayObjectDecorator
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _gap:Number;
		private var _align:String;
		private var _scaler:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function BoxDecorator(target:DisplayObjectContainer)
		{
			super(target);
			_gap = 0;
		}
		
		
		/**
		 */
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set alignment(value:String):void
		{
			
			
			if(value ==  BoxAlign.HORIZONTAL)
			{
				_scaler = "width";
				_align  = "x"
			}
			else
			if(value == BoxAlign.VERTICAL)
			{
				_scaler = "height";
				_align  = "y"
			}
			else
			{
				isReady = false;
				return;
			}
			
			isReady = true;
		}
		
		public function get alignment():String
		{
			return _align;
		}
		
		/**
		 */
		
		public function set padding(value:Number):void
		{
			_gap = value;	
		}
		
		public function get padding():Number
		{
			return _gap;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		override protected function refresh2():void
		{
			
			var nextPosition:Number = 0;
			var child:DisplayObject;
			
			var spChild:EUIComponent;
			var sumWidth:Number = 0;
			var sumHeight:Number = 0;
			var sumPercentWidth:Number = 0;
			var sumPercentHeight:Number = 0;
			var numChildrenPercW:int;
			var numChildrenPercH:int;
			var start:Boolean = false;
			
			
			/*for(var i:int = 0; i < target.numChildren; i++)
			{
				child = target.getChildAt(i);
				
				if(child is EUIComponent)
				{
					spChild = EUIComponent(child);
					
					specialChildren.push(child);
					
					spChild.constraints.disable();
					spChild.aligner.disable();
					
					if(!isNaN(spChild.percentWidth))
					{
						numChildrenPercW++;
						start = true;
						
						sumPercentWidth = spChild.percentWidth;
					}
				
					if(!isNaN(spChild.percentHeight))
					{
						numChildrenPercH++;
						
						sumPercentHeight = spChild.percentHeight;
						//start = true;

					}
					else
					if(start)
					{
						sumWidth += Math.abs(spChild.width)  + _gap;
						
						sumHeight += Math.abs(spChild.height) + _gap;
					}
					
				}
			}*/
			
			
			//some of the children could have values that exceed 100%
			//for instance 3 children all with 100% should be split up to
			//33.333% 
			sumPercentWidth = (sumPercentWidth-100)/numChildrenPercW;
			
			for(var i:int = 0; i < target.numChildren; i++)
			{
				child = target.getChildAt(i);
				
				
				
				if(child is EUIComponent)
				{
					if(_align == "x")
					{
						if(EUIComponent(child).percentWidth == 100)
							EUIComponent(child).percentRel.subtractPercentWidth = sumDimAhead(i+1);
					}
					else
					{
						
						EUIComponent(child).percentRel.subtractPercentHeight = sumDimAhead(i+1);
						
					}
					
					//sumWidth = 0;
					//sumHeight = 0;
					
				}
				
				/*
				if(child is EUIComponent)
				{
					handleUIComponent(child);
					
				}*/
				
				
				
				child[ _align ] = nextPosition;
				
				//trace(_align,child,child[ _scaler ],nextPosition);
				nextPosition = nextPosition + child[ _scaler ] + _gap;
			}
		}
		
		/**
		 */
		
		private function sumDimAhead(index:int):Number
		{
			var sum:Number =0;
			
			var child:DisplayObject;
			for(var i:int = index; i < target.numChildren; i++)
			{
				child = target.getChildAt(i);
				
				sum += child[_scaler]+_gap;	
			}
			
			
			return sum;
		}
		
	}
}