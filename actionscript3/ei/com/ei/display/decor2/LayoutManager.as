 //NOTE: because ase uses bubbles for event listeners, something we don't want, we have the layout manager
//dispatch an event to all children for object decorators

//the layout manager is yet another framework that is modular and acts as the cente point for all handles to
//connect to


package com.ei.display.decor2
{
	import com.ei.events.DisplayObjectDecoratorEvent;
	import com.ei.ui2.core.UIComponent;
	import com.ei.utils.ArrayUtils;
	import com.ei.utils.ParentType;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class LayoutManager
	{
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		//the width of the UIComponent
		private var _width:Number;
		
		//the height of the UIComponent
		private var _height:Number;
		
		//the target UIComponent
		private var _targetParent:ParentType;
		
		private var _target:UIComponent;
		
		
		//the deorators assigned to each of the children if they have any
		private var _decorators:Array;
		
		
		//the children of the UIComponent
		private var _children:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function LayoutManager(target:UIComponent)
		{
			_target     = target;
			_decorators = new Array();
			_children   = new Array();
			
			target.addEventListener(Event.ADDED_TO_STAGE,onTargetAdded);
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function set width(value:Number):void
		{
			_width = value;
			
			invalidateChildDecorators();
		}
		
		public function get width():Number
		{
			return _width;
		}
		
		/**
		 */
		
		public function get parentWidth():Number
		{
			return _targetParent.width;
		}
		
		/**
		 */
		
		public function set height(value:Number):void
		{
			_height = value;
			
			invalidateChildDecorators();
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		/**
		 */
		
		public function get parentHeight():Number
		{
			return _targetParent.height;
		}
		
		/**
		 */
		
		public function get children():Array
		{
			return _children;
		}
		
		/**
		 */
		
		/*public function get target():ParentType
		{
			
			return _targetParent;
		}*/
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		 
		public function registerChild(child:UIComponent):void
		{
			_children.push(child);
			listenForChildChanges(child);
			
			
		}
		
		/**
		 */
		
		public function registerChildAt(child:UIComponent,index:int):void
		{
			_children = ArrayUtils.insertAt(_children,child,index);
			listenForChildChanges(child);
			
			
		}
		
		/**
		 */
		
		public function unregisterChild(child:UIComponent):void
		{
			var index:int = _children.indexOf(child);
			
			unregisterChildAt(index);
		}
		
		/**
		 */
		
		public function unregisterChildAt(index:int):void
		{
			
			var child:DisplayObject = _children[index];
			
			
			_children = ArrayUtils.truncate(_children,[index]);
			
			
			child.removeEventListener(DisplayObjectDecoratorEvent.NEW_DECORATOR,onNewChildDecorator);
			
			
			//unglue each decorator so they do not refresh anymore
			for each(var decorators:Array in _decorators[child])
			{
				for each(var decorator:DisplayObjectDecorator in decorators)
				{
					decorator.unglue();
				}
			}
			delete _decorators[child];
		}
		
		
		/**
		 */
		
		public function refreshDecorators():void
		{
			this.invalidateDecorators();
		}
		
		
		
		/**
		 */
		
		public function registerDecorator(decorator:DisplayObjectDecorator):void
		{
			
		}
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
		
		
		/**
		 */
		
		private function onChildResize(event:Event):void
		{
			//event.stopImmediatePropagation();
			
			var child:DisplayObject = event.target as DisplayObject;
			
			
			
			//invalidateChildDecor(child,_decorators[child]);
			
			
			
			//if(_targetParent.resizeableObject)
				//_targetParent.resizeableObject.dispatchEvent(new Event(Event.RESIZE));
		}
		
		/**
		 */
		
		private function invalidateDecorators():void
		{
			for each(var decorator:DisplayObjectDecorator in _decorators)
			{
				decorator.refresh();
			}
			
			
			
		
		}
		
		private function invalidateChildDecorators():void
		{
			for each(var child:UIComponent in _children)
			{
				invalidateChildDecor(child);
			}
		}
		
		private function invalidateChildDecor(child:UIComponent):void
		{
			
			//we want ti ignore the children because they dispatch events
			//and we only want to listen to the children when there is a change made the parent
			//did not invoke
			ignoreChildChanges(child);
			
			child.refreshDecorators();
			
			listenForChildChanges(child);
		}
		
		/**
		 */
		
		private function listenForChildChanges(child:DisplayObject):void
		{
			child.addEventListener(Event.RESIZE,onChildResize);
			
		}
		
		private function ignoreChildChanges(child:DisplayObject):void
		{
			child.removeEventListener(Event.RESIZE,onChildResize);
		}
		
		
		/**
		 */
		
		private function onNewChildDecorator(event:DisplayObjectDecoratorEvent):void
		{
			
			
			if(_decorators.indexOf(event.decorator) == -1)
			{
				event.decorator.glue(this);
				
				
				if(event.index == -1)
					_decorators.push(event.decorator);
				else
				{
					_decorators = ArrayUtils.insertAt(_decorators,event.decorator,event.index);	
				}
			}
		}
		
		/**
		 */
		
		private function onRemoveDecorator(event:DisplayObjectDecoratorEvent):void
		{
			
			var index:int = _decorators.indexOf(event.decorator);
			
			if(index > -1)
				_decorators = ArrayUtils.truncate(_decorators,[index]);
		}
		
		
		/**
		 */
		
		private function onTargetAdded(event:Event = null):void
		{
			event.target.removeEventListener(event.type,onTargetAdded);
			
			
			_targetParent     = new ParentType(_target);
			
			_target.addEventListener(DisplayObjectDecoratorEvent.DECORATOR_RESPONSE,onNewChildDecorator);
			_target.addEventListener(DisplayObjectDecoratorEvent.REMOVE_RECORATOR,onRemoveDecorator);
			_target.dispatchEvent(new DisplayObjectDecoratorEvent(DisplayObjectDecoratorEvent.DECORATOR_REQUEST));
		}
		
	}
}