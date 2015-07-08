package com.bridge.ui.layout2
{
	import com.addicted2flash.layout.LayoutType;
	import com.addicted2flash.layout.core.ILayoutContainer;
	import com.addicted2flash.layout.layouts.ILayout;
	import com.bridge.events.StyleEvent;
	import com.bridge.ui.core.UIComponent;
	import com.bridge.ui.layout2.decor.DisplayObjectDecorator;
	import com.ei.utils.ArrayUtils;
	
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	public class ConstraintLayout implements ILayout
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _constraints:Object;
		private var _childSize:int;
		private var _target:UIComponent;
		private var _activeDecorators:Array;
		private var _children:Array;
		private var _controlLayout:ILayout;
		private var _previousSize:Rectangle;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function ConstraintLayout(target:UIComponent)
		{
			_children = new Array();
			_constraints = new Object();
			_activeDecorators = new Array();
			_target = target;
			
			target.addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		/**
		 */
		
		public function set controlLayout(value:ILayout):void
		{
			_controlLayout = value;
		}
		
		public function get controlLayout():ILayout
		{
			return _controlLayout;
		}
		
		/**
		 */
		
		public function get type():String
		{
			return LayoutType.PRE;
		}
		
		/**
		 */
		
		public function get constraints():Object
		{
			return _constraints;
		}
		
		/**
		 * FIXME: neds to work with non-layout containers
		 */
		 
		public function get target():UIComponent
		{
			return _target as UIComponent;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        
        /**
		 */
		
		public function registerConstraint(constraint:DisplayObjectDecorator,index:int=-1):void
		{
			
			for each(var property:String in constraint.acceptedProperties)
			{
				
				_constraints[property] = {constraint:constraint,index:index};
				
				
				if(_target.currentStyle.getProperty(property))
				{
					setProperty(property,_target.currentStyle.getProperty(property));
				}
				
				_target.currentStyle.addEventListener(StyleEvent.wrapAsEvent(property),onConstraintProperty);
			}
			
		}
		
		private var i:int = 0;
		private var _ig:Boolean;
		
        /**
		 */
		
		public function layoutContainer(c:ILayoutContainer):void
		{
			
			//FIXME: check out setting X / Y prop
			if(_ig)
				return;
			
			
			_ig = true;
			
			
			for each(var decor:DisplayObjectDecorator in _activeDecorators)
			{
				decor.target = _target;
				
				decor.layoutComponent(_target);
			}
			
			
			
			
			_previousSize = _target.layoutBounds.clone();
			
			
			//we do NOT want the bounds to refresh
			_target.layoutBounds.width  = _target.width;
			_target.layoutBounds.height = _target.height;
			_target.layoutBounds.x      = _target.x;
			_target.layoutBounds.y      = _target.y;
			
			var layoutBounds:Rectangle = _target.layoutBounds.clone();
			
			
			if(this._controlLayout)
			{
				this._controlLayout.layoutContainer(_target);
			}
			
			
			
			//revert so that the layout bounds don't shrink
 			_target.layoutBounds.width  = _previousSize.width;
			_target.layoutBounds.height = _previousSize.height;
			
			_ig = false;
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onConstraintProperty(event:StyleEvent):void
		{
			
			//trace("ConstraintLayout:change()");
			
			setProperty(event.property,event.value);
			
			
			layoutContainer(_target);

			
			
		}
		
        /**
		 */
		
		private function setProperty(name:String,value:Object):void
		{
			
			var constraintInfo:Object = constraints[name];
			
			var decorator:DisplayObjectDecorator = constraintInfo.constraint;
			
			var index:int 	= constraintInfo.index;
			
			decorator[name] = value;
			
			if(decorator.isReady && _activeDecorators.indexOf(decorator) == -1)
			{
				if(index == -1)
					_activeDecorators.push(decorator);
				else
					ArrayUtils.insertAt(_activeDecorators,decorator,index);
			}
			
		}
		
		/**
		 */
		
		private function onAddedToStage(event:Event):void
		{
			event.target.removeEventListener(event.type,onAddedToStage);
			
			
			
			//some constrained objects may not have a parent controlling them
			//so listen for on parent resize. This applies to the ROOT display object, as well as
			//UI Components in skins (which aren't constricted)
			if(!_target.parentContainer)
			{
				onParentResize();
				_target.parent.addEventListener(Event.RESIZE,onParentResize);
			}
			
		}
		
		/**
		 */
		
		private function onParentResize(event:Event = null):void
		{
			
			if(event && event.target != _target.parent)
			{
				trace("ConstraintLayout::FIX PROPAGATING ISSUES");
			}
			
			var dimW:String = "width";
			var dimH:String = "height";
			
			if(_target.parent == _target.stage)
			{
				dimW = "stageWidth";
				dimH = "stageHeight";
			}
			
			
			var newBounds:Rectangle = new Rectangle(_target.x,_target.y,_target.parent[dimW],_target.parent[dimH]);
			
			_target.layoutBounds = newBounds;
		}

	}
}