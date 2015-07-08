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
 

package com.bridge.ui.core
{
	import com.addicted2flash.layout.core.ILayoutComponent;
	import com.addicted2flash.layout.display.UILayoutContainer;
	import com.addicted2flash.layout.layouts.ILayout;
	import com.bridge.ui.controls.grid.ScrollableList;
	import com.bridge.ui.controls.media.audio.AudioFactory;
	import com.bridge.ui.layout.ILayoutManageable;
	import com.bridge.ui.layout2.ConstraintLayout;
	import com.bridge.ui.layout2.MultiLayout;
	import com.bridge.ui.layout2.NoLayout;
	import com.bridge.ui.layout2.decor.AlignmentDecorator;
	import com.bridge.ui.layout2.decor.ConstraintDecorator;
	import com.bridge.ui.layout2.decor.PercentRelativityDecorator;
	import com.bridge.ui.model.UIModel;
	import com.bridge.ui.skins.UISkin;
	import com.bridge.ui.style.Style;
	import com.ei.utils.info.ClassInfo;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	
	/**
	 * the UIComponent is the base class for all skinnable components for the Bridge Architecture.
	 */
	 
	public class UIComponent extends UILayoutContainer implements ILayoutManageable
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Variables
        //
        //--------------------------------------------------------------------------

		private var _model:UIModel;
		
		//listeners won't become detached
		private const UI_STYLE:Style = new Style();
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		
		private var _skin:UISkin;
		private var _view:Sprite;
		private var _skinStyle:Style;
		private var _styleName:String;
		private var _initialized:Boolean;
		private var _minWidth:Number;
		private var _minHeight:Number;
		private var _constraintLayout:ConstraintLayout;
		
		private var _multiLayout:MultiLayout;
		
		//holds all children
		private var _viewProxy:ViewProxy;
		
		private var _percentDecorator:PercentRelativityDecorator;
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
		
		/**
		 */	 
		
		public function UIComponent()
		{
			super();
			
			//the constraint layout is the core layout, that delegates changes to decorators as well
			//it cannot change
			 super.layout = _constraintLayout = new ConstraintLayout(this);
			 this.setDefaultLayout();
			
			_skinStyle = UI_STYLE.cloneAsBindedStyle();
			
			_model 	   = UIModel.getInstance();
			
			_viewProxy = new ViewProxy();
			
			this.invalidateLayoutDecorators();
			
			_styleName = new ClassInfo(this).name;
			
			
			addEventListener(Event.ADDED_TO_STAGE,onAddedToStage,false,999);
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Getters / Setters
        //
        //--------------------------------------------------------------------------
		
		private var _inc:int;
		
		/**
		 */
		 
		override public function set width(value:Number):void
		{
			
			if(width != value)
			{
				if(!isNaN(minWidth) && value < minWidth)
					value = minWidth;
				
				//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				//setting width and height to the SKIN property speeds up the framework *DRASTICALLY*
				//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
				
				//the stylename could be changed, so pass the new vals to the view
				if(_view)
					_skinStyle.setProperty("width",value);
				 else
					currentStyle.setProperty("width",value);
			}
			
		}

		override public function get width():Number
		{
			if(_view)
				return _skinStyle.getProperty("width");
			else
				return currentStyle.getProperty("width");
		}
		
		/**
		 */
		 
		override public function set height(value:Number):void
		{
			if(height != value)
			{
				if(!isNaN(minHeight) && value < minHeight)
					value = minHeight;
					
				if(_view)
					_skinStyle.setProperty("height",value);
				else
					currentStyle.setProperty("height",value);
			}
			
			
			//refresh();
			
		}
		
		override public function get height():Number
		{
			if(_view)
				return _skinStyle.getProperty("height");
			else
				return currentStyle.getProperty("height");
		}
		
		/**
		 */
		 
		/*override public function get x():Number
		{
			return currentStyle.getProperty("x");
		}
		
		override public function set x(value:Number):void
		{
			currentStyle.setProperty("x",value);
			
		}*/
		
		/**
		 */
		
		/*override public function get y():Number
		{
			return currentStyle.getProperty("x");
		}
		
		override public function set y(value:Number):void
		{
			currentStyle.setProperty("y",value);
		}*/
		
		
		
		/**
		 */
		
		public function get controlWidth():Number
		{
			return super.width;
		}
		
		/**
		 */
		
		public function set controlWidth(value:Number):void
		{
			super.width = value;
		}
		
		/**
		 */
		 
		public function get controlHeight():Number
		{
			return super.height;
		}
		
		/**
		 */
		
		public function set controlHeight(value:Number):void
		{
			super.height = value;
		}
		
		/**
		 */
		public function get minWidth():Number
		{
			return _minWidth;
		}
		
		/**
		 * FIX ME: put in a decorator
		 */
		
		public function set minWidth(value:Number):void
		{
			_minWidth = value;
		}
		
		/**
		 */
		
		public function get minHeight():Number
		{
			return _minHeight;
		}
		
		/**
		 */
		public function set minHeight(value:Number):void
		{
			_minHeight = value;
		}
		
		
		
		/**
		 */
		 
		public function get centerXPercent():Number
		{
			return currentStyle.getProperty("centerXPercent");
		}
		 
		public function set centerXPercent(value:Number):void
		{
			currentStyle.setProperty("centerXPercent",value);
		}
		
		/**
		 */
		 
		public function get centerYPercent():Number
		{
			return currentStyle.getProperty("centerYPercent");
		}
		 
		public function set centerYPercent(value:Number):void
		{
			currentStyle.setProperty("centerYPercent",value);
		}
	
		
		
		
		//----------------------
		// PercentRel
		//----------------------
		
		/**
		 */
		 
		public function set percentWidth(value:Number):void
		{
			currentStyle.setProperty("percentWidth",value);
		}
		
		public function get percentWidth():Number
		{
			return currentStyle.getProperty("percentWidth");
		}
		
		/**
		 */
		
		public function set percentHeight(value:Number):void
		{
			currentStyle.setProperty("percentHeight",value);
		}
		
		public function get percentHeight():Number
		{
			return currentStyle.getProperty("percentHeight");
		}
		
		/**
		 */
		
		public function set percentX(value:Number):void
		{
			currentStyle.setProperty("percentX",value);
		}
		
		public function get percentX():Number
		{
			return currentStyle.getProperty("percentX");
		}
		
		/**
		 */
		
		public function set percentY(value:Number):void
		{
			currentStyle.setProperty("percentY",value);	
		}
		
		public function get percentY():Number
		{
			return currentStyle.getProperty("percentY");
		}
		//----------------------
		// Constraints
		//----------------------
		
		/**
		 */
		 
		public function get left():Number
		{
			return currentStyle.getProperty("left");
		}

		public function set left(pos:Number):void
		{
			currentStyle.setProperty("left",pos);
		}
		
		/**
		 */
		
		public function get right():Number
		{
			return currentStyle.getProperty("right");
		}
		
		public function set right(pos:Number):void
		{
			
			currentStyle.setProperty("right",pos);
		}
		
		/**
		 */
		
		public function get top():Number
		{
			return currentStyle.getProperty("top");
		} 
		
		public function set top(pos:Number):void
		{
			currentStyle.setProperty("top",pos);
		}

		/**
		 */
		
		public function get bottom():Number
		{
			return currentStyle.getProperty("bottom");
		}
		
		public function set bottom(pos:Number):void
		{
			currentStyle.setProperty("bottom",pos);
		}
		
		/**
		 */
		
		public function get horizontalCenter():Number
		{
			return currentStyle.getProperty("horizontalCenter");
		}
		
		public function set horizontalCenter(pos:Number):void
		{
			currentStyle.setProperty("horizontalCenter",pos);
		}
		
		/**
		 */
		 
		public function get verticalCenter():Number
		{
			return currentStyle.getProperty("verticalCenter");
		}
		
		public function set verticalCenter(pos:Number):void
		{
			currentStyle.setProperty("verticalCenter",pos);	
		}
		
		
		/**
		 */
		
		override public function set visible(value:Boolean):void
		{
			super.visible = value;
			
			if(value)
				dispatchEvent(new Event("show",true));
			else
				dispatchEvent(new Event("hide",true));
			
			this.update();
			
		
		}
		
		/**
		 */
		
		/*override public function get visible():Boolean
		{
			return currentStyle.getProperty("visible");
		}*/
		
		
		/**
		 * the style (string) used by the current component
		 */
		 
		public function get style():String
		{
			return "";
		}
		
		/**
		 * @private
		 */
		 
		public function set style(value:String):void
		{
			currentStyle.digest(_model.styler.parseStyleBody(value));
		}
		
		/**
		 * the style used by the component
		 */
		 
		public function get currentStyle():Style
		{
			return UI_STYLE;
		}
		
		/**
		 */
		 
		override public function get numChildren():int
		{
			//trace(super.numChildren,_viewProxy.numChildren,_view,_skin,_viewProxy.target);
			
			if(!_view)
			{
				
				return super.numChildren;
			}
			else
			if(isContent)
			{
				
				return _skin.numChildren;
			}
			
			
			return this._viewProxy.numChildren;
		}
		
		
		/**
		 * returns true if the component has been added to the stage
		 */
		 
		public function get initialized():Boolean
		{
			return _initialized;
		}
		
		/**
		 */
		
		public function get isContent():Boolean
		{
			return _view == _skin;
		}
		

		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
		
		
		
		/**
		 */
		
		override public function set layout(layout:ILayout):void
		{
			_constraintLayout.controlLayout = layout;
		}
		
		/**
		 */
		
		override public function get layout():ILayout
		{
			return _constraintLayout;
		}
		
		//--------------------
		// Add / Remove child
		//--------------------
		
		/**
		 */
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			link(child);
			
			var child:DisplayObject = _viewProxy.addChild(child);
			
			
			if(this.layout)
				this.layout.layoutContainer(this);
			
			return child;
		}
		
		/**
		 */
		
		override public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			link(child);
			
			var child:DisplayObject = _viewProxy.addChildAt(child,index);
			
			return child; 
		}
		
		/**
		 */
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			
			delink(child);
			
			
			return _viewProxy.removeChild(child);
		}
		
		/**
		 */
		
		override public function removeChildAt(index:int):DisplayObject
		{
			
			var child:DisplayObject = this.getChildAt(index);
			
			delink(child);
			
			new ScrollableList
			
			return _viewProxy.removeChildAt(index);
		}
		
		/**
		 */
		override public function getChildAt(index:int):DisplayObject
		{
			return _viewProxy.getChildAt(index);
		}
		
		/**
		 */
		override public function getChildIndex(child:DisplayObject):int
		{
			return _viewProxy.getChildIndex(child);
		}
		
		/**
		 */
		 
		override public function contains(child:DisplayObject):Boolean
		{
			return _viewProxy.contains(child);
		}
		
		
		
		
		/**
		 */
		public function update():void
		{
			this.validate();
			
			if(this.parentContainer)
				this.parentContainer.validate();
				
			
		}
		
		
		/**
		 */
		
		public function removeAllChildren():void
		{
			_viewProxy.removeAllChildren();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
       
		
        /**
		 */
		 
		ui_internal function set skin(value:UISkin):void
		{
			_skin = value;
			_skin.ignoreChanges = true;
		}
		
		ui_internal function get skin():UISkin
		{
			return _skin;	
		}
		
		
        /**
		 */
		ui_internal function set view(value:Sprite):void
		{
			//trace(this.layoutvalue);
			
			var oldLayout:ILayout = this._constraintLayout.controlLayout;
			
			if(_view is UIComponent)
				UIComponent(_view).setDefaultLayout();
			
			_view = value;
			
			//set the view layout, and restart the old view layout
			if(_view is UIComponent)
			{
				UIComponent(_view).layout = oldLayout;
			}	
			
			if(this.initialized)
			{
				trace("UIComponent reset view proxy()");
				this._viewProxy.target = value;
			}
		}
		
		ui_internal function get view():Sprite
		{
			return _view;
		}
		
		
		
		
		/**
		 */
		ui_internal function get numControllerChildren():int
		{
			return super.numChildren;
		}
		
        /**
		 */
		 
		ui_internal function addControllerChild(child:DisplayObject):DisplayObject
		{
			return super.addChild(child);
		}
		
		/**
		 */
		 
		ui_internal function addControllerChildAt(child:DisplayObject,index:int):DisplayObject
		{
			return super.addChildAt(child,index);
		}
		
		/**
		 */
		 
		ui_internal function removeControllerChild(child:DisplayObject):DisplayObject
		{
			return super.removeChild(child);
		}
		
		/**
		 */
		
		ui_internal function controllerContains(child:DisplayObject):Boolean
		{
			
			return super.contains(child);
		}
		
		/**
		 */
		ui_internal function pauseSkinChanges():void
		{
			_ignore = true;
			
		}
		
		/**
		 */
		ui_internal function resumeSkinChanges():void
		{
			
			_ignore = false;
			refresh();
			
		}
		
		private var _ignore:Boolean;
		
		/**
		 */
		protected function refresh():void
		{
			if(!_ignore && _skin)
			{
				_skin.refresh();
			}
		}
		
		/**
		 * sets the style name of the component, along with the colors/skins associated with it
		 */
		 
		public function set styleName(value:String):void
		{
			_styleName = value;
			
			
			
			
			
			//get the wanted style
			var newStyle:Style = _model.styler.getStyle(value);
			
			
			
			this.ui_internal::pauseSkinChanges();
			
			
			//combine the two styles, but the base style must be dominant
			this.currentStyle.digest(newStyle);
			
			
			this.ui_internal::resumeSkinChanges();
			
		
			
		}
		
		/**
		 */
		 
		public function get styleName():String
		{
			return _styleName;
		}
		
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		protected function init():void
		{	
			new AudioFactory
			
			this.invalidateStyle();
			
			//set the style BEFORE invalidating the skin because variables such as percentWidth and percentHeight
			//need to set the width to be passed to the skin
			//_layoutManager.setStyle(this.currentStyle.cloneAsBindedStyle());
			
			this.invalidateSkin();
			
			this.invalidateStyle();
			
			
			_initialized = true;
			
			
			
			
			_viewProxy.target = _view;
			
			
			
			
		}
		
		/**
		 */
		
		protected function invalidateLayoutDecorators():void
		{
			
			var layout:ConstraintLayout = this.layout as ConstraintLayout;
			
 			layout.registerConstraint(new PercentRelativityDecorator());
			layout.registerConstraint(new ConstraintDecorator());
			layout.registerConstraint(new AlignmentDecorator());
			
			
			
		}
		
		/**
		 */
		protected function get viewProxy():ViewProxy
		{
			return _viewProxy;
		}
		
		
		/**
		 * returns the view that the children are added to
		 */
		
		
		protected function get nestedView():UIComponent
		{
			
			//make sure the view is a UIComponent and not the skin
			if(_view is UIComponent && UIComponent(_view).ui_internal::view is UIComponent)
			{
				
				return UIComponent(_view).nestedView;
			}
			else
			{
				return _view as UIComponent;
			}
			
			
		}

		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onAddedToStage(event:Event):void
		{
			event.target.removeEventListener(event.type,onAddedToStage);
			
			
			if(!initialized)
				init();
			
		}
		
		/**
		 */
		private function onParentResize(event:Event = null):void
		{
			
			if(event && event.target != this.parent)
				return;
				
			
			
			ui_internal::refreshDecorators();
		}
		
		/**
		 */
		
		
		private function invalidateSkin():void
		{
			
			if(ui_internal::skin)
			{
				ui_internal::removeControllerChild(ui_internal::skin as Sprite);
			}
			
			var newSkin:Object = currentStyle.getProperty("skin");
			
			if(newSkin is Class)
			{
				ui_internal::skin = new newSkin(this,_skinStyle);
			}
			else
			{
				
				ui_internal::skin = newSkin as UISkin;
			}
			
			
			_initialized = true;
			//finalization
			ui_internal::addControllerChild(ui_internal::skin as Sprite);
			
			
			
		}
		
		
		/**
		 */
		private function invalidateStyle():void
		{
			//inherit the initial styles
			var style:Style = _model.styler.getStyleByInstance(this,true);
			
			
			currentStyle.digestNoCopies(style);
			
			
		}
		
		
		
		
		
		/**
		 */
		
		protected function link(child:DisplayObject):void
		{
			if(child is ILayoutComponent && isContent)
			{
				
				this.addComponent(child as ILayoutComponent);
				
				
				
				child.addEventListener(Event.REMOVED_FROM_STAGE,onChildRemoved);
				
			}
			else
			{
				
				//trace("UIComponent:: not a UI Component, or not the skin-",child);
			}
			
			
			//DO NOT refresh child decorators
			
			
			
		}
		
		
		/**
		 */
		 
		protected function delink(child:DisplayObject):void
		{
			if(this.containsComponent(child as ILayoutComponent))
			{
				this.removeComponent(child as ILayoutComponent);
			}
		}
		
		/**
		 * resets to the default layout. used when setting the view
		 */
		 
		protected function setDefaultLayout():void
		{
			_constraintLayout.controlLayout = new NoLayout();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		private function onChildRemoved(event:Event):void
		{
			event.target.removeEventListener(event.type,onChildRemoved);
			
			delink(event.target as DisplayObject);
		}
		
		
		
	}
}