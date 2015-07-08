package com.bridge.ui.layout2
{
	import com.addicted2flash.layout.LayoutType;
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.addicted2flash.layout.core.ILayoutContainer;
	import com.addicted2flash.layout.layouts.ILayout;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.layout2.decor.PercentRelativityDecorator;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	public class BoxLayout implements ILayout
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _subData:Dictionary;
		private var _target:UIComponent;
		
		private var _gap:Number;
		private var _alignment:String;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function BoxLayout(target:UIComponent,alignment:String="horizontal",gap:Number=5)
		{
			
			_alignment = alignment;
			_gap = gap;
			_subData = new Dictionary(true);
			_target  = target;
			
			target.addEventListener(Event.ADDED,onChildAdded);
			target.addEventListener("show",onChildAdded);
			target.addEventListener("hide",onChildAdded);
			this.scanChildren();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get alignment():String
		{
			return _alignment;
		}
		
		/**
		 */
		public function get gap():Number
		{
			return _gap;
		}

		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function trash():void
		{
			_target.removeEventListener(Event.ADDED,onChildAdded);
		}
		
        /**
		 */
		 
		public function get type():String
		{
			return LayoutType.PRE;
		}
		 
		/**
		 */
		
		
		//UGLY.
		
		private var _ig:Boolean;
		
		
		public function layoutContainer(container:ILayoutContainer):void
		{
			
			
			if(_ig)
				return;
			
			_ig = true;
			
			var lastPos:Number = 0;
			
			var ch:UIComponent;
			
			var constraintWidth:Number;
			var constraintHeight:Number;
			var oldPercent:Number;
			var newPercent:Number;
			
			if(_alignment == "horizontal")
			{
				var subDim:String = "subWidth";
				var percDim:String = "percentWidth";
			}
			else
			{
				var subDim:String = "subHeight";
				var percDim:String = "percentHeight";
				
			}
		
			for(var i:int = 0; i < container.componentCount; i++)
			{
				var child:ILayoutComponent = container.getComponentAt(i);
				
					
				
				
				var data:Object = _subData[child];
				
				
				constraintWidth  = _target.width;
				constraintHeight = _target.height;
				
				
				if(data && !isNaN(UIComponent(child)[percDim]))
				{
					
					ch = UIComponent(child);
					
					
					
					if(_alignment == "horizontal")
					{
						newPercent	    = ch.percentWidth / data.subPercWidth * 100;
						constraintWidth = (_target.width - lastPos - data.subWidth) * newPercent / 100;
						
						
						if(constraintWidth < 0)
							constraintWidth = 0;
							
						oldPercent = ch.percentWidth;
						ch.percentWidth = 100;
						
						child.setLayoutBounds(lastPos,ch.y,constraintWidth,constraintHeight);
						
						ch.percentWidth = oldPercent;
					
					}
					else
					{
						newPercent	    = ch.percentHeight / data.subPercHeight * 100;
						constraintHeight = (_target.height - lastPos - data.subHeight) * newPercent / 100;
						
						if(constraintHeight < 0)
							constraintHeight = 0;
							
						oldPercent = ch.percentHeight;
						ch.percentHeight = 100;
						
						child.setLayoutBounds(ch.x,lastPos,constraintWidth,constraintHeight);
						
						ch.percentHeight = oldPercent;
					}
					
					
				
				}
				else
				{
					if(_alignment == "horizontal")
						child.setLayoutBounds(lastPos,DisplayObject(child).y,DisplayObject(child).width,constraintHeight);
					else
						child.setLayoutBounds(DisplayObject(child).x,lastPos,constraintWidth,DisplayObject(child).height);
						
					
				}
				
				if(!DisplayObject(child).visible)
					continue;
					
				//if(child.layoutBounds.width == 0)
				//	continue;
				
				if(_alignment == "horizontal")
					lastPos += child.layoutBounds.width + _gap;
				else
					lastPos += child.layoutBounds.height + _gap;
			}
			
			_ig = false;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		//private function 
        /**
		 */
		
		private function onChildAdded(event:Event):void
		{
			trace(event.type);
			
			scanChildren();
		}
		
		/**
		 */
		private function scanChildren(event:Event = null):void
		{
			
			var lChild:UIComponent;
			var child:DisplayObject;
			
			_subData = new Dictionary(true);
			
			var curDimChild:DisplayObject;
			
			var cont:Boolean;
			
			var subWidth:Number;
			var subHeight:Number;
			
			subWidth = 0;
			subHeight = 0;
			
			
			for(var i:int = 0; i < _target.numChildren; i++)
			{
				cont = false;
				
				
				child = _target.getChildAt(i);
				
				
				if(!child.visible)
				{
					continue;
				}
				
				if(child is UIComponent)
				{
					
					
					lChild = child as UIComponent;
					
					var pWidth:Number  = lChild.percentWidth;
					var pHeight:Number = lChild.percentHeight;
					
					var wIsNaN:Boolean = isNaN(pWidth);
					var hIsNaN:Boolean = isNaN(pHeight);
					
					
					if(!wIsNaN || !hIsNaN)
					{
						if(wIsNaN) pWidth = 0;
						if(hIsNaN) pHeight = 0;
						
						for each(var sub:Object in _subData)
						{
							if(!isNaN(pWidth))
							{
								
								sub.subPercWidth  += pWidth;
								
							}
								
							if(!isNaN(pHeight))
							{
								sub.subPercHeight += pHeight;
								
							}
						}
						
						curDimChild = child;
						
						_subData[child] = new Object();
						_subData[child].subWidth      = 0;
						_subData[child].subHeight     = 0;
						_subData[child].subPercWidth  = pWidth;
						_subData[child].subPercHeight = pHeight;
						
						
					}
					
					
					
					
					
					if(!wIsNaN || !hIsNaN)
					{
						cont = true;
					}
				}
				
						
				for each(var sub:Object in _subData)
				{
					if(i < _target.numChildren -1)
					{
						subWidth  = _gap;
						subHeight = _gap;
					}
					else
					{
						subWidth = 0;
						subHeight = 0;
					}
					
					if(!cont)
					{
						subWidth += child.width;
						subHeight += child.height;
					}
					sub.subWidth  += subWidth;
					sub.subHeight += subHeight;

				}
				
				
				
			}
			
			
		}

	}
}