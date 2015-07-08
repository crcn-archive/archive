package com.bridge.ui.style
{
	import com.bridge.events.StyleEvent;
	import com.ei.utils.ObjectUtils;
	
	import flash.events.EventDispatcher;
	
	/**
	 * the style data used by all components in the UI
	 */
	 
	public class Style extends EventDispatcher
	{
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _styles:Object;
		protected var _binds:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var requiredParents:Array;
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function Style()
		{
			_styles = new Object();
			_binds  = new Array();
			requiredParents = new Array();
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        public function setStyle(style:Style):void
        {
        	
        	for each(var bind:EventDispatcher in _binds)
        	{
        		bind.removeEventListener(StyleEvent.CHANGE,onStyleChange);
        	}
        	
        	_binds = new Array();
        	
        	for each(var styleParent in style._binds)
        	{
        		this.bindStyle(styleParent);	
        	}
        	
        	digest(style);
        	
        	
        }
        
        
        
        /**
         * takes in a style and executes the values
		 */
		 
		public function digest(style:Style):void
		{
			
			if(!style)
				return;
				
			for(var property:String in style.styles)
			{
				this.setProperty(property,style.styles[property]);
			}
		}
		
		/**
		 */
		 
		public function digestNoCopies(style:Style):void
		{
			if(!style)
				return;
				
			for(var property:String in style.styles)
			{
				if(this.getProperty(property))
					continue;
				
				this.setProperty(property,style.styles[property]);
			}
		}
		
        /**
		 */
		 
		public function push(style:Object):void
		{
			ObjectUtils.copy(style,_styles);
		}
		
		/**
		 */
		
		public function toObject():Object
		{
			var object:Object = new Object();
			
			
			ObjectUtils.copy(_styles,object);
			
			return object;
		}
		
        /**
		 */
		 
		public function setProperty(name:String,value:*,dispatch:Boolean = true):void
		{
			_styles[name] = value;
			
			if(dispatch)
			{
				dispatchEvent(new StyleEvent(StyleEvent.wrapAsEvent(name),name,value));
				
				dispatchEvent(new StyleEvent(StyleEvent.CHANGE,name,value));
			}
		}
		
		/**
		 */
		 
		public function getProperty(name:String):*
		{
			
			var prop:* = _styles[name];
			
			return prop;
		}
		
        /**
		 */
		
		public function containsKey(name:String):Boolean
		{
			return _styles[name] != undefined;
		}
		
		/**
		 */
		
		public function remove(name:String):void
		{
			_styles[name] = undefined;
		}
		
	
		/**
		 */
		 
		public function clone():Style
		{
			var style:Style = new Style();
			
			for(var prop:String in _styles)
			{
				style.setProperty(prop,_styles[prop],false);
			}
			
			return style;
		}
		
		/**
		 * binded style ensures that any given style can be passed to a listener
		 * but the listener cannot create changes to the ROOT style. for example:
		 * width as NaN would set the width of a skin according to the dimensions
		 * of its children.
		 */
		public function cloneAsBindedStyle():Style
		{
			var clone:Style = this.clone();
			clone.bindStyle(this);
			return clone;
		}
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Protected Methods
        //
        //--------------------------------------------------------------------------
        
        /**
         * only available to the Style class for digest, and any other use between
         * to styles internally
		 */
		 
		protected function get styles():Object
		{
			return _styles;
		}
		
		
		
		//--------------------------------------------------------------------------
   	    //
        //  Private Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		protected function bindStyle(style:Style):void
		{
			_binds.push(style);
			
			style.addEventListener(StyleEvent.CHANGE,onStyleChange,false,0,true);
		}
		
        /**
		 */
		
		private function onStyleChange(event:StyleEvent):void
		{
			this.setProperty(event.property,event.value);
		}

	}
}