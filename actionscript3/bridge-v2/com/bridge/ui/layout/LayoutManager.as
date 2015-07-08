/*

layout manager handles children. some decorators cannot be applied
to particular DO's. example: box layout and contraints

*/

package com.bridge.ui.layout
{
	import com.bridge.events.LayoutManagerEvent;
	import com.bridge.events.StyleEvent;
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.layout.decor.DisplayObjectDecorLibrary;
	import com.bridge.ui.layout.decor.DisplayObjectDecorator;
	import com.bridge.ui.layout.decor.RefreshType;
	import com.bridge.ui.style.Style;
	import com.ei.utils.ArrayUtils;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	public class LayoutManager extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------
		
		private var _parentLayoutManager:LayoutManager;
		private var _targetDecoratorLibrary:DisplayObjectDecorLibrary;
		private var _childDecoratorLibrary:DisplayObjectDecorLibrary;
		private var _target:ILayoutManageable;
		private var _children:Array;
		private var _width:Number;
		private var _height:Number;
		
		
		private var _tried:Boolean;
		
		private var _targetStyle:Style;
		private var _refreshing:Boolean;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		public function LayoutManager(target:ILayoutManageable)
		{
			_target 	 			   = target;
			
			//quicker
			_children 			 	   = [];
			
			
			//initially, the child decorators are linked to the target decorator
			_childDecoratorLibrary = _targetDecoratorLibrary = new DisplayObjectDecorLibrary();
			
			
			//listen for when the target is added. If the parent is not a layoutManager then execute the target dec library
			
			_target.addEventListener(Event.REMOVED_FROM_STAGE,onTargetRemoved,false,0,true);
			
			if(DisplayObjectContainer(_target).parent)
			{
				onTargetAddedToStage();
			}
			else
			{
				_target.addEventListener(Event.ADDED_TO_STAGE,onTargetAddedToStage,false,999,true);
			}
			
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 * some display objects may only accept certain child decorators. box
		 */
		
		public function set childDecoratorLibrary(value:DisplayObjectDecorLibrary):void
		{
			_childDecoratorLibrary = value
		}
		
		public function get childDecoratorLibrary():DisplayObjectDecorLibrary
		{
			return _childDecoratorLibrary
		}
		
		/**
		 * for when the parent layout manager is not present, allow the ability
		 * to apply constraints
		 */
		 
		public function set targetDecoratorLibrary(value:DisplayObjectDecorLibrary):void
		{
			_targetDecoratorLibrary = value;
		}
		
		public function get targetDecoratorLibrary():DisplayObjectDecorLibrary
		{
			return _targetDecoratorLibrary;
		}
		
		/**
		 * some children may be nested in controller sprites
		 */
		
		public function get parentWidth():Number
		{
			
			var targ:DisplayObjectContainer = _target as DisplayObjectContainer;
			
			if(targ == targ.root)
			{
				return targ.stage.stageWidth;
			}
			
			
			return targ.parent.width;
		}
		
		/**
		 */
		
		public function get parentHeight():Number
		{
			var targ:DisplayObjectContainer = _target as DisplayObjectContainer;
			
			if(targ == targ.root)
			{
				return targ.stage.stageHeight;
			}
			
			return targ.parent.height;
		}
		/**
		 */
		public function registerTargetDecorator(decorator:DisplayObjectDecorator,position:int = -1):void
		{
			this._targetDecoratorLibrary.registerDecorator(decorator,position);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------

		
		/**
		 */
		
		public function get target():ILayoutManageable
		{
			return _target;
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------

		/**
		 */
		 
		public function registerChild(child:ILayoutManageable):void
		{
			
			_children.push(child);
			
			child.addEventListener(LayoutManagerEvent.CONSTRAINT_CHECK,onConstraintCheck);
			
		}
		
		
		/**
		 */
		
		public function unregisterChild(child:ILayoutManageable):void
		{
			_children = ArrayUtils.truncateByValue(_children,[child]);
			
			child.removeEventListener(LayoutManagerEvent.CONSTRAINT_CHECK,onConstraintCheck);
			
			
		}
		
		/**
		 */
		public function refreshTargetDecor():void
		{	
			
			refreshType(RefreshType.PARENT_RESIZE);
			
			invalidateChildDecorators();
			
		}
		
		/**
		 */
		 
		public function refreshChildDecor():void
		{
			
			refreshType(RefreshType.CHILD_ADDED);
			//invalidateChildDecorators();
		}
		
		
		
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		private function refreshType(type:String):void
		{
			
			for each(var decorator:DisplayObjectDecorator in _targetDecoratorLibrary.resizeDependent[type])
			{	
				
				decorator.currentTarget = _target as DisplayObjectContainer;
				decorator.ui_internal::draw();
			}
		}
		/**
		 */
		
		public function setStyle(style:Style = null):void
		{
			
			
			if(style != null)
			{
				if(_targetStyle)
					//listen for any changes in the style, then execute the decorators if a property is found
					_targetStyle.removeEventListener(StyleEvent.CHANGE,onStyleChange); 
				
				_targetStyle = style;
				
				//listen for any changes in the style, then execute the decorators if a property is found
				_targetStyle.addEventListener(StyleEvent.CHANGE,onStyleChange,false,99,true); 
			
			}
			
			 _targetDecoratorLibrary.getDecorators(this,_targetStyle);
			
			
			
			invalidateLMGlue();
			
			var styleData:Object = _targetStyle.toObject();
			
			
			
			for(var property:String in styleData)
			{
				_targetDecoratorLibrary.setProperty(this,property,styleData[property],false);
				
			}
			
		}
		
		/**
		 */
		private function invalidateLMGlue():void
		{
			if(!_refreshing && isReady())
			{
				_refreshing = true;
				
				_parentLayoutManager.removeEventListener(LayoutManagerEvent.REFRESH,onParentLayoutManagerRefresh);	
				_parentLayoutManager.addEventListener(LayoutManagerEvent.REFRESH,onParentLayoutManagerRefresh);	
			}
		}
		
		/**
		 */
		
		private var _ref:int;
		 
		private function onParentLayoutManagerRefresh(event:LayoutManagerEvent):void
		{
			this.refreshTargetDecorators();
		}
		
		
		
		
        /**
		 */
		
		private function onStyleChange(event:StyleEvent):void
		{
			_targetDecoratorLibrary.setProperty(this,event.property,event.value);
			
			this.refreshTargetDecorators();
			//text may not be ready
			invalidateLMGlue();
			
		}
		
		/**
		 */

		private function invalidateChildDecorators():void
		{
			
			//let the children handle the refreshing, because some children may not have decorators
			//that need to be refreshed. ex: refresh not needed for 1000 boxes
			dispatchEvent(new LayoutManagerEvent(LayoutManagerEvent.REFRESH,this));
			
			for each(var child:ILayoutManageable in _children)
			{
				//this could set unwanted properties, percentWidth from 50 to 100 etc.
				//child.layoutManager.targetDecoratorLibrary = this.childDecoratorLibrary;
				//child.refreshDecorators();
			}
			
			
		}
		
		/**
		 */
		private function onTargetRemoved(event:Event):void
		{
			event.target.removeEventListener(event.type,onTargetRemoved);
			
			if(_targetStyle)
			{
				_targetStyle.removeEventListener(StyleEvent.CHANGE,onStyleChange);
			}
			
			if(this._parentLayoutManager)
			{
				_parentLayoutManager.removeEventListener(LayoutManagerEvent.REFRESH,this.onParentLayoutManagerRefresh);
			}
		}
		
		/**
		 */
		
		private function onTargetAddedToStage(event:Event = null):void
		{
			if(event)
			{
				event.target.removeEventListener(event.type,onTargetAddedToStage);
			}
			
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
			//must be target on resize. if size changes contraints won't catch it.
			//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				
			var parent:DisplayObject = DisplayObjectContainer(_target).parent;
			
			
			//if the parent is not a layout manager then listen for a resize event. the Bridge UI
			//framework should not be dependant on classes extending UI Components.... Like flex
			
			_parentLayoutManager = checkRegistration(target);
			
			
			
			this.refreshTargetDecorators();
			
			if(!(parent is ILayoutManageable) && !_parentLayoutManager)
			{
				//dispatch the initial resize so we catch the size
				onParentResize();
				
				parent.addEventListener(Event.RESIZE,onParentResize,false,0,true);
				
			}
			
			
			
			
			
			
		}
		
		/**
		 */
		 
		private function ignoreTargetResize():void
		{
			
			target.removeEventListener(Event.RESIZE,onTargetResize);
			
		}
		
		/**
		 */
		 
		private function listenForTargetResize():void
		{
			ignoreTargetResize();
			
			target.addEventListener(Event.RESIZE,onTargetResize);
			
		}
		
		private function onTargetResize(event:Event):void
		{
			//FIXME: could cause runtime issues with boxing??
			
			this.refreshTargetDecorators();
		}
		
		/**
		 */
		private function onParentResize(event:Event = null):void
		{
			
			if(!event || event.target != DisplayObjectContainer(_target).parent)
			{
				return;
			}
			
			
			/*if(event && event.target == DisplayObjectContainer(_target).stage)
			{
				trace("LayoutManager::RESIZE");
			}
			else
			{
				trace("LayoutManager::Parent is not root, and does not have a layout manager",event.target.name,DisplayObject(_target).name);
			}
			*/
			
			
			this.refreshTargetDecorators();
			
			
		}
		
		
		
		/**
		 * use the child as a mediator to find if it's being contrained. If it is, then we
		 * don't want to listen for when the parent resizes
		 */
		 
		private function checkRegistration(target:ILayoutManageable):LayoutManager
		{
			var found:LayoutManager;
			
			function onConstraint(event:LayoutManagerEvent):void
			{
				found = event.layoutManager;
			}
			
			target.addEventListener(LayoutManagerEvent.HAS_CONSTRAINT,onConstraint);
			target.dispatchEvent(new LayoutManagerEvent(LayoutManagerEvent.CONSTRAINT_CHECK));
			target.removeEventListener(LayoutManagerEvent.HAS_CONSTRAINT,onConstraint);
			
			return found;
		}
		
		/**
		 */
		private function onConstraintCheck(event:Event):void
		{
			event.target.dispatchEvent(new LayoutManagerEvent(LayoutManagerEvent.HAS_CONSTRAINT,this));
		}
		
		/**
		 */
		private function isReady():Boolean
		{
			return _targetDecoratorLibrary.resizeDependent[RefreshType.PARENT_RESIZE] && 
				   _targetDecoratorLibrary.resizeDependent[RefreshType.PARENT_RESIZE].length > 0 &&
				   _parentLayoutManager;
		}
		
		/**
		 */
		
		private function refreshTargetDecorators()
		{
			this.ignoreTargetResize();

			this.listenForTargetResize();
		}
	}
}


	