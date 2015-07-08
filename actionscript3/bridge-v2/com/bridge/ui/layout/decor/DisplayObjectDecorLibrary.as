package com.bridge.ui.layout.decor
{
	import com.bridge.ui.core.ui_internal;
	import com.bridge.ui.layout.LayoutManager;
	import com.bridge.ui.style.Style;
	import com.ei.utils.ArrayUtils;
	
	import flash.display.DisplayObjectContainer;
	
	public class DisplayObjectDecorLibrary
	{
		//--------------------------------------------------------------------------
   	    //
        //  Private Variables
        //
        //--------------------------------------------------------------------------

		private var _decorators:Array;
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Variables
        //
        //--------------------------------------------------------------------------


        public var decoratorList:Array;
        public var resizeDependent:Object;
        public var properties:Object;
       	public var activeList:Array;
        
		
		//--------------------------------------------------------------------------
   	    //
        //  Constructor
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		 
		
		public function DisplayObjectDecorLibrary()
		{
			_decorators = new Array();
			properties  = new Object();
			resizeDependent = new Object();
			activeList = new Array();
			
			
		}
		
		//--------------------------------------------------------------------------
   	    //
        //  Public Methods
        //
        //--------------------------------------------------------------------------
        
        /**
		 */
		
		public function registerDecorator(decorator:DisplayObjectDecorator,index:int = -1):void
		{
			if(index == -1)
				_decorators.push(decorator);
			else
				ArrayUtils.insertAt(_decorators,decorator,index);
				
			
			
			for each(var property:String in decorator.properties)
			{
				properties[property] = decorator;
			}
			
		}
		
		/**
		 */
		public function enableAll():void
		{
			for each(var d:DisplayObjectDecorator in _decorators)
			{
				d.enabled = true;
			}
		}
		
		/**
		 */
		public function disable(...args:Array):void
		{
			var d:DisplayObjectDecorator;
			
			for each(var dec:Class in args)
			{
				d = this.getDecorator(dec);
				
				if(d)
					d.enabled = false;	
			}
		}
		
		/**
		 */
		public function allowOnly(...args:Array):void
		{
			var d:DisplayObjectDecorator;
			
			var cont:Boolean;
			
			for each(var d:DisplayObjectDecorator in _decorators)
			{
				for each(var dec:Class in args)
				{
					if(d is dec)
					{
						cont = true;
						break;
					}
				}
				
				if(!cont)
					d.enabled = false;
				
				cont = false;
			}
			
		}
		
		/**
		 * my brain is fried. fix this >shit<
		 */
		 
		public function setProperty(manager:LayoutManager,name:String,value:*,draw:Boolean = true):DisplayObjectDecorator
		{
			
			
			var decorator:DisplayObjectDecorator = properties[name];
			
			if(decorator)
			{
				
				
				
				if(!decorator.active)
				{
					trace("INACT",name,value);
					getDecorators(manager,manager.target.currentStyle);
					
					if(!decorator.active)
					{
						decorator.setProperty(name,value,false);
				
						return null;
					}
				}
				
				
				decorator.currentTarget = manager.target as DisplayObjectContainer; 
				decorator.setProperty(name,value,draw);
				
				if(draw)
				{
					decorator.ui_internal::draw();
				}
			}
			
			
			return decorator;
		}
		
		/**
		 */
		
		public function getDecorators(manager:LayoutManager,style:Style):void
		{
			
			
			
			var decorator:DisplayObjectDecorator;
			
			for(var i:int = 0; i < _decorators.length; i++)
			{
				
				decorator = _decorators[i];
				
				decorator.ui_internal::layoutManager = manager;
				var properties:Array = decorator.findProperties(style);
				
				
				if(properties)
				{
					
					registerActiveDecorator(decorator);
				}
			}
			
			
		}
		
		/**
		 */
		public function registerActiveDecorator(decorator:DisplayObjectDecorator):void
		{
			if(!decorator.active)
			{
				for each(var refreshType:String in decorator.refreshTypes)
				{
					if(!resizeDependent[refreshType])
						resizeDependent[refreshType] = new Array();
						
					resizeDependent[refreshType].push(decorator);
				}
				activeList.push(decorator);
			}
			decorator.active = true;
			
		}
		
		/**
		 */
		
		public function getDecorator(decorator:Class):DisplayObjectDecorator
		{
			for each(var dec:DisplayObjectDecorator in _decorators)
			{
				if(dec is decorator)
				{
					return dec;
				}
				
				
			}
			
			return null
		}
		
		
		
	}
}